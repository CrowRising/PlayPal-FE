require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'when I visit my dashboard' do
    before(:each) do
      @user1 = create(:user, id: 2, google_id: '123456789')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    #   OmniAuth.config.test_mode = true
    #   OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
    #   provider: 'google_oauth2',
    #   uid: '123456789',
    #   info: {
    #     email: 'test@example.com',
    #     name: 'Test User'
    #   },
    #   credentials: {
    #     token: 'testtoken'
    #   }
    # )
    # visit root_path
    # click_link('Login With Google')
    # stubbed_response = File.read('spec/fixtures/playgrounds_data.json')
    # stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/123%20st/1600')
    # .to_return(status: 200, body: stubbed_response)

    stubbed_response = File.read('spec/fixtures/favorites_data.json')
    stub_request(:get, 'http://localhost:3000/api/v0/users/2/favorites')
    .to_return(status: 200, body: stubbed_response)
    
    # stubbed = stub_request(:get, "http://localhost:3000/api/v0/users/2/favorites").
    #      with(
    #        headers: {
    #       'Accept'=>'*/*',
    #       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    #       'User-Agent'=>'Faraday v2.7.5'
    #        }).
    #      to_return(status: 200, body: stubbed, headers: {})
    end

    xit "I see a search bar to search for playgrounds" do
      visit dashboard_path

      expect(page).to have_field(:location)
      expect(page).to have_field(:radius)
      fill_in 'location', with: '123 st'
      fill_in 'radius', with: '1'
      click_button 'Discover Playgrounds'

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
    
    it "I see a list of all my favorite playgrounds" do
      visit dashboard_path
      
      expect(page).to have_content("Welcome to PlayPal, #{@user1.name}")
      expect(page).to have_content("My Favorite Playgrounds")

      within '#pg-5' do
        expect(page).to have_content('Lehigh Park')
      end
      within '#pg-10' do
        expect(page).to have_content('City Park')
      end
    end
  end
end