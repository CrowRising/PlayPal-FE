require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'when I visit my dashboard' do
    before(:each) do
      @user1 = create(:user, id: 2, google_id: '123456789')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
   
      stubbed_response = File.read('spec/fixtures/playgrounds_data.json')
      stub_request(:get, 'https://playpal-be.onrender.com/api/v0/playgrounds/123%20st/1600')
        .to_return(status: 200, body: stubbed_response)

      stubbed_response = File.read('spec/fixtures/favorites_data.json')
      stub_request(:get, 'https://playpal-be.onrender.com/api/v0/users/2/favorites')
        .to_return(status: 200, body: stubbed_response)

      stubbed_response = File.read('spec/fixtures/playground_24_data.json')
      stub_request(:get, 'https://playpal-be.onrender.com/api/v0/playgrounds/24')
        .to_return(status: 200, body: stubbed_response)

      stubbed_response = File.read('spec/fixtures/playground_5_data.json')
      stub_request(:get, 'https://playpal-be.onrender.com/api/v0/playgrounds/5')
        .to_return(status: 200, body: stubbed_response)

      stubbed_response = File.read('spec/fixtures/playground_10_data.json')
      stub_request(:get, 'https://playpal-be.onrender.com/api/v0/playgrounds/10')
        .to_return(status: 200, body: stubbed_response)

      stubbed_response = File.read('spec/fixtures/playground_5_reviews.json')
      stub_request(:get, 'https://playpal-be.onrender.com/api/v0/playgrounds/5/reviews')
        .to_return(status: 200, body: stubbed_response)

      stubbed_response = File.read('spec/fixtures/playground_10_reviews.json')
      stub_request(:get, 'https://playpal-be.onrender.com/api/v0/playgrounds/10/reviews')
        .to_return(status: 200, body: stubbed_response)
    end

    it "I see a search bar to search for playgrounds" do
      visit dashboard_path

      expect(page).to have_field(:location)
      expect(page).to have_field(:radius)
      fill_in 'location', with: '123 st'
      fill_in 'radius', with: '1'
      click_button 'Discover Playgrounds'

      expect(current_path).to eq(playgrounds_path)

      within '#pg-23' do
        expect(page).to have_content('Fehringer')
        expect(page).to have_content('Address: 1400 U Street')
        expect(page).to have_content('Rating: 2.5')
      end

      within '#pg-24' do
        expect(page).to have_content('Birds Nest')
        expect(page).to have_content('Address: 1700 U Street')
        expect(page).to have_content('Rating: 2.7')
      end
    end

    it "I see a list of all my favorite playgrounds" do
      visit dashboard_path

      expect(page).to have_content("Welcome to PlayPal, #{@user1.name}")
      expect(page).to have_content("My Favorite Playgrounds")

      within '#pg-5' do
        expect(page).to have_link('Lehigh Park')
        click_link 'Lehigh Park'
        expect(current_path).to eq('/playgrounds/5')
      end
      
      visit dashboard_path

      within '#pg-10' do
        expect(page).to have_link('City Park')
        click_link 'City Park'
        expect(current_path).to eq('/playgrounds/10')
      end
    end
  end
end