class Supplement < ActiveRecord::Base
  extend FriendlyId
  belongs_to :document
  attr_accessible :name, :type
  friendly_id :name, use: :slugged

  validates_presence_of :name, :type, :document
  validates :type, :inclusion => { :in => %w(bib), :message => "%{value} is not a valid type" }

  before_destroy do |suppl|
    begin
      File.delete(Rails.root.join("data/documents/#{self.document.id}/#{self.slug}.#{self.type}"))
    end
  end

  def body
    begin
      f = File.open(Rails.root.join("data/documents/#{self.document.id}/#{self.slug}.#{self.type}"), 'r')
    rescue
      body = nil
    else
      body = f.read
      f.close
    end
    return body
  end
end
