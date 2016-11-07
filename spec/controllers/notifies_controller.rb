require 'rails_helper'

RSpec.describe NotifiesController, :type => :controller do
  
  describe "create" do
    xit "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "destroy" do
    xit "returns http success" do
      post :destroy
      expect(response).to have_http_status(:success)
    end
  end

end