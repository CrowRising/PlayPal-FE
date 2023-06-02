class Playground
  attr_reader :id, :name, :address, :rating
  
  def initialize(data)
    @id = data[:id]
    @name = data[:attributes][:playground_name]
    @address = data[:attributes][:playground_address]
    @rating = data[:attributes][:average_rating]
  end
end