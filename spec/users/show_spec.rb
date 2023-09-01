require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'User #Show Page', type: :feature do
  before do

    @user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
   
    @post1 = Post.create(author: @user1, title: 'Hello', text: 'This is my 1st post')
    @post2 = Post.create(author: @user1, title: 'Hello', text: 'This is my 2nd post')


  end

  it 'I can see the user/s profile picture.' do
    visit user_path(@user1)
    expect(page.html).to include(@user1.photo)
  end

  it 'I can see the user/s username' do
    visit user_path(@user1)
    expect(page).to have_content(@user1.name)
  end

  it 'I can see the number of posts each user has written' do
    visit user_path(@user1)
    expect(page).to have_content("Number of posts: #{@user1.posts.count}")
  end

  it 'I can see the user/s bio' do
    visit user_path(@user1)
    expect(page). to have_content(@user1.bio)
  end

  it 'I can see the user/s first 3 posts.' do
    visit user_path(@user1)
    top_posts = @user1.posts.order(created_at: :desc).limit(3)
    top_posts.each do |post|
      expect(page). to have_content(post.text)
    end
  end

  it 'I can see a button that lets me view all of a user/s posts.' do
    visit user_path(@user1)
    expect(page). to have_content("Show All Posts")
  end

  it 'When I click a user\'s post, it redirects me to that post\'s show page.' do
    visit user_posts_path(@user1)
    click_on @post2.text
    expect(page).to have_current_path(user_post_path(@user1, @post2))
  end  
  
  it 'When I click to see all posts, it redirects me to the user/s post/s index page.' do
    visit users_path
    click_link(@user1.name)
    expect(page).to have_current_path(user_path(@user1))
  end
end
