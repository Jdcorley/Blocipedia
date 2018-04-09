class Wiki < ApplicationRecord
  has_many :collaborators
  has_many :users, through: :collaborators
  belongs_to :user

  def collaborators
    Collaborator.where(collaborator_id: id)
  end 

  def users 
    User.where( id: collaborators.pluck(:user_id))
  end 
end
