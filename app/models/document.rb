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
  belongs_to :bibliography
  friendly_id :name, use: :scoped, scope: :user

  attr_accessible :body, :name, :user, :user_id, :template_id, :bibliography_id

  validates_presence_of :name, :user
  validates :template, :bibliography, same_user: true


  # Retrieves the document's markdown, parses its metadata, compiles it to html
  # (using a hard-coded template) and latex(using the given template) and
  # returns an array of the resultant html and latex.
  # At some point I should escape the HTML to prevent code injection:
  # ERB::Util.html_escape(something)
  def compile(latex_template_body)
    document = self.body

    # Remove variable assignment lines from document and use them to populate hash
    hash = {}
    document.each_line do |line|
      if data = line.match(/^([^ ]*): +(.*)/)
        hash[data[1]] = data[2]
        document.sub!(/^.+\n/, "")
      else
        break
      end
    end

    # Use Kramdown to construct an abstract syntax tree
#    ast = Kramdown::Document.new(document)
    ast = MultiMarkdown.new(document)

    # Render HTML and Latex fragments
    html_frag   = ast.to_html
    latex_frag  = ast.to_latex

    # Hmmm... should probably set this in an initializer...
    html_template_body = "<div id='heading'><%if title%><h1><<title>></h1><%endif%><%if author%><h2><<author>></h2><%endif%></div><<body>>"

    # Render the final HTML and Latex by passing hash+fragment into a Mustache template
    html_template   = Liquid::Template.parse(html_template_body)
    latex_template  = Liquid::Template.parse(latex_template_body)
    html   = html_template.render(hash.merge("body" => html_frag))
    latex  = latex_template.render(hash.merge("body" => latex_frag.force_encoding("UTF-8")))
    return [latex, html]
  end

  def regenerate
    # Generate latex and html from the markdown in self.body and the template
    # passed into the function; reset pdf and warnings fields
    self.latex, self.html = compile(self.template ? self.template.body : Template.find(1).body)
    self.pdf = nil
    self.warnings = nil

    self.save

    # Queue a job to render the pdf
    DocumentWorker.perform_async(self.id)
  end
end
