# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/playgrounds#show' do
  before(:each) do
    stubbed_response = File.read('spec/fixtures/playground_24_data.json')
    stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/24')
    .to_return(status: 200, body: stubbed_response)
    
    stubbed_response = File.read('spec/fixtures/playground_24_reviews.json')
      stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/24/reviews')
      .to_return(status: 200, body: stubbed_response)
    
      visit 'playgrounds/24'
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
