class CollaboratorsController < ApplicationController
  before_action :authenticate_user!

  def index
   
  end

  def show
    @collaborators = Collaborator.find(params[:email])
  end
  
  def new 
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
  end 

  def create 
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.build(collaborator_params)
    @collaborator.user = current_user
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @collaborator.destroy
  end 

  private

  def collaborator_params
    params.require(:collaborator).permit(:email, :wiki_id)
  end
end