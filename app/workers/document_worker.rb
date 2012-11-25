class DocumentWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(id)
    # Fetch records
    doc = Document.includes(:template).includes(:supplements).find(id)
    suppls = doc.supplements
    latex = doc.latex

    # Create directory; write files
    dir = Rails.root.join("data/documents/#{doc.id}")
    unless dir.exist?
      FileUtils.mkdir_p(dir)
    end
    source = File.open(dir.join("#{doc.slug}.tex"), 'w')
    source.puts(latex)
    source.close

    # Render
    puts "=> Beginning render...    (#{doc.name})"
    system("rubber --inplace --pdf #{source.path}")
    if $?.success?
      puts "=> Render successful!     (#{doc.name})"
      doc.warnings = nil
    else
      # TODO: try to reclaim the errors
      puts "=> Something went wrong!  (#{doc.name})"
      doc.warnings = "Latex rendering error!"
    end

    # Generate preview
    require 'RMagick'
    pdf = Magick::ImageList.new(dir.join("#{doc.slug}.pdf"))
    pdf[0].write(Rails.root.join("data/previews/#{doc.id}.png"))
     
    # Save at the end to prevent the page updating before the preview is done
    doc.save
    
#     The same, but with rubber-pipe?
#     IO.popen("rubber-pipe") do |io|
#       io.puts doc.latex
#       io.gets ...
#     end
#     if $? == 0 ...
   
  end
end
