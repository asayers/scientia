class Supplement < ActiveRecord::Base
  belongs_to :document
  attr_accessible :name, :type
end
