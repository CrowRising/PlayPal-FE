class Playgrounds::FavoritesController < ApplicationController

  def create
    PlaygroundsService.new.add_favorite(favorite_data)
    redirect_to "/playgrounds/#{params[:playground_id]}"
    flash[:message] = 'This playground was added to your favorites'
  end

  private
    def favorite_data
      {
        user_id: params[:user_id],
        playground_id: params[:playground_id],
        playground_name: params[:playground_name]
      }
    end
end