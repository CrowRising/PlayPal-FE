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
end