class Moovee
  attr_reader :title,
              :api_id,
              :summary,
              :vote_average,
              :overview,
              :runtime,
              :genre

  def initialize(data)
    @title = data[:title]
    @api_id = data[:id]
    @summary = data[:overview]
    @vote_average = data[:vote_average]
    @runtime = data[:runtime]
    @genre = data[:genre]
  end

  # def db_movie(title)
  #   Movie.find_by title: title
  # end
end
