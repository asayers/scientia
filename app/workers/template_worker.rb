class TemplateWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(id)
  end

  def old_perform(id)
    # Fetch records; create directory
    template = Template.find(id)
    latex, html = Document.find(1).compile(template.body)
    dir = Dir.mktmpdir("scientia-")
    
    # Write source files
    source = File.open(dir+"/source.tex", 'w')
    source.puts latex
    source.close

    # Render
    begin
      puts "=> Beginning render...        (#{template.name})"
      system("rubber --inplace --pdf #{source.path}")
    rescue
      # TODO: try to reclaim the errors
      puts "=> Something went wrong!      (#{template.name})"
      template.warnings = "Latex rendering error!"
    else
      puts "=> Render successful!         (#{template.name})"
      output = File.open(dir+"/source.pdf", 'r')
      template.pdf = output.read
      output.close
      template.warnings = nil
    ensure
      # Tidy up; save
      FileUtils.remove_entry_secure dir
      template.save
    end

    # Recompile related documents
    if template.warnings = nil
      template.documents.each { |d| d.regenerate }
    end
  end
end
