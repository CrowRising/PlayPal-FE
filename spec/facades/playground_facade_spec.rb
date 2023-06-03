# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlaygroundFacade do
  describe 'Playground Facade' do
    it 'exists and can create a single playground object' do
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
                                                      "id": '2',
                                                      "type": 'playground',
                                                      "attributes": {
                                                        "playground_name": 'Fehringer',
                                                        "playground_address": 'Full address',
                                                        "rating": '4.2'
                                                      }
                                                    } }), headers: {})
      pg = PlaygroundFacade.new('2')

      expect(pg).to be_a PlaygroundFacade
      expect(pg.playground).to be_a Playground
      expect(pg.playground_id).to eq('2')
      expect(pg.playground_name).to eq('Fehringer')
      expect(pg.playground_address).to eq('Full address')
      expect(pg.playground_rating).to eq('4.2')
    end

    it 'can get reviews for single playground' do
      stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/24/reviews')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Faraday v2.7.5'
          }
        )
        .to_return(status: 200, body: JSON.generate({ "data": [
                                                      {
                                                        "id": '322458',
                                                        "type": 'review',
                                                        "attributes": {
                                                          "comment": 'comment',
                                                          "user_id": '12',
                                                          "rating": '4.2',
                                                          "image": 'image',
                                                          "playground_id": '24'
                                                        }
                                                      }
                                                    ] }), headers: {})

      pg = PlaygroundFacade.new('24').review

      expect(pg).to be_an Array
      expect(pg.first.id).to eq('322458')
      expect(pg.first.comment).to eq('comment')
      expect(pg.first.rating).to eq('4.2')
      expect(pg.first.user_id).to eq('12')
      expect(pg.first.playground_id).to eq('24')
    end
  end
end
