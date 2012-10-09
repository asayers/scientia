class DocumentWorker
  include Sidekiq::Worker

  def perform(id)
    doc = Document.find(id)
    rtex = RTeX::Document.new(doc.latex)
    begin
      doc.pdf = rtex.to_pdf
    rescue
      doc.warnings = "Latex rendering error. Check your template!"
    else
      doc.warnings = nil
    ensure
      doc.save
    end
  end
end
