require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    it 'returns the response Status 200' do
      get "/users"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    # expect(response.body).to include('I am all users page!')
    end
  end

  describe "GET /show" do
    it 'returns the response Status 200' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', id: 1)
      get "/users/1"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
     # expect(response.body).to include('I am a specific user!')
    end
  end
end
