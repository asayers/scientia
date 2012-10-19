class UrlSafeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^[-_a-z0-9]+$/i
      record.errors[attribute] << (options[:message] || "contains forbidden characters")
    end
  end
end

class WhitelistValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    whitelist = ["alex.sayers@gmail.com","test@test.com", "root@asayers.org"]
    unless whitelist.include? value
      record.errors[attribute] << (options[:message] || "has not been invited to the Closed Beta")
    end
  end
end


class User < ActiveRecord::Base
  extend FriendlyId
  has_many :documents
  has_many :templates
  has_many :bibliographies
  friendly_id :username

  attr_accessible :username, :email, :password, :password_confirmation
  
  authenticates_with_sorcery!

  validates_presence_of :username, :email, :password
  validates :username, :email, uniqueness: { case_sensitive: false }
  validates_length_of :password, minimum: 6
  validates_confirmation_of :password
  validates :username, url_safe: true
  validates :email, whitelist: true
end


