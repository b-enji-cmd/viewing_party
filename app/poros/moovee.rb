class Moovee
  def initialize(data)
    @title = data[:title]
    @db_id = data[:id]
    @summary = data[:overview]

  end
end