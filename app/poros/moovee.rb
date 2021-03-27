class Moovee
  attr_reader :title,
              :db_id,
              :summary,
              :vote_average

  def initialize(data)
    @title = data[:title]
    @db_id = data[:id]
    @summary = data[:overview]
    @vote_average = data[:vote_average]
  end

  def db_movie(title)
    Movie.find_by title: title
  end
end