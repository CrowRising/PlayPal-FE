class PlaygroundsFacade

  def initialize(location, radius)
    @location = location
    @radius = radius
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
end
