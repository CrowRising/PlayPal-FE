# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlaygroundsService do
  let(:get_playgrounds) { PlaygroundsService.new.get_playgrounds(90_210, 1600) }

  before(:each) do
    stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/90210/1600')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v2.7.5'
        }
      )
      .to_return(status: 200, body: JSON.generate("data": [
                                                    {
                                                      "type": 'playground',
                                                      "id": '23',
                                                      "attributes": {
                                                        "playground_name": 'Fehringer',
                                                        "playground_address": '1400 U Street ',
                                                        "rating": '2.5'
                                                      }
                                                    },
                                                    {
                                                      "type": 'playground',
                                                      "id": '23',
                                                      "attributes": {
                                                        "playground_name": 'Birds Nest',
                                                        "playground_address": '1700 U Street',
                                                        "rating": '2.7'
                                                      }
                                                    }
                                                  ]), headers: {})
  end

  it 'establishes connection for playgrounds in area' do
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
    stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/2')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v2.7.5'
        }
      )
      .to_return(status: 200, body: JSON.generate({ "data": 
                                                    {
                                                      "id": "322474",
                                                      "type": "review",
                                                      "attributes": {
                                                          "playground_id": "2",
                                                          "playground_name": "Fehringer",
                                                          "playground_address": "Full address",
                                                          "rating": "4.2"
                                                       }
                                                     }
                                                  } ), headers: {})

    playground = PlaygroundsService.new.get_playground(2)
    expect(playground).to be_a Hash
    expect(playground).to have_key(:data)
    expect(playground[:data]).to have_key(:id)
    expect(playground[:data]).to have_key(:type)
    expect(playground[:data][:attributes]).to have_key(:playground_id)
    expect(playground[:data][:attributes]).to have_key(:playground_name)
    expect(playground[:data][:attributes]).to have_key(:playground_address)
    expect(playground[:data][:attributes]).to have_key(:rating)
  end
end

# if time permits add testing to check key value returns
