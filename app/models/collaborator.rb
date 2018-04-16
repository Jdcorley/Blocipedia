class Collaborator < ApplicationRecord
  validates :user, :presence => true, :uniqueness => true 
  belongs_to :user
  belongs_to :wiki
end