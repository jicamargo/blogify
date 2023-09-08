# app/controllers/api/v1/base_controller.rb

class Api::V1::BaseController < ApplicationController
  before_action :authenticate_user!

  private

  def authenticate_user!
    head :unauthorized unless current_user
  end
end
