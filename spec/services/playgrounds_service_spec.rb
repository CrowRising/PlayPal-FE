# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlaygroundsService do
  it 'establishes connection for playgrounds in area' do
    stubbed_response = File.read('spec/fixtures/playgrounds_data.json')
    stub_request(:get, 'https://playpal-be.onrender.com/api/v0/playgrounds/90210/1600')
    .to_return(status: 200, body: stubbed_response)

    get_playgrounds = PlaygroundsService.new.get_playgrounds(90210, 1600)

    expect(get_playgrounds).to be_a Hash
    expect(get_playgrounds).to have_key(:data)
    expect(get_playgrounds[:data]).to be_an Array

    get_playgrounds[:data].each do |pg|
      expect(pg).to have_key(:type)
      expect(pg).to have_key(:id)
      expect(pg).to have_key(:attributes)
      expect(pg[:attributes]).to have_key(:playground_name)
      expect(pg[:attributes]).to have_key(:playground_address)
      expect(pg[:attributes]).to have_key(:rating)
    end
  end

  it 'establishes connection for a single playground' do
    stubbed_response = File.read('spec/fixtures/playground_2_data.json')
    stub_request(:get, 'https://playpal-be.onrender.com/api/v0/playgrounds/2')
    .to_return(status: 200, body: stubbed_response)
    
    playground = PlaygroundsService.new.get_playground(2)
    expect(playground).to be_a Hash
    expect(playground).to have_key(:data)
    expect(playground[:data]).to have_key(:id)
    expect(playground[:data]).to have_key(:type)
    expect(playground[:data][:attributes]).to have_key(:playground_name)
    expect(playground[:data][:attributes]).to have_key(:playground_address)
    expect(playground[:data][:attributes]).to have_key(:rating)
  end

  it 'can get reviews for specific playground' do
    stubbed_response = File.read('spec/fixtures/playground_24_reviews.json')
    stub_request(:get, 'https://playpal-be.onrender.com/api/v0/playgrounds/24/reviews')
    .to_return(status: 200, body: stubbed_response)

    playground = PlaygroundsService.new.get_reviews(24)
    expect(playground[:data]).to be_an Array

    expect(playground[:data].first[:attributes]).to have_key(:comment)
    expect(playground[:data].first[:attributes]).to have_key(:user_id)
    expect(playground[:data].first[:attributes]).to have_key(:rating)
    expect(playground[:data].first[:attributes]).to have_key(:image)
    expect(playground[:data].first[:attributes]).to have_key(:playground_id)
  end

    it 'can get favorites for specific user' do
        stubbed_response = File.read('spec/fixtures/favorites_data.json')
        stub_request(:get, 'https://playpal-be.onrender.com/api/v0/users/2/favorites')
        .to_return(status: 200, body: stubbed_response)
    
        favorites = PlaygroundsService.new.get_favorites(2)
    
        expect(favorites).to be_a Hash
        expect(favorites[:data]).to be_an Array
        expect(favorites[:data].first[:attributes]).to have_key(:playground_name)
        expect(favorites[:data].first[:attributes][:playground_name]).to eq('Lehigh Park')
        expect(favorites[:data].first[:attributes]).to have_key(:playground_id)
        expect(favorites[:data].first[:attributes][:playground_id]).to eq('5')
      end
end

# if time permits add testing to check key value returns
