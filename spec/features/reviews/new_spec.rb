RSpec.describe '/reviews#new' do
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
      stubbed_response = File.read('spec/fixtures/playgrounds_data.json')
      stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/123%20st/1600')
      .to_return(status: 200, body: stubbed_response)
      
      stubbed_response = File.read('spec/fixtures/playground_24_data.json')
      stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/24')
      .to_return(status: 200, body: stubbed_response)
      
      @user = create(:user, id: 14)
      visit root_path
      click_link('Login With Google')
      click_link('Home')
      fill_in 'location', with: '123 st'
      fill_in 'radius', with: '1'
      click_button 'Discover Playgrounds'
      click_link('Fehringer')

      save_and_open_page
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
