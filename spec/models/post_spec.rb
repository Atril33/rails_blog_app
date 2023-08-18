require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post_author) { User.create(name: 'Alice Smith') }
  let(:post_title) { 'Sample Post Title' }

  it 'returns valid with correct title, author, and counters' do
    post = Post.new(title: post_title, author: post_author, comments_counter: 0, likes_counter: 0)
    expect(post).to be_valid
  end

  it 'returns invalid without a title' do
    post = Post.new(author: post_author, comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
    expect(post.errors[:title]).to include("can't be blank")
  end

  it 'returns invalid when the title exceeds 250 characters' do
    post = Post.new(title: 'A' * 251, author: post_author, comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
    expect(post.errors[:title]).to include("is too long (maximum is 250 characters)")
  end

  it 'validates likes_counter to be greater than or equal to zero' do
    post = Post.new(title: post_title, author: post_author, comments_counter: 0, likes_counter: -1)
    expect(post).to_not be_valid
    expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
  end

  it 'updates the author\'s posts_counter after save' do
    author = User.create(name: 'Bob Johnson')
    post = Post.create(title: post_title, author: author, comments_counter: 0, likes_counter: 0)
    author.reload
    expect(author.posts_counter).to eq(1)
  end

  describe '#recent_post_comments' do
    let(:comment_author) { User.create(name: 'Eve Adams') }
    let(:comment_post) { Post.create(title: post_title, author: post_author) }

    before do
      5.times do |i|
        Comment.create(post: comment_post, text: "Comment #{i + 1}", author: comment_author)
      end
    end

    it 'returns the 5 most recent comments' do
      recent_comments = comment_post.recent_post_comments
      expect(recent_comments.length).to eq(5)
      expect(recent_comments.map(&:text)).to eq(['Comment 5', 'Comment 4', 'Comment 3', 'Comment 2', 'Comment 1'])
    end
  end
end
