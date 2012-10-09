class TemplatesController < ApplicationController
  before_filter :require_login, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
#    @templates = Template.where(user_id: session[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @template = @user.templates.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf { send_data @template.pdf, disposition: 'inline', type: 'application/pdf' }
      format.tex { send_data @template.body, disposition: 'inline', type: 'text/plain' }
    end
  end

  def new
    @user = User.find(session[:user_id])
    @template = Template.new(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:user_id])
    @template = @user.templates.find(params[:id])
    unless @user.id == session[:user_id]
      not_authenticated
    end
  end

  def create
    @template = Template.new(params[:template])
    @template.user_id = session[:user_id]
    
    if @template.save
      @template.regenerate
      redirect_to [@template.user, @template], notice: 'Template was successfully created.'
    else
      flash[:error] = "Couldn't create template"
      render action: "new"
    end
  end

  def update
    @user = User.find(session[:user_id])
    @template = @user.templates.find(params[:id])
    if @template.update_attributes(params[:template])
      @template.regenerate
      redirect_to [@user, @template], notice: 'Template was successfully updated.'
    else
      flash[:error] = "Couldn't save template"
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @template = @user.templates.find(params[:id])
    unless @user.id == session[:user_id]
      not_authenticated
    else
      @template.destroy
      redirect_to @user
    end
  end
end
