class MovieService < ApiService
  def self.top_movies
    endpoint = "https://api.themoviedb.org/3/discover/movie?api_key=#{ENV["movies_secret"]}&language=en-US&sort_by=vote_average.desc&include_adult=false&include_video=false"
    parsed_top_rated = get_data(endpoint)
    parsed_top_rated[:results].map do |movie|
      Movie.create(title: movie[:title])if Movie.find_by(title: movie[:title]).nil?
    end.compact
  end


  def self.search_movie(title)
    search_endpoint = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV["movies_secret"]}&language=en-US&query=#{title}"
    parsed_search = get_data(search_endpoint)
    parsed_search[:results].map do |movie|
      Movie.create(title: movie[:title]) if Movie.find_by(title: movie[:title]).nil?
    end.compact
  end
end