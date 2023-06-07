require 'rails_helper'

RSpec.describe FavoritesFacade do
  before(:each) do
    stubbed_response = File.read('spec/fixtures/favorites_data.json')
    stub_request(:get, 'https://playpal-be.onrender.com/api/v0/users/2/favorites')
    .to_return(status: 200, body: stubbed_response)
  end
  describe 'instance methods' do
    it "favorites_data" do
      @favorites = FavoritesFacade.new(2).favorites
      expect(@favorites).to be_an Array
      expect(@favorites.first).to be_a Favorite
      @favorites.each do |favorite|
        expect(favorite).to be_a Favorite
        expect(favorite.playground_id).to be_a String
        expect(favorite.playground_name).to be_a String
      end
    end
  end
end