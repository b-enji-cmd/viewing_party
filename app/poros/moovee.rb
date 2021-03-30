class Moovee
  attr_reader :title,
              :api_id,
              :summary,
              :vote_average,
              :overview,
              :runtime,
              :genres

  def initialize(data)
    @title        = data[:title]
    @api_id       = data[:id]
    @summary      = data[:overview]
    @vote_average = data[:vote_average]
    @runtime      = data[:runtime]
    @api_genres   = data[:genres]
  end

  def genres
    @api_genres.map do |genre_hash|
      genre_hash[:name]
    end
  end
end
