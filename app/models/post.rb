class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_post_comments
    comments.order(created_at: :desc).limit(5)
  end

 after_save :update_post_counter

 private

   def update_post_counter
     author.update(posts_counter: author.posts.count)
   end
end
