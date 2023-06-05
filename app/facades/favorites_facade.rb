class FavoritesFacade
  def initialize(user_id)
    @user_id = user_id
  end

  def playgrounds
    @playgrounds ||= favorites_data.map do |pg|
      Playground.new(pg)
    end
  end

  private

    def service
      @service ||= PlaygroundsService.new
    end

    def favorites_data
      @favorites_data ||= service.get_favorites(@user_id)[:data]
    end
end