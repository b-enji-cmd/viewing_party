class MovieService < ApiService
  def self.top_movies
    page_one = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV["movies_secret"]}&language=en-US&page=1"
    page_two = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV["movies_secret"]}&language=en-US&page=2"


    parsed_page_one = get_data(page_one)
    parsed_page_two = get_data(page_two)
    parsed_top_rated = parsed_page_one + parsed_page_two

    parsed_top_rated[:results].map do |movie|
      Moovee.new(movie)
    end
  end

  def self.search_movie(title)
    page = 1
    matching_movies = []
    #

    until matching_movies.length == 40
      search_endpoint = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV["movies_secret"]}&language=en-US&query=#{title}&page=#{page}"
      parsed_search = get_data(search_endpoint)
      break matching_movies if matching_movies.length == parsed_search[:total_results]

      parsed_search[:results].each do |movie|
        matching_movies << Moovee.new(movie)
      end
      page += 1
    end
    matching_movies.first(40)
  end

  def self.find_movie(id)
    find_endpoint = "https://api.themoviedb.org/3/movie/#{id}?api_key=#{ENV["movies_secret"]}"
    movie_return = get_data(find_endpoint)
    Moovee.new(movie_return)
  end


  #MOVING THIS METHOD TO THE ACTION WHICH IS THE RESULT OF CREATING A VIEWING PARTY
  # def self.create_data(endpoint)
  #   parsed_top_rated = get_data(endpoint)
  #
  #   parsed_top_rated[:results].map do |movie|
  #     Movie.create(title: movie[:title]) if Movie.find_by(title: movie[:title]).nil?
  #   end.compact
  # end

end
