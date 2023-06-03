# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review do
  it 'exists and has attributes' do
    review_data = {
      id: '240',
      attributes: {
        comment: 'comment',
        user_id: '1',
        rating: '3',
        image: 'img',
        playground_id: '6'
      }
    }

    review = Review.new(review_data)

    expect(review).to be_a Review
    expect(review.id).to eq('240')
    expect(review.comment).to eq('comment')
    expect(review.user_id).to eq('1')
    expect(review.rating).to eq('3')
    expect(review.image).to eq('img')
    expect(review.playground_id).to eq('6')
  end
end
