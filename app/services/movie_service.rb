class MovieService < ApiService
  def self.top_movies
    endpoint = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV["movies_secret"]}&language=en-US&page=1"
    create_data(endpoint)

    parsed_top_rated = get_data(endpoint)
    parsed_top_rated[:results].map do |movie|
      Moovee.new(movie)
    end
  end

  def self.search_movie(title)
    search_endpoint = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV["movies_secret"]}&language=en-US&query=#{title}"
    create_data(search_endpoint)
    parsed_search = get_data(search_endpoint)
    parsed_search[:results].map do |movie|
      Moovee.new(movie)
    end
  end

  def self.find_movie(id)
    find_endpoint = "https://api.themoviedb.org/3/movie/#{id}?api_key=#{ENV["movies_secret"]}2&language=en-US"
    movie_return = get_data(find_endpoint)
    binding.pry
  end

  def self.create_data(endpoint)
    parsed_top_rated = get_data(endpoint)

    parsed_top_rated[:results].map do |movie|
      Movie.create(title: movie[:title]) if Movie.find_by(title: movie[:title]).nil?
    end.compact
  end

end