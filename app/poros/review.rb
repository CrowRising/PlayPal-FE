# frozen_string_literal: true

class Review
  attr_reader :id,
              :comment,
              :user_id,
              :rating,
              :image,
              :playground_id

  def initialize(data)
    @id = data[:id]
    @comment = data[:attributes][:comment]
    @user_id = data[:attributes][:user_id]
    @rating = data[:attributes][:rating]
    @image = data[:attributes][:image]
    @playground_id = data[:attributes][:playground_id]
  end

  def user_name
    User.find(@user_id)
  end
end
