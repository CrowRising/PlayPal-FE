# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlaygroundsFacade do
  before(:each) do
    stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/123%20st/1600')
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

  describe 'Playgrounds Facade' do
    it 'exists' do
      playground = PlaygroundsFacade.new('123 st', 1)

      expect(playground).to be_a PlaygroundsFacade
    end
  end

  describe 'Can create playground objects' do
    it '#playgrounds' do
      playground = PlaygroundsFacade.new('123 st', 1)

      expect(playground.playgrounds).to be_an Array
      expect(playground.playgrounds.first).to be_a Playground

      expect(playground.playgrounds.first.id).to be_a String
      expect(playground.playgrounds.first.name).to be_a String
      expect(playground.playgrounds.first.address).to be_a String
      expect(playground.playgrounds.first.rating).to be_a String
    end
  end
end
