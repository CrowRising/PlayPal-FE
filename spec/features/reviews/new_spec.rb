require 'rails_helper'

RSpec.describe '/reviews#new' do
  before(:each) do
    
    @user1 = create(:user, id: 500, google_id: '123456789')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    stubbed_response = File.read('spec/fixtures/playground_24_data.json')
    stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/24')
    .to_return(status: 200, body: stubbed_response)
      
    visit new_playground_review_path(24)

  end

  it 'has a form to create a new review' do
    expect(page).to have_field('Rating:')
    expect(page).to have_field('Review:')
    expect(page).to have_field('Upload Image:')
    expect(page).to have_button('Tell em!')
  end

  it 'can create a new review' do
    fill_in 'Rating:', with: 5
    fill_in 'Review:', with: 'This playground is awesome!'
    attach_file('image', Rails.root.join('spec/images/test_image.jpg'))
    click_button 'Tell em!'

    expect(current_path).to eq(playground_path(24))
  end
end
