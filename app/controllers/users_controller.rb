# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    if current_user
    @facade = FavoritesFacade.new(current_user.id)
    else
      redirect_to root_path
      flash[:error] = 'You must log in to visit this page'
    end
  end
end
