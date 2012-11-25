class SupplementsController < ApplicationController
  before_filter :require_login

  def create
    @suppl = Supplement.new(params[:supplement])
    unless @suppl.document.user.id == session[:user_id]
      not_authenticated
    end

    if @suppl.save
      redirect_to @suppl.document, notice: 'File was successfully added.'
    else
      redirect_to @suppl.document, notice: "Couldn't add file"
    end
  end
  
#  def update
#    @suppl = Supplement.find()
#
#    unless @suppl.document.user.id == session[:user_id]
#      not_authenticated
#    end
#
#    if @suppl.update_attributes(params[:supplement])
#      redirect_to @suppl.document, notice: 'File was successfully updated.'
#    else
#      redirect_to @suppl.document, notice: "Couldn't update file."
#    end
#  end
  
#  def destroy
#    @suppl = Supplement.find(params[:id])
#    unless @suppl.document.user.id == session[:user_id]
#      not_authenticated
#    else
#      @suppl.destroy
#      redirect_to @suppl.document
#    end
#  end
end
