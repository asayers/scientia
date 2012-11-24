class DocumentsController < ApplicationController
  before_filter :require_login, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
#    @documents = Document.where(user_id: session[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @document = @user.documents.find(params[:id])
    respond_to do |format|
      format.html
      format.js
      format.pdf { send_data @document.pdf, disposition: 'inline', type: 'application/pdf' }
      format.md { send_data @document.body, disposition: 'inline', type: 'text/plain' }
      format.tex { send_data @document.latex, disposition: 'inline', type: 'text/plain' }
    end
  end

  def new
    @user = User.find(session[:user_id])
    @document = Document.new(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:user_id])
    @document = @user.documents.find(params[:id])
    unless @user.id == session[:user_id]
      not_authenticated
    end
  end

  def create
    @document = Document.new(params[:document])
    @document.user_id = session[:user_id]
    @document.warnings = "Generating..."

    if @document.save
      DocumentWorker.perform_async(@document.id)
      redirect_to [@document.user, @document], notice: 'Document was successfully created.'
    else
      flash[:error] = "Couldn't create document"
      render action: "new"
    end
  end

  def update
    @user = User.find(session[:user_id])
    @document = @user.documents.find(params[:id])
    @document.warnings = "Generating..."
    
    if @document.update_attributes(params[:document])
      DocumentWorker.perform_async(@document.id)
      redirect_to [@user, @document], notice: 'Document was successfully updated.'
    else
      flash[:error] = "Couldn't save document"
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @document = @user.documents.find(params[:id])
    unless @user.id == session[:user_id]
      not_authenticated
    else
      @document.destroy
      redirect_to @user
    end
  end
end
