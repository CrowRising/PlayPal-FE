# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/welcome#index', type: :feature do
  before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '123456789',
      info: {
        email: 'test@example.com',
        name: 'Test User'
      },
      credentials: {
        token: 'testtoken'
      }
    )
    visit root_path
  end
  describe 'When a user visits the welcome page' do
    it 'They see the welcome to Play Pal header' do
      expect(page).to have_content('Welcome to PlayPal')
    end

    it 'They see a link at the top of the page to go back to the welcome page and not a dashboard link' do
      expect(page).to have_link('Home')
      expect(page).to_not have_link('Dashboard')

      click_link('Home')

      expect(current_path).to eq(root_path)
    end

    it 'They see a button to login with a google account' do
      expect(page).to have_link('Login With Google')
      expect(page).to_not have_button('Logout')
    end

    it 'They see two input fields to put in an address and a search mile radius and a button to discover playgrounds' do
      expect(page).to have_field(:location)
      expect(page).to have_field(:radius)
      expect(page).to have_button('Discover Playgrounds')
    end
  end

  describe 'User Login' do
    it 'They can login with their google account and are redirected to their dashboard' do
      click_link('Login With Google')

      expect(current_path).to eq(dashboard_path)
    end

    it 'When logged in they see a link at the top of the page to go to their dashboard' do
      click_link('Login With Google')
      click_link('Home')

      expect(page).to have_link('Dashboard')

      click_link('Dashboard')

      expect(current_path).to eq(dashboard_path)
    end

    it 'When logged in and they click home, they see a logout button and not a login button' do
      click_link('Login With Google')
      click_link('Home')

      expect(page).to have_button('Logout')
      expect(page).to_not have_link('Login With Google')
    end

    it 'When a user logs out, they are redirected back to the home page and a login button is shown' do
      click_link('Login With Google')
      click_link('Home')
      click_button('Logout')

      expect(current_path).to eq(root_path)
      expect(page).to have_link('Login With Google')
      expect(page).to_not have_button('Logout')
    end
  end

  describe 'Discover Playgrounds' do
    it 'can fill in location and radius to discover playground' do
      stub_request(:get, "http://localhost:3000/api/v0/playgrounds/90210/1600").
        with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.5'
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

      fill_in 'location', with: '90210'
      fill_in 'radius', with: '1'
      click_button 'Discover Playgrounds'

      expect(current_path).to eq(playgrounds_path)
    end

    it 'can fill just location to discover playground' do
      stub_request(:get, "http://localhost:3000/api/v0/playgrounds/90210/0").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v2.7.5'
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

      fill_in 'location', with: '90210'
      click_button 'Discover Playgrounds'

      expect(current_path).to eq(playgrounds_path)
    end

    it 'displays error message if no fields are filled in' do
      click_button 'Discover Playgrounds'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Error: Must add location!')
    end

    it 'displays error message if only radius field is filled in' do
      fill_in 'radius', with: '2'
      click_button 'Discover Playgrounds'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Error: Must add location!')
    end
  end
end
