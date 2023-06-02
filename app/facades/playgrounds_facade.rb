class PlaygroundsFacade

  def initialize(location, radius)
    @location = location
    @radius = format_radius(radius)
  end

  def playgrounds
    @_playgrounds ||= playgrounds_data.map do |pg|
      Playground.new(pg)
    end
  end

  private
  def service
    @_service ||= PlaygroundsService.new
  end

  def playgrounds_data
    @_playgrounds_data ||= service.get_playgrounds(@location, @radius)[:data]
  end

  def format_radius(miles)
    miles * 1600
  end
end
