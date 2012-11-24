class DocumentWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(id)
    # Fetch records
    doc = Document.includes(:template).includes(:supplements).find(id)
    template = doc.template ? doc.template.body : Template.find(1).body
    supplements = doc.supplements

    # Remove variable assignment lines from document and use them to populate vars
    # TODO: replace with YAML parser
    md = doc.body
    vars = {}
    md.each_line do |line|
      if data = line.match(/^([^ ]*): +(.*)/)
        vars[data[1]] = data[2]
        md.sub!(/^.+\n/, "")
      else
        break
      end
    end

    # Use MD renderer to create a latex fragment and merge it into vars
    frag = MultiMarkdown.new(md).to_latex.force_encoding("UTF-8")
    vars.merge!("body" => frag)

    # Render the final Latex by passing hash+fragment into a Liquid/Mustache template
    latex = Liquid::Template.parse(template).render(vars)

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
    doc.save
      
#     The same, but with rubber-pipe?
#     IO.popen("rubber-pipe") do |io|
#       io.puts doc.latex
#       io.gets ...
#     end
#     if $? == 0 ...
   
  end
end
