# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/welcome#index', type: :feature do
  before(:each) do
    @user1 = User.create!(id: 2, google_id: '123456789')
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

    stubbed_response = File.read('spec/fixtures/favorites_data.json')
    stub_request(:get, 'http://localhost:3000/api/v0/users/2/favorites')
    .to_return(status: 200, body: stubbed_response)    
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
    before(:each) do
      stubbed_response = File.read('spec/fixtures/playgrounds_data.json')
      stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/90210/1600')
      .to_return(status: 200, body: stubbed_response)

      stubbed_response = File.read('spec/fixtures/playgrounds_data.json')
      stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/90210/0')
      .to_return(status: 200, body: stubbed_response)
    end
    it 'can fill in location and radius to discover playground' do

      fill_in 'location', with: '90210'
      fill_in 'radius', with: '1'
      click_button 'Discover Playgrounds'

      expect(current_path).to eq(playgrounds_path)
    end

    it 'can fill just location to discover playground' do
     
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

    describe 'Sad Path' do
      it 'visitor who is not logged in, visit dashboard' do
        visit dashboard_path
        
        expect(current_path).to eq(root_path)
        expect(page).to have_content('You must log in to visit this page')
      end
    end
  end
end
