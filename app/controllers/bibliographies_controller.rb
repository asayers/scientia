class BibliographiesController < ApplicationController
  before_filter :require_login, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
#    @bibliographys = Bibliography.where(user_id: session[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @bibliography = @user.bibliographies.find(params[:id])
    respond_to do |format|
      format.html
      format.bib { send_data @bibliography.body, disposition: 'inline', type: 'text/plain' }
    end
  end

  def new
    @user = User.find(session[:user_id])
    @bibliography = Bibliography.new(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:user_id])
    @bibliography = @user.bibliographies.find(params[:id])
    unless @user.id == session[:user_id]
      not_authenticated
    end
  end

  def create
    @bibliography = Bibliography.new(params[:bibliography])
    @bibliography.user_id = session[:user_id]
    
    if @bibliography.save
      @bibliography.documents.each { |d| d.regenerate }
      redirect_to [@bibliography.user, @bibliography], notice: 'Bibliography was successfully created.'
    else
      flash[:error] = "Couldn't create bibliography"
      render action: "new"
    end
  end

  def update
    @user = User.find(session[:user_id])
    @bibliography = @user.bibliographies.find(params[:id])
    if @bibliography.update_attributes(params[:bibliography])
      @bibliography.documents.each { |d| d.regenerate }
      redirect_to [@user, @bibliography], notice: 'Bibliography was successfully updated.'
    else
      flash[:error] = "Couldn't save bibliography"
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @bibliography = @user.bibliographies.find(params[:id])
    unless @user.id == session[:user_id]
      not_authenticated
    else
      @bibliography.destroy
      redirect_to @user
    end
  end
end
