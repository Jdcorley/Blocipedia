class Collaborator < ApplicationRecord
  validates :user, :presence => true, :uniqueness => {scope: :wiki}
  belongs_to :user
  belongs_to :wiki
end