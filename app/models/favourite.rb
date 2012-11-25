class Favourite < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  attr_accessible :name, :type
  friendly_id :name, use: :scoped, scope: :user
end
