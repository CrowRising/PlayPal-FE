# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/playgrounds#show' do
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

    stubbed_response = File.read('spec/fixtures/playground_24_data.json')
    stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/24')
      .to_return(status: 200, body: stubbed_response)
    
    stubbed_response = File.read('spec/fixtures/playground_24_reviews.json')
    stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/24/reviews')
      .to_return(status: 200, body: stubbed_response)

      @user = create(:user, id: 12)
      @user2 = create(:user, id: 13)
    end
    
    describe 'Playground Show Page' do
      it 'displays name of playground and attributes' do
        visit 'playgrounds/24'
      expect(page).to have_content('Fehringer')
      expect(page).to have_content('Full address')
      expect(page).to have_content('Rating: 4.2')
    end

    xit 'displays a static satalite image of playground' do
      visit 'playgrounds/24'
      expect(page).to have_content('img')
    end

    it 'displays links to home and user dashboards' do
      visit 'playgrounds/24'
      expect(page).to have_link('Home')
      expect(page).to_not have_link('Dashboard')
    end

    it 'displays the reviews other users have left including their name and rating' do
      visit 'playgrounds/24'
      expect(page).to have_content('Reviews:')
    
      within "#review_322458" do
        expect(page).to have_content("Author: #{@user.name}")
        expect(page).to have_content("Review: comment")
        expect(page).to have_content("Rating: 4.2")
      end
      within "#review_5" do
        expect(page).to have_content("Author: #{@user2.name}")
        expect(page).to have_content("Review: this park is great")
        expect(page).to have_content("Rating: 4.1")
      end

    end

    it 'displays link to add playground to favorites' do
      visit root_path
      click_link('Login With Google')
      visit 'playgrounds/24'

      expect(page).to have_button('This Place Rules!')
    end

    it 'does not show the this place rules button if not logged in' do
      visit 'playgrounds/24'

      expect(page).to_not have_button('This Place Rules!')
    end

    it 'When logged in and I click on this place rules I see a message that says the park has been added to favorites' do
      user = create(:user, id: 500, google_id: '123456789')
      
      stub_request(:post, "http://localhost:3000/api/v0/users/favorites").
         with(
           body: {"user_playgrounds"=>{"playground_id"=>"24", "playground_name"=>"Fehringer", "user_id"=>"500"}},
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'User-Agent'=>'Faraday v2.7.5'
           }).
         to_return(status: 200, body: "", headers: {})
      
      visit root_path
      click_link('Login With Google')
      visit '/playgrounds/24'
      click_button('This Place Rules!')

      expect(current_path).to eq('/playgrounds/24')
      expect(page).to have_content('This playground was added to your favorites')
    end
  end
end
