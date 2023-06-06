require 'rails_helper'

RSpec.describe FavoritesFacade do
  before(:each) do
    stubbed_response = File.read('spec/fixtures/favorites_data.json')
    stub_request(:get, 'http://localhost:3000/api/v0/users/2/favorites')
    .to_return(status: 200, body: stubbed_response)
  end
  describe 'instance methods' do
    it "favorites_data" do
      @favorites = FavoritesFacade.new(2).playgrounds
      expect(@favorites).to be_an Array
      expect(@favorites.first).to be_a Playground
      @favorites.each do |favorite|
        expect(favorite).to be_a Playground
        expect(favorite.id).to be_a String
        expect(favorite.name).to be_a String
        expect(favorite.rating).to be(nil)
        expect(favorite.image).to be(nil)  
      end
    end
  end
end