require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user_1) { User.create(name: 'John Doe') }
  let(:user_2) { User.create(name: 'Jane Smith') }
  let(:post_1) { Post.create(title: 'Testing RSpec Matchers', author: user_1) }

  it 'correctly updates the comments_count of the post after a new comment is added' do
    expect { Comment.create(author: user_2, post: post_1) }.to change { post_1.reload.comments_counter }.by(1)
  end
end
