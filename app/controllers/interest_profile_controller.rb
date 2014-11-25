class InterestProfileController < ApplicationController
  def index
    @interest = Vote.where(user_id: current_user.id)
  end  
end
