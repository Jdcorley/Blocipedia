class User < ApplicationRecord
  has_many :collaborators
  has_many :wikis, through: :collaborators, dependent: :destroy

  after_save :check_role
  after_initialize :set_default_role, :if => :new_record?
  
  enum role: [:standard, :premium, :admin]

  devise :database_authenticatable, :registerable, :confirmable,
  :recoverable, :rememberable, :trackable, :validatable, 
  authentication_keys: [:login]

  attr_accessor :login

  def set_default_role
    self.role ||= :standard
  end 

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    validates :username, presence: :true, uniqueness: { case_sensitive: false }
    validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
    if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
   end
 end

private 

  def check_role 
    wikis = self.wikis 
    if self.standard?
      wikis.update_all private: false 
      puts wikis 
    end 
  end 
end
