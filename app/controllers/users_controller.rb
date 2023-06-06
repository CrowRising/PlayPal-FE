# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @facade = FavoritesFacade.new(current_user.id).playgrounds
    # require 'pry'; binding.pry
  end
end
