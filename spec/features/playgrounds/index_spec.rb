# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/playgrounds#index', type: :feature do
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
                                                        "playground_address": '1400 U Street',
                                                        "rating": '2.5'
                                                      }
                                                    },
                                                    {
                                                      "type": 'playground',
                                                      "id": '24',
                                                      "attributes": {
                                                        "playground_name": 'Birds Nest',
                                                        "playground_address": '1700 U Street',
                                                        "rating": '2.7'
                                                      }
                                                    }
                                                  ]), headers: {})
    visit root_path
    fill_in 'location', with: '123 st'
    fill_in 'radius', with: '1'
    click_button 'Discover Playgrounds'
  end

  describe 'Playgrounds Index' do
    it 'displays list of playgrounds and attributes' do
      expect(current_path).to eq(playgrounds_path)

      within '#pg-23' do
        expect(page).to have_content('Name: Fehringer')
        expect(page).to have_content('Address: 1400 U Street')
        expect(page).to have_content('Rating: 2.5')
      end

      within '#pg-24' do
        expect(page).to have_content('Name: Birds Nest')
        expect(page).to have_content('Address: 1700 U Street')
        expect(page).to have_content('Rating: 2.7')
      end
    end

    it 'each playground name is a link to their show page' do
      within '#pg-23' do
        expect(page).to have_link('Fehringer')
      end

      within '#pg-24' do
        expect(page).to have_link('Birds Nest')
      end
    end

    it 'when link is clicked it takes user to playground show page' do
      stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/23')
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

      within '#pg-23' do
        click_link 'Fehringer'
      end
      expect(current_path).to eq('/playgrounds/23')
    end
  end
end
