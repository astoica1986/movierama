class NotifiesController < ApplicationController
  # No real point in using CanCan for this controller
  def create
    current_user.subscribe
    redirect_to root_path
  end
  
  def destroy
    current_user.unsubscribe
    redirect_to root_path
  end
end