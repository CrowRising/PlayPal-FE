require 'rails_helper'

RSpec.describe '/welcome#index', type: :feature do
  
  describe 'When a user visits the welcome page' do
    it 'They see the welcome to Play Pal header' do
      visit root_path

      expect(page).to have_content('Welcome to PlayPal')
    end

    it 'They see a link at the top of the page to go back to the welcome page' do

    end

    it 'They see a button to login with a google account' do

    end

    it 'They see two input fields to put in an address and a search mile radius and a button to discover playgrounds' do

    end
  end
end