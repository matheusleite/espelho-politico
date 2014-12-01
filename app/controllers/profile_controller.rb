class ProfileController < ApplicationController
  def index
  end

  def show
  	@parliamentarian = Parliamentarian.find(params[:id])
  end
end