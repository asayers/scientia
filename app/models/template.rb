class Template < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  has_many :documents
  friendly_id :name, use: :scoped, scope: :user

  attr_accessible :body, :name, :user, :user_id

  validates_presence_of :name, :user

  def pdf
    begin
      f = File.open(Rails.root.join("data/templates/#{self.id}.pdf"), 'r')
    rescue
      pdf = nil
    else
      pdf = f.read
      f.close
    end
    return pdf
  end  
end
