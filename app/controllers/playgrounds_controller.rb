# frozen_string_literal: true

class PlaygroundsController < ApplicationController
  def index
    if params[:location].present?
      @facade = PlaygroundsFacade.new(params[:location], params[:radius])
    else
      redirect_to root_path
      flash[:error] = 'Error: Must add location!'
    end
  end

  def show
    @facade = PlaygroundFacade.new(params[:id])
  end
end
