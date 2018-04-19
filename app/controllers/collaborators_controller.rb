class CollaboratorsController < ApplicationController
  before_action :authenticate_user!

  def index 
    @collaborated_wiki = Wiki.find(params[:wiki_id])
    @collaborators = @collaborated_wiki.collaborators 
  end 

  def new 
    @collaborator = Collaborator.new 
  end 

  def create 
    @collaborated_wiki = Wiki.find(params[:wiki_id])
    @user = User.find_by_email(params[:collaborator][:user])
    @collaborator = @user.collaborators.build
    @collaborator.wiki = @collaborated_wiki
    if @collaborator.save
      redirect_to [@collaborated_wiki, :collaborators] 
    else 
      flash[:alert] = 'There was an error adding this collaborator, please try again'
      redirect_to [@collaborated_wiki, :collaborators]
    end 
  end
  
  def destroy 
    @collaborated_wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])
    @collaborator.destroy.save
    if @collaborator.destroy
      flash[:notice] = 'Collaborator was removed successfully.'  
      redirect_to [@collaborated_wiki, :collaborators] 
    else 
      flash.now[:alert] = 'There was an error removing this collaborator.'
      redirect_to [@collaborated_wiki]
    end 
  end 

end 