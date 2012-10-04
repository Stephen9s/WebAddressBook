class AddressesController < ApplicationController
  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.all(:conditions => ["user_id = :code", {:code => session[:user_id]}])

    if session[:user_id].nil?
      redirect_to :controller => 'sessions', :action => 'login'
    else
      if @addresses.nil?
        redirect_to new_address_path
      else
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @addresses }
        end
      end
    end
    
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
    
    if session[:user_id].nil?
      redirect_to :controller => 'sessions', :action => 'login'
    else
        @address = Address.find(params[:id])
        
        unless session[:user_id] == @address.user_id
          redirect_to :controller => 'addresses', :action => 'index'
        end
        
    end
  rescue
      if session[:user_id].nil?
        redirect_to :controller => 'sessions', :action => 'login'
      else
        redirect_to :controller => 'sessions', :action => 'logout'
      end
  end

  # GET /addresses/new
  # GET /addresses/new.json
  def new
    if session[:user_id].nil?
      redirect_to :controller => 'sessions', :action => 'login'
    else
      @address = Address.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @address }
      end
    end
  end

  # GET /addresses/1/edit
  def edit
    if session[:user_id].nil?
      redirect_to :controller => 'sessions', :action => 'login'
    else
      @address = Address.find(params[:id])
      if session[:user_id] == @address.user_id
        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @address }
        end
      else
        redirect_to :controller => 'sessions', :action => 'logout', :message => "Hacker!"
      end
    end
  rescue
      if session[:user_id].nil?
        redirect_to :controller => 'sessions', :action => 'login'
      else
        redirect_to :controller => 'sessions', :action => 'logout'
      end
  end

  # POST /addresses
  # POST /addresses.json
  def create
    if session[:user_id].nil?
      redirect_to :controller => 'sessions', :action => 'login'
    else
      @address = Address.new(params[:address])
      @address.user_id = session[:user_id]
      
      respond_to do |format|
        if @address.save
          format.html { redirect_to @address, notice: 'Address was successfully created.' }
          format.json { render json: @address, status: :created, location: @address }
        else
          format.html { render action: "new" }
          format.json { render json: @address.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /addresses/1
  # PUT /addresses/1.json
  def update
    if session[:user_id].nil?
      redirect_to :controller => 'sessions', :action => 'login'
    else
        @address = Address.find(params[:id])
        
        if session[:user_id] == @address.user_id   
          respond_to do |format|
            if @address.update_attributes(params[:address])
              format.html { redirect_to @address, notice: 'Address was successfully updated.' }
              format.json { head :no_content }
            else
              format.html { render action: "edit" }
              format.json { render json: @address.errors, status: :unprocessable_entity }
            end
          end
        else
          redirect_to :controller => 'sessions', :action => 'logout'
        end
    end
  rescue
      if session[:user_id].nil?
        redirect_to :controller => 'sessions', :action => 'login'
      else
        redirect_to :controller => 'sessions', :action => 'logout'
      end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    if session[:user_id].nil?
      redirect_to :controller => 'sessions', :action => 'login'
    else
        @address = Address.find(params[:id])
        if session[:user_id] == @address.user_id 
          @address.destroy
      
          respond_to do |format|
            format.html { redirect_to addresses_url }
            format.json { head :no_content }
          end
        else
          redirect_to :controller => 'sessions', :action => 'logout'
        end
    end
  rescue
      if session[:user_id].nil?
        redirect_to :controller => 'sessions', :action => 'login'
      else
        redirect_to :controller => 'sessions', :action => 'logout'
      end
  end
end
