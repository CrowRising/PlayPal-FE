# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Playground do
  it 'exists and has attributes' do
    playground_data = {
      id: '23',
      attributes: {
        playground_name: 'Fehringer',
        playground_address: '123 st',
        rating: '2.6'
      }
    }

    playground = Playground.new(playground_data)

    expect(playground).to be_a Playground
    expect(playground.id).to eq('23')
    expect(playground.name).to eq('Fehringer')
    expect(playground.address).to eq('123 st')
    expect(playground.rating).to eq('2.6')
  end
end
