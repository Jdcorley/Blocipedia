class User < ApplicationRecord
  has_many :collaborators
  has_many :collaborated_wikis, through: :collaborators, source: :wiki, dependent: :destroy
  has_many :wikis

  devise :database_authenticatable, :registerable, :confirmable,
  :recoverable, :rememberable, :trackable, :validatable, 
  authentication_keys: [:login]

  after_initialize :set_default_role, :if => :new_record?

  enum role: [:standard, :premium, :admin]

  def set_default_role
    self.role ||= :standard
  end 

  after_save :check_role 

  attr_accessor :login

  include ActiveModel::Dirty 

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    validates :username, presence: :true, uniqueness: { case_sensitive: false }
    validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
    if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions[:username].nil?
        where(conditions).first
      elseproduct
        where(username: conditions[:username]).first
   end
 end

private 

  def check_role 
   if self.role_changed?(from:'premium', to: 'standard')
      wikis = self.wikis 
      wikis.update_all private: false
   end 
 end 
end 