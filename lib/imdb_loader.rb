class IMDBLoader
  attr_accessor :base_url
  BASE_DETAILS_DIR = "#{Rails.root}/data/movie_details/"
  BASE_POSTER_DIR  = "#{Rails.root}/public/movie_posters/"

  def initialize
    @base_url = "http://www.omdbapi.com/"
  end

  def fetch movie
    # lets see if we already have the movie details on the fs
    title_as_md5 = movie.title_as_md5

    FileUtils.mkdir_p "#{BASE_DETAILS_DIR}/#{movie.details_directoy_name}"
    puts "trying to fetch:[#{movie.title}] (#{movie.id}) : #{title_as_md5}"
    output_fname = BASE_DETAILS_DIR+movie.details_filename

    # don't bother we already have it and its not zero length
    if File.exists?(output_fname) && (File.stat(output_fname).size!=0)
      puts "skipping.. file exists: #{output_fname}"
      movie.update_attribute(:title_md5, movie.title_as_md5) if movie.title_md5.nil?

      return false
    end

    # nope, no json file. go get it from the net
    omdb_url = "#{@base_url}?t=#{movie.title}"
    omdb_url += "&y=#{movie.released_at.year}" if movie.released_at
    #puts "url: #{omdb_url}"
    res = Curl::Easy.http_get URI::escape(omdb_url)
    result = JSON.parse res.body_str

    # failed? let's try again without the year (as it might be wrong date from movielens)
    if result["Response"] == "False"
      res = Curl::Easy.http_get URI::escape("#{@base_url}?t=#{movie.title}")
      result = JSON.parse res.body_str
      if result["Response"] == "False"
        puts "can't find movie from omdb: [#{movie.title}]"
        return false
      end
    end

    # save this json blob to the filesystem, we might want to process this a bit more later
    File.open(output_fname, "w") {|f| f.write res.body_str.force_encoding('UTF-8') }
    movie.update_attribute :title_md5, movie.title_as_md5
    true
  end

  def load movie
    # do we already have this movie_details reference?
    return false if MovieDetails.where(movie_id:movie.id).first


    details = JSON.parse IO.read(BASE_DETAILS_DIR+movie.details_filename)
    save_details movie, details
    return true
  end

  def fetch_poster movie
    output_fname = BASE_POSTER_DIR+movie.poster_filename
    #puts "trying to fetch:[#{movie.title}] (#{movie.id}) : #{output_fname}"
    FileUtils.mkdir_p BASE_POSTER_DIR+movie.details_directoy_name

    if File.exists?(output_fname) && (File.stat(output_fname).size!=0)
      #puts "skipping.. file exists: #{output_fname}"

      return false
    end

    poster_url = movie.movie_details.poster
    return if poster_url == "N/A" # TODO we should rethink this. cleanup data

    puts "getting poster [#{movie.title}] , url: #{poster_url}"
    res = Curl::Easy.http_get poster_url
    # throw "bad_return_for_fetch_poster_(#{res.response_code})" if res.response_code != 200

    File.open(output_fname, "w") {|f| f.write res.body_str.force_encoding("UTF-8") }
  end


  def save_details movie, details
    if (details["Poster"] == 'N/A') || (details["Plot"] == 'N/A')
      # meh there's not much info, lets remove it from the listing
      movie.update_attribute :title_md5, nil
    end

    attribs = { movie_id:movie.id, released_at:details["Released"],
                imdbID:details["imdbID"], plot:details["Plot"],
                poster:details["Poster"].gsub(/SX300/,'SX200') }

    attribs[:runtime] = details["Runtime"] unless details["Runtime"] == 'N/A'

    MovieDetails.create attribs
  end
end