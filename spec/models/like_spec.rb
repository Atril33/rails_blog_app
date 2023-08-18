require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John Doe') }
  let(:post) { Post.create(title: 'Greetings from Mars', author: user) }

  it 'updates the likes_counter of the post after create' do
    expect do
      Like.create(user: user, post: post)
      post.reload
    end.to change(post, :likes_counter).by(1)
  end
end
