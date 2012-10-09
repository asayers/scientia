class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to current_user
    end
  end

  def tutorial
    @user = User.find("root")
    @document = @user.documents.find("welcome")
  end

  def status
    @user_count = User.count
    @document_count = Document.count
    @template_count = Template.count
    @bibliography_count = Bibliography.count
  end
end
