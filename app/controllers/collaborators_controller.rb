class CollaboratorsController < ApplicationController
  before_action :authenticate_user!

  def index 
    @wiki = Wiki.find(params[:wiki_id])
    @collaborators = @wiki.collaborators 
  end 

  def new 
    @collaborator = Collaborator.new 
  end 

  def create 
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find_by_email(params[:collaborator][:user])
    @collaborator = @user.collaborators.build
    @collaborator.wiki = @wiki 
    if @collaborator.save
      redirect_to [@wiki]
    else 
      render :index 
    end 
  end 
end 