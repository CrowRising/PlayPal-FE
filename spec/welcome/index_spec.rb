require 'rails_helper'

RSpec.describe '/welcome#index', type: :feature do
  before(:each) do
    visit root_path
  end
  describe 'When a user visits the welcome page' do
    it 'They see the welcome to Play Pal header' do
      expect(page).to have_content('Welcome to PlayPal')
    end

    it 'They see a link at the top of the page to go back to the welcome page' do 
      expect(page).to have_link('Home')

      click_link('Home')

      expect(current_path).to eq(root_path)
    end

    it 'They see a button to login with a google account' do
      expect(page).to have_button('Login With Google')
    end

    it 'They see two input fields to put in an address and a search mile radius and a button to discover playgrounds' do
      
      expect(page).to have_field(:location)
      expect(page).to have_field(:radius)
      expect(page).to have_button('Discover Playgrounds')
    end
  end

  describe 'User Login' do
    it 'They can login with their google account' do
      
    end
  end
end