require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { User.new(name: 'Syed Atril', posts_counter: 0) }

    context 'when name is present' do
      it 'is valid' do
        expect(user).to be_valid
      end
    end

    context 'when name is not present' do
      it 'is invalid' do
        user.name = nil
        expect(user).to_not be_valid
      end
    end

    context 'when posts_counter is non-negative' do
      it 'is valid' do
        expect(user).to be_valid
      end
    end

    context 'when posts_counter is negative' do
      it 'is invalid' do
        user.posts_counter = -1
        expect(user).to_not be_valid
      end
    end
  end

  describe '#recent_user_posts' do
    let(:user) { User.create(name: 'Syed Atril') }

    before do
      5.times do |i|
        user.posts.create(title: "Post #{i + 1}", text: "This is post #{i + 1}")
      end
    end

    it 'returns the most recent 3 posts of the user' do
      expect(user.recent_user_posts.length).to eq(3)
    end
  end
end
