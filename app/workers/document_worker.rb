class DocumentWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(id)
    # Fetch records; create directory
    doc = Document.includes(:bibliography).find(id)
    bib = doc.bibliography ? doc.bibliography : Bibliography.find(1)
    dir = Dir.mktmpdir("scientia-")
    
    # Write source files
    source = File.open(dir+"/source.tex", 'w')
    biblio = File.open(dir+"/biblio.bib", 'w')
    source.puts doc.latex
    biblio.puts bib.body
    source.close
    biblio.close

    # Render
    begin
      puts "=> Beginning render...    (#{doc.name})"
      system("rubber --inplace --pdf #{source.path}")
    rescue
      # TODO: try to reclaim the errors
      puts "=> Something went wrong!  (#{doc.name})"
      doc.warnings = "Latex rendering error!"
    else
      puts "=> Render successful!     (#{doc.name})"
      output = File.open(dir+"/source.pdf", 'r')
      doc.pdf = output.read
      output.close
      doc.warnings = nil
    ensure
      # Tidy up; save
      FileUtils.remove_entry_secure dir
      doc.save
    end
      
#     The same, but with rubber-pipe?
#     IO.popen("rubber-pipe") do |io|
#       io.puts doc.latex
#       io.gets ...
#     end
#     if $? == 0 ...
   
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
