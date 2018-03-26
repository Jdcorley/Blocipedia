class HomeController < ApplicationController
  def index 
  end 


  def myaccount
  end 

  def downgrade_account
    current_user.role = 'standard'
    current_user.save! 
    redirect_to home_index_path
    puts current_user.role 
  end 
end