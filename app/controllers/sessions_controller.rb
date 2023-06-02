class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    google_id = auth_hash['uid']
    name = auth_hash['info']['name']
    email = auth_hash['info']['email']
    token = auth_hash['credentials']['token']

    user = User.find_or_create_by(name: name)
    user.update(google_id: google_id, token: token, email: email)

    session[:user_id] = user.id

    redirect_to '/dashboard'

  end
end