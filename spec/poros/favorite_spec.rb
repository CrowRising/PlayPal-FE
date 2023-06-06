require 'rails_helper'

RSpec.describe Favorite do
  it 'exists and has attributes' do
    fav_data = {
      id: "2",
      type: "user_playgrounds",
      attributes: {
        playground_id: 5,
        playground_name: "Lehigh Park"
        }
    }

    favorite = Favorite.new(fav_data)

    expect(favorite).to be_a Favorite
    expect(favorite.playground_id).to eq(5)
    expect(favorite.playground_name).to eq("Lehigh Park")
  end
end