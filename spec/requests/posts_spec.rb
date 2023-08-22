require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /index" do
    it 'returns the response Status 200' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', id: 1)
      first_post = Post.create(author: user, title: 'Hello', text: 'This is my first post', id: 1)
      get "/users/1/posts"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include('I am a user/s all posts page!')
    end
  end

  describe "GET /show" do
    it 'returns the response Status 200' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', id: 1)
      post = Post.create(author: user, title: 'Hello', text: 'This is my first post', id: 1)
      get "/users/1/posts/1"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      expect(response.body).to include('I am a user/s specific post page!')
    end
  end
end
