base_dir = Rails.root.join("data")
req_dirs = ["documents", "templates", "previews"].map { |d| base_dir.join(d) }

req_dirs.each do |dir|
  unless dir.exist?
    FileUtils.mkdir_p(dir)
  end
end
