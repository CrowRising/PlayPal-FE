class SessionsController < ApplicationController

  def create
    google_id = auth_hash['uid']
    name = auth_hash['info']['name']
    email = auth_hash['info']['email']
    token = auth_hash['credentials']['token']
    user = User.find_or_create_by(google_id: google_id)
    user.update(name: name, token: token, email: email)
    
    session[:user_id] = user.id
    redirect_to '/dashboard'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end