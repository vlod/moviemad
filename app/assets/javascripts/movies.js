$(document).ready(function(){
  $(".movie_entry").click(function(e) {
    e.preventDefault();
    var movie_id = $(this).data("movie-id");
    // console.log("you clicked: "+movie_id+" md: "+"movie_details_"+movie_id);

    var movie_details = $("#movie_details_"+movie_id);
    // console.log("movie_details.length : "+movie_details.length );
    if (movie_details.length == 1) {
       movie_details.toggle();
    }
    else {
      $.get('movies/'+movie_id+'.json', function(data) {
        $("li#m_"+movie_id).append(HoganTemplates['movie_item'].render(data));
      });
    }

  });
});