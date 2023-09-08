# app/controllers/api/v1/sessions_controller.rb

class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.valid_password?(params[:password])
      token = user.generate_jwt
      render json: { token: token, user: user }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end
end
