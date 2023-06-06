# frozen_string_literal: true

class PlaygroundFacade
  attr_reader :id
  def initialize(id)
    @id = id #This is a playground id
  end

  def playground
    @playground ||= Playground.new(playground_data)
  end

  def playground_name
    playground.name
  end

  def playground_address
    playground.address
  end

  def playground_rating
    playground.rating
  end

  def playground_image
    playground.image
  end

  def reviews
    @review ||= review_data.map do |review|
      Review.new(review)
    end
  end

  private

  def service
    @service ||= PlaygroundsService.new
  end

  def playground_data
    @playground_data ||= service.get_playground(@id)[:data]
  end

  def review_data
    @review_data ||= service.get_reviews(@id)[:data]
  end
end
