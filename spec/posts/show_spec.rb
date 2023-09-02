require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Post #Show Page', type: :feature do
  before do

    @user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
   
    @post1 = Post.create(author: @user1, title: 'Hello', text: 'This is my 1st post')

    @comment1 = Comment.create(post: @post1, author: @user1, text: 'Hi Tom!' )
    @comment2 = Comment.create(post: @post1, author: @user1, text: 'Hi Tom!' )
    @comment3 = Comment.create(post: @post1, author: @user1, text: 'Hi Tom!' )
    @comment4 = Comment.create(post: @post1, author: @user1, text: 'Hi Tom!' )
    @comment5 = Comment.create(post: @post1, author: @user1, text: 'Hi Tom!' )
    @comment6 = Comment.create(post: @post1, author: @user1, text: 'Hi Tom!' )

    Like.new(user: @user1, post: @post1)
  end

  it 'I can see a post/s title.' do
    visit user_post_path(@user1, @post1)
    expect(page). to have_content(@post1.title)
  end

  it 'I can see who wrote the post.' do
    visit user_post_path(@user1, @post1)
    expect(page). to have_content(@post1.author.name)
  end

  it 'I can see how many comments a post has.' do
    visit user_post_path(@user1, @post1)
    expect(page). to have_content(@post1.comments.count)
  end

  it 'I can see how many comments a post has.' do
    visit user_post_path(@user1, @post1)
    expect(page). to have_content(@post1.likes.count)
  end 

  it 'I can see the post body.' do
    visit user_post_path(@user1, @post1)
    expect(page). to have_content(@post1.text)
  end

  it 'I can see the username of each commentor.' do
    visit user_post_path(@user1, @post1)
    @post1.comments.each do |comment|
      expect(page). to have_content(comment.author.name)
    end
  end
  
  it 'I can see the comment each commentor left.' do
    visit user_post_path(@user1, @post1)
    @post1.comments.each do |comment|
      expect(page). to have_content(comment.text)
    end
  end
end