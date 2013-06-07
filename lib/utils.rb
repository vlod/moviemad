module Utils
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def md5 text
      Digest::MD5.hexdigest "movie-mad-#{text}"
    end
  end
end