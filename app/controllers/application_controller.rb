class ApplicationController < ActionController::Base
  # retrieve the first user from the db. temporary setup for demonstration purposes.
  def current_user
    @current_user = User.first
  end
end
