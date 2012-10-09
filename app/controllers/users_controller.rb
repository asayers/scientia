class UsersController < ApplicationController
  before_filter :require_login, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.includes(:documents).includes(:templates).includes(:bibliographies).find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id == session[:user_id]
      not_authenticated
    end
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      login(params[:user][:username],params[:user][:password])
      redirect_to tutorial_path, notice: 'User was successfully created.'
    else
      flash[:error] = "Couldn't create new user"
      render action: "new"
    end
end

  def update
    @user = User.find(params[:id])
    
    unless @user.id == session[:user_id]
      not_authenticated
    else
      # TODO: figure out which attributes should be mutable.
      if @user.update_attributes(params[:user])
        redirect_to @user, notice: 'User was successfully updated.'
      else
        flash[:error] = "Couldn't save settings"
        render action: "edit"
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    unless @user.id == session[:user_id]
      not_authenticated
    else
      @user.destroy
      redirect_to users_url
    end
  end
end
