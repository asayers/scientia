class SessionsController < ApplicationController
  before_filter :require_login, only: [:destroy]
  
  def new
    @user = User.new
  end
  
  def create
    respond_to do |format|
      if @user = login(params[:username],params[:password])
        format.html { redirect_back_or_to root_url, notice: "Login successful" }
      else
        format.html { redirect_back_or_to root_url, notice: "Login failed" }
      end
    end
  end
  
  def destroy
    logout
    redirect_to(root_url, :notice => 'Logged out!')
  end
end
