class MovieService < ApiService
  def self.top_movies
    endpoint = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV["movies_secret"]}&language=en-US&page=1"
    #call an additional page if there are less than 40 movies
    # each with object
    # get_data inside enum
    # endpoint = somestringpage=#{blockvariable with some integer}
    # create MooVee PORO
    # less than 40 movies?
    # parse another endpoint page

    parsed_top_rated = get_data(endpoint)
    #This can be 2 pages,
    parsed_top_rated[:results].map do |movie|
      Moovee.new(movie)
    end
  end

  def self.search_movie(title)
    search_endpoint = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV["movies_secret"]}&language=en-US&query=#{title}"
    #create_data(search_endpoint)
    #
    #keep parsing api until the length of the return is 40 movies
    parsed_search = get_data(search_endpoint)
    parsed_search[:results].map do |movie|
      Moovee.new(movie)
    end
  end

  def self.find_movie(id)
    find_endpoint = "https://api.themoviedb.org/3/movie/#{id}"
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
