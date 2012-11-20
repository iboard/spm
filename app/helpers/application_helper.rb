module ApplicationHelper

  def self.page_links
    "PAGES: " +
    ApplicationHelper.sorted_pages()
      .map { |p| "<a href='#{p.id}.html'>#{p.id}</a>" }
      .join(" | ")
  end

  def self.sorted_pages
    Dir.new(Application.app.data_path).sort { |a, b|
      _a = File.directory?(a) ? "0" : File.basename(a).gsub(/\.json/, '')
      _b = File.directory?(b) ? "0" : File.basename(b).gsub(/\.json/, '')
      _a.to_i <=> _b.to_i
    }.map {|p| Page.find(File.basename(p).gsub(/\.json/,'').to_i) unless File.directory?(p) }.flatten.compact
  end

end
