class Favourite < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :slug, :type
end
