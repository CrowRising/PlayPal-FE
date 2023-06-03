# frozen_string_literal: true

class PlaygroundFacade
  def initialize(id)
    @id = id
  end

  def playground
    @playground ||= Playground.new(playground_data)
  end

  def playground_id
    playground.id
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

  def review
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
