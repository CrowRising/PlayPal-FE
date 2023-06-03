# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/playgrounds#show' do
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
                                                      "id": '2',
                                                      "type": 'playground',
                                                      "attributes": {
                                                        "playground_name": 'Fehringer',
                                                        "playground_address": 'Full address',
                                                        "rating": '4.2'
                                                      }
                                                    } }), headers: {})
    visit '/playgrounds/2'
  end

  describe 'Playground Show Page' do
    it 'displays name of playground and attributes' do
      expect(page).to have_content('Fehringer')
      expect(page).to have_content('Full address')
      expect(page).to have_content('Rating: 4.2')
    end

    xit 'displays a static satalite image of playground' do
      expect(page).to have_content('img')
    end

    it 'displays links to home and user dashboards' do
      expect(page).to have_link('Home')
      expect(page).to_not have_link('Dashboard')
    end

    xit 'displays button to add playground to favorites' do
      expect(page).to have_button('This place rules!')

      click
    end
  end
end
