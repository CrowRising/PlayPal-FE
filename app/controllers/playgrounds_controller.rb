# frozen_string_literal: true

class PlaygroundsController < ApplicationController
  def index
    if params[:location].present?
      # facade will go here
    else
      redirect_to root_path
      flash[:error] = 'Error: Must add location!'
    end
  end
end
