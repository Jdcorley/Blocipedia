class WikiPolicy < ApplicationPolicy

  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def create?
    user.standard? || user.admin?
  end
  
  def edit?
    user.standard? || user.admin?
  end
  
  def update?
    user.standard? || user.admin?
  end

  def destroy?
    user.admin?
  end
end
