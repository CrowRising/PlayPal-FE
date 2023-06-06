class Favorite
attr_reader :playground_id, :playground_name
  def initialize(data)
    @playground_id = data[:attributes][:playground_id]
    @playground_name = data[:attributes][:playground_name]
  end
end