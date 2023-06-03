# frozen_string_literal: true

class PlaygroundsFacade
  def initialize(location, radius)
    @location = format_location(location)
    @radius = format_radius(radius.to_i)
  end

  def playgrounds
    @playgrounds ||= playgrounds_data.map do |pg|
      Playground.new(pg)
    end
  end

  private

  def service
    @service ||= PlaygroundsService.new
  end

  def playgrounds_data
    @playgrounds_data ||= service.get_playgrounds(@location, @radius)[:data]
  end

  def format_radius(miles)
    miles * 1600
  end

  def format_location(location)
    location.gsub(' ', '%20')
  end
end
