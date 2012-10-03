class AddressController < ApplicationController
  def index
    @addresses = Addresses.find_by_user_id(session[:user_id])
    
    render 'index'
  end

  def new
  end

  def edit
  end

  def show
  end

  def destroy
  end
end
