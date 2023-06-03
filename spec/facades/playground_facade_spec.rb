require 'rails_helper'

RSpec.describe PlaygroundFacade do
  before(:each) do
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
                                                      "id": "2",
                                                      "type": "playground",
                                                      "attributes": {
                                                          "playground_name": "Fehringer",
                                                          "playground_address": "Full address",
                                                          "rating": "4.2"
                                                       }
                                                     }
                                                  } ), headers: {})
  end

  describe 'Playground Facade' do
    it 'exists' do
      pg = PlaygroundFacade.new('2')

      expect(pg).to be_a PlaygroundFacade
    end

    it 'can create a single playground object' do
      pg = PlaygroundFacade.new('2')

      expect(pg.playground).to be_a Playground
      expect(pg.playground_id).to eq('2')
      expect(pg.playground_name).to eq('Fehringer')
      expect(pg.playground_address).to eq('Full address')
      expect(pg.playground_rating).to eq('4.2')
    end
  end
end