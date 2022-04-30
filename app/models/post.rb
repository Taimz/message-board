class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments

  paginates_per 5
end
