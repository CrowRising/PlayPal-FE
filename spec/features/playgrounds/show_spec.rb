# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/playgrounds#show' do
  before(:each) do
    
    @user1 = create(:user, id: 500, google_id: '123456789')

    stubbed_response = File.read('spec/fixtures/playground_24_data.json')
    stub_request(:get, 'https://playpal-be.onrender.com/api/v0/playgrounds/24')
      .to_return(status: 200, body: stubbed_response)
    
    stubbed_response = File.read('spec/fixtures/playground_24_reviews.json')
    stub_request(:get, 'https://playpal-be.onrender.com/api/v0/playgrounds/24/reviews')
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

    it 'displays an image of the playground and review image' do
      visit 'playgrounds/24'

      within "#review_322458" do
        expect(page).to have_css('img')
      end

      within "#image" do
        expect(page).to have_css('img')
      end
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

    it 'displays a link to add a new review' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      
      visit 'playgrounds/24'

      expect(page).to have_link("Add Your Two Cents!")
    end

    it 'when I click on add a review I am taken to a new review form' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      
      visit 'playgrounds/24'

      click_link("Add Your Two Cents!")

      expect(current_path).to eq(new_playground_review_path(24))
    end

    it 'displays link to add playground to favorites' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      
      visit 'playgrounds/24'

      expect(page).to have_button('This Place Rules!')
    end

    it 'does not show the this place rules button if not logged in' do
      visit 'playgrounds/24'

      expect(page).to_not have_button('This Place Rules!')
    end

    it 'When logged in and I click on this place rules I see a message that says the park has been added to favorites' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      
      stub_request(:post, "https://playpal-be.onrender.com/api/v0/users/favorites").
         with(
           body: {"user_playgrounds"=>{"playground_id"=>"24", "playground_name"=>"Fehringer", "user_id"=>"500"}},
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'User-Agent'=>'Faraday v2.7.5'
           }).
         to_return(status: 200, body: "", headers: {})
      
      visit '/playgrounds/24'
      click_button('This Place Rules!')

      expect(current_path).to eq('/playgrounds/24')
      expect(page).to have_content('This playground was added to your favorites')
    end
  end
end