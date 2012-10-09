class TemplateWorker
  include Sidekiq::Worker

  def perform(id)
    template = Template.find(id)
    latex, html = Document.find(1).compile(template.body)
    rtex = RTeX::Document.new(latex)
    begin
      template.pdf = rtex.to_pdf
    rescue
      template.warnings = "Latex rendering error!"
    else
      template.warnings = nil
    ensure
      template.save
    end

    if template.warnings = nil
      template.documents.each { |d| d.regenerate }
    end
  end
end
