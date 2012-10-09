class Template < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  has_many :documents
  friendly_id :name, use: :scoped, scope: :user

  attr_accessible :body, :name, :user, :user_id

  validates_presence_of :name, :user

  def regenerate
    self.pdf = nil
    self.warnings = nil
    if self.save
      TemplateWorker.perform_async(self.id)
    end
  end
end
