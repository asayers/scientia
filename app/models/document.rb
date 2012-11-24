class SameUserValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.nil? or value.user == record.user
      record.errors[attribute] << (options[:message] || "must be owned by you")
    end
  end
end

class Document < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  belongs_to :template
  has_many :supplements
  friendly_id :name, use: :scoped, scope: :user

  attr_accessible :body, :name, :user, :user_id, :template_id, :template

  validates_presence_of :name, :user
  validates :template, same_user: true

  def pdf
    begin
      f = File.open(Rails.root.join("data/documents/#{self.id}/#{self.slug}.pdf"), 'r')
    rescue
      pdf = nil
    else
      pdf = f.read
      f.close
    end
    return pdf
  end

  def state
    if warnings.nil?
      :success
    elsif warnings == "Generating..."
      :generating
    else
      :error
    end
  end
end
