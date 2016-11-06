require 'rails_helper'
require 'capybara/rails'
require 'support/pages/movie_list'
require 'support/with_user'

RSpec.describe 'vote on movies', type: :feature do
  
  let(:page) { Pages::MovieList.new }

  context 'when logged out' do
    it 'cannot change its notify settings' do
      page.open
      expect {
        click_on "notify-status"
      }.to raise_error(Capybara::ElementNotFound)
    end
  end

  context 'when logged in' do
    with_logged_in_user
    before { page.open }
    
    it "has a default unsubscribed status" do
      expect(page).to have_link("Notify me!")
    end
    
    it "can be set to a subscribed status and changed back to unsubscribed" do
      click_on "notify-status"
      expect(current_path).to eq(root_path)
      expect(page).to have_link("Please stop sending emails!")

      click_on "notify-status"
      expect(current_path).to eq(root_path)
      expect(page).to have_link("Notify me!")
    end
    
  end
end