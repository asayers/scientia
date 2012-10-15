class DocumentWorker
  include Sidekiq::Worker

  def perform(id)
    # TODO: create a temporary directory
    doc = Document.includes(:bibliography).find(id)
    bib = doc.bibliography ? doc.bibliography : Bibliography.find(1)
    # TODO: change these to source.tex and biblio.bib
    source = Tempfile.open(["source",".tex"], Rails.root.join("tmp/render"))
    biblio = Tempfile.open(["biblio",".bib"], Rails.root.join("tmp/render"))

    begin
      # TODO: change "<< biblio >>" to "biblio.bib" in the template
      source.puts doc.latex
      biblio.puts bib.body
    rescue
      # TODO: try to reclaim the errors
      doc.warnings = "Latex rendering error!"
    else
      doc.warnings = nil
    ensure
      # TODO: probably gonna have to destroy the directory here
      source.close
      biblio.close
      # TODO: check it saves correctly?
      doc.save
    end

#    rtex = RTeX::Document.new(doc.latex)
#    begin
#      doc.pdf = rtex.to_pdf
#    rescue
#      doc.warnings = "Latex rendering error. Check your template!"
#    else
#      doc.warnings = nil
#    ensure
#      doc.save
#    end
  end
end
