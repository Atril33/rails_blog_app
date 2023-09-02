require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'User #index Page', type: :feature do
  before do

    @user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @user2 = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')

    Post.create(author: @user1, title: 'Hello', text: 'This is my 1st post')
    Post.create(author: @user2, title: 'Hello', text: 'This is my 2nd post')
  end

  it 'I can see the username of all other users' do
    visit users_path
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end

  it 'I can see the profile picture for each user' do
    visit users_path
    expect(page.html).to include(@user1.photo)
    expect(page.html).to include(@user2.photo)
  end

  it 'I can see the number of posts each user has written' do
    visit users_path
    expect(page).to have_content("Number of posts: #{@user1.posts.count}")
    expect(page).to have_content("Number of posts: #{@user2.posts.count}")
  end

  it 'When I click on a user, I am redirected to that user/s show page' do
    visit users_path
    click_link(@user1.name)
    expect(page).to have_current_path(user_path(@user1))
  end
end