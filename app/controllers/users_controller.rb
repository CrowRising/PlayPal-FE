class UsersController < ApplicationController

  def show
    # require 'pry'; binding.pry
    @user = User.find(session[:user_id])
  end
end