class User < ApplicationRecord
  has_many :articles
  has_many :comments
  has_secure_password

  mount_uploader :avatar, AvatarUploader
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
