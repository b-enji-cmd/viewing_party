class Moovee
  attr_reader :title,
              :api_id,
              :summary,
              :vote_average,
              :overview,
              :runtime

  def initialize(data)
    @title = data[:title]
    @api_id = data[:id]
    @summary = data[:overview]
    @vote_average = data[:vote_average]
    @runtime = data[:runtime]
  end

  # def db_movie(title)
  #   Movie.find_by title: title
  # end
end
