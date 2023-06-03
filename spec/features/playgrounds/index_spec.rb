# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/playgrounds#index', type: :feature do
  before(:each) do
    stubbed_response = File.read('spec/fixtures/playgrounds_data.json')
    stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/123%20st/1600')
    .to_return(status: 200, body: stubbed_response)

    stubbed_response = File.read('spec/fixtures/playground_2_data.json')
    stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/23')
    .to_return(status: 200, body: stubbed_response)

    
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

      within '#pg-23' do
        click_link 'Fehringer'
      end
      expect(current_path).to eq('/playgrounds/23')
    end
  end
end
