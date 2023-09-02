require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Post #index Page', type: :feature do
  before do

    @user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
   
    @post1 = Post.create(author: @user1, title: 'Hello', text: 'This is my 1st post')
    @post2 = Post.create(author: @user1, title: 'Hello', text: 'This is my 2nd post')
    @post3 = Post.create(author: @user1, title: 'Hello', text: 'This is my 3rd post')
    @post4 = Post.create(author: @user1, title: 'Hello', text: 'This is my 4th post')
    @post5 = Post.create(author: @user1, title: 'Hello', text: 'This is my 5th post')
    @post6 = Post.create(author: @user1, title: 'Hello', text: 'This is my 6th post')

    @comment1 = Comment.create(post: @post1, author: @user1, text: 'Hi Tom!' )
    @comment2 = Comment.create(post: @post1, author: @user1, text: 'Hi Tom!' )
    @comment3 = Comment.create(post: @post1, author: @user1, text: 'Hi Tom!' )
    @comment4 = Comment.create(post: @post1, author: @user1, text: 'Hi Tom!' )
    @comment5 = Comment.create(post: @post1, author: @user1, text: 'Hi Tom!' )
    @comment6 = Comment.create(post: @post1, author: @user1, text: 'Hi Tom!' )

    Like.new(user: @user1, post: @post1)
  end

  it 'I can see the user/s profile picture.' do
    visit user_posts_path(@user1)
    expect(page.html).to include(@user1.photo)
  end

  it 'I can see the user/s username' do
    visit user_posts_path(@user1)
    expect(page).to have_content(@user1.name)
  end

  it 'I can see the number of posts each user has written' do
     visit user_posts_path(@user1)
    expect(page).to have_content("Number of posts: #{@user1.posts.count}")
  end

  it 'I can see a post/s title.' do
    visit user_posts_path(@user1)
    expect(page). to have_content(@post2.title)
  end

  it 'I can see some of the post/s body.' do
    visit user_posts_path(@user1)
     expect(page). to have_content(@post2.text)
  end

  it 'I can see the first comments on a post.' do
    visit user_posts_path(@user1)
    top_comments = @post1.comments.order(created_at: :desc).limit(5)
    top_comments.each do |comment|
      expect(page). to have_content(comment.text)
    end
  end

  it 'I can see how many comments a post has.' do
    visit user_posts_path(@user1)
    expect(page). to have_content(@post1.comments.count)
  end

  it 'I can see how many likes a post has.' do
    visit user_posts_path(@user1)
    expect(page). to have_content(@post1.likes.count)
  end 
  
  it 'can see a section for pagination if there are more posts than fit on the view.' do
   visit user_posts_path(@user1)
   expect(page). to have_content("Pagination")
  end

  it 'When I click on a post, it redirects me to that post/s show page.' do
    visit user_posts_path(@user1)
    click_on @post1.text
    expect(page).to have_current_path(user_post_path(@user1, @post1))
  end
 end