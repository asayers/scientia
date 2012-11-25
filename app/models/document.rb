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

  before_destroy do |doc|
    begin
      FileUtils.remove_entry_secure(Rails.root.join("data/documents/#{doc.id}"))
      File.delete(Rails.root.join("data/previews/#{doc.id}.png"))
    end
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

  def preview
    begin
      f = File.open(Rails.root.join("data/previews/#{self.id}.png"), 'r')
    rescue
      png = nil
    else
      png = f.read
      f.close
    end
    return png
  end

  def latex
    md = self.body
    templ = self.template.body
    vars = {}
    
    # Remove variable assignment lines from document and use them to populate vars
    # TODO: replace with YAML parser
    md.each_line do |line|
      if data = line.match(/^([^ ]*): +(.*)/)
        vars[data[1]] = data[2]
        md.sub!(/^.+\n/, "")
      else
        break
      end
    end

    # Use MD renderer to create a latex fragment and merge it into vars
    #frag = MultiMarkdown.new(md).to_latex.force_encoding("UTF-8")
    #vars.merge!("body" => frag)

    # For now I'm just passing it straight through
    vars.merge!("body" => md)

    # Render the final Latex by passing hash+fragment into a Liquid/Mustache template
    latex = Liquid::Template.parse(templ).render(vars)
  end
end
