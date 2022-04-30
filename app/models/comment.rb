class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  paginates_per 3

  validates_presence_of :body
end
