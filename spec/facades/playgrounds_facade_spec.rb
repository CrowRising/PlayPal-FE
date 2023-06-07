# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlaygroundsFacade do
  before(:each) do
    stubbed_response = File.read('spec/fixtures/playgrounds_data.json')
    stub_request(:get, 'https://playpal-be.onrender.com/api/v0/playgrounds/123%20st/1600')
    .to_return(status: 200, body: stubbed_response)
  end

  describe 'Playgrounds Facade' do
    it 'exists' do
      playground = PlaygroundsFacade.new('123 st', 1)

      expect(playground).to be_a PlaygroundsFacade
    end
  end

  describe 'Can create playground objects' do
    it '#playgrounds' do
      playground = PlaygroundsFacade.new('123 st', 1)

      expect(playground.playgrounds).to be_an Array
      expect(playground.playgrounds.first).to be_a Playground

      expect(playground.playgrounds.first.id).to be_a String
      expect(playground.playgrounds.first.name).to be_a String
      expect(playground.playgrounds.first.address).to be_a String
      expect(playground.playgrounds.first.rating).to be_a String
    end
  end
end
