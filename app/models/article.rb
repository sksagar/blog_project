class Article < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :tags
end
