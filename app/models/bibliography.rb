class Bibliography < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  has_many :documents
  friendly_id :name, use: :scoped, scope: :user

  attr_accessible :body, :name, :user, :user_id

  validates_presence_of :name, :user
end
