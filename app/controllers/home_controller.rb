class HomeController < ApplicationController
  def index
    redirect_to hunts_path if user_signed_in?
  end
end
