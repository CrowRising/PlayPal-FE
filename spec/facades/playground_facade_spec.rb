# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlaygroundFacade do
  before(:each) do
    stubbed_response = File.read('spec/fixtures/playground_2_data.json')
    stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/2')
    .to_return(status: 200, body: stubbed_response)

    stubbed_response = File.read('spec/fixtures/playground_24_reviews.json')
      stub_request(:get, 'http://localhost:3000/api/v0/playgrounds/24/reviews')
      .to_return(status: 200, body: stubbed_response)

  end
  describe 'Playground Facade' do
    it 'exists and can create a single playground object' do
      pg = PlaygroundFacade.new('2')

      expect(pg).to be_a PlaygroundFacade
      expect(pg.playground).to be_a Playground
      expect(pg.playground_id).to eq('2')
      expect(pg.playground_name).to eq('Fehringer')
      expect(pg.playground_address).to eq('Full address')
      expect(pg.playground_rating).to eq('4.2')
    end

    it 'can get reviews for single playground' do
      pg = PlaygroundFacade.new('24').review

      expect(pg).to be_an Array
      expect(pg.first.id).to eq('322458')
      expect(pg.first.comment).to eq('comment')
      expect(pg.first.rating).to eq('4.2')
      expect(pg.first.user_id).to eq('12')
      expect(pg.first.playground_id).to eq('24')
    end
  end
end
