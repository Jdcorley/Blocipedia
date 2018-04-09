class Collaborator < ApplicationRecord
  belongs_to :user
  belongs_to :wiki

  attr_accessor :email

  def self.user
    Collaborator.where( id: pluck(user_id) )
  end 

  def self.collaborators 
    Collaborator.where( id: pluck(:collaborator_id) )
  end 

  def collaborator 
    Collaborator.find(collaborator_id)
  end 

  def user
    User.find(user_id)
  end 
end
