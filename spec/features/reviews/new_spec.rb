require 'rails_helper'

RSpec.describe '/reviews#new' do
  before(:each) do
    stubbed_response = File.read('spec/fixtures/playground_24_data.json')
    stub_request(:get, 'https://playpal-be.onrender.com/api/v0/playgrounds/24')
    .to_return(status: 200, body: stubbed_response)
  end

  it 'has a form to create a new review' do
    @user1 = create(:user, id: 500, google_id: '123456789')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    visit new_playground_review_path(24)

    expect(page).to have_field('Rating:')
    expect(page).to have_field('Review:')
    expect(page).to have_field('Upload Image:')
    expect(page).to have_button('Tell em!')
  end

  it 'can create a new review', :vcr do
    @user1 = create(:user, id: 500, google_id: '123456789')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    visit new_playground_review_path(24)

    fill_in 'Rating:', with: 5
    fill_in 'Review:', with: 'This playground is awesome!'
    attach_file('image', Rails.root.join('spec/images/test_image.jpg'))
    click_button 'Tell em!'

    expect(current_path).to eq('/playgrounds/24')
  end

  it 'will not let you submit if an image is not uploaded' do
    @user1 = create(:user, id: 500, google_id: '123456789')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    visit new_playground_review_path(24)

    fill_in 'Rating:', with: 5
    fill_in 'Review:', with: 'This playground is awesome!'
    click_button 'Tell em!'

    expect(current_path).to eq(new_playground_review_path(24))
    expect(page).to have_content('All fields must be filled out.')
  end

  it 'will not let you submit if a rating is not present' do
    @user1 = create(:user, id: 500, google_id: '123456789')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    visit new_playground_review_path(24)

    fill_in 'Review:', with: 'This playground is awesome!'
    attach_file('image', Rails.root.join('spec/images/test_image.jpg'))
    click_button 'Tell em!'

    expect(current_path).to eq(new_playground_review_path(24))
    expect(page).to have_content('All fields must be filled out.')
  end

  it 'will not let you submit if a comment is not written' do
    @user1 = create(:user, id: 500, google_id: '123456789')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    visit new_playground_review_path(24)

    fill_in 'Rating:', with: 5
    attach_file('image', Rails.root.join('spec/images/test_image.jpg'))
    click_button 'Tell em!'

    expect(current_path).to eq(new_playground_review_path(24))
    expect(page).to have_content('All fields must be filled out.')
  end

  it 'will display an error message and leave you on the playgrounds show page if not logged in', :vcr do
    visit new_playground_review_path('ChIJz7xda7iLa4cRYNf2sN8C17I')

    expect(current_path).to eq('/playgrounds/ChIJz7xda7iLa4cRYNf2sN8C17I')
    expect(page).to have_content('You Must be Logged in to leave a Review')
  end
end
