# -*- encoding : utf-8 -*-"
#
# @author Andi Altendorfer <andreas@altendorfer.at>
#
class DistributionController

  attr_reader :data_path, :html_path

  def initialize(_data_path, _html_path)
    @data_path = _data_path
    @html_path = _html_path
  end

  def build(*args)
    build_pages
    index(*args)
  end

  def build_pages(*args)
    Application.app.log("Sart building pages with args=#{args.inspect}", Logger::DEBUG)
    Dir.new(data_path).each do |data_file|
      unless File.directory?(data_file)
        Application.app.log("Found datafile #{data_file} to process", Logger::DEBUG)
        build_page(data_file)
      end
    end
  end

  def clean_pages(*args)
    Application.app.log("Clean up pages (#{html_path}, #{data_path})", Logger::DEBUG)
    FileUtils.remove_dir( html_path, true )
    FileUtils.remove_dir( data_path, true )
  end

  # :format => :html, :output => File.join(@app.html_path,'index.html')
  def index(options={})
    opts = {
      :format => :text,
      :output => $stdout,
    }.merge(options)
    build_index( opts[:format], opts[:output] )
  end

  private
  def build_page(data_file)
    id = data_file.gsub(/\.json$/,'')
    page = Page.find(id)
    template = TemplateFinder.find(page.template || 'default')
    renderer = PageRenderer.new(page,template)
    renderer.render(File.join(html_path, id + ".html"))
    update_assets
  end

  def build_index(format, output)
    _output = output.class == String ? File.open(output,"w+") : output
    Application.app.log("create index (#{format}, #{_output.inspect})", Logger::DEBUG)
    _output << render_index(format)
    _output.close if output.class == String
    update_assets
  end


  def render_index(format)
    @pages = ApplicationHelper.sorted_pages
    _template_file = File.join(TEMPLATE_PATH, "index.#{format.to_s}.erb")
    renderer = ERB.new( File.read( _template_file ) )
    renderer.result(binding)
  end

  def update_assets
    Dir.new( File.expand_path('../../assets/stylesheets',__FILE__)).each do |stylesheet|
      unless File.directory?(stylesheet)
        FileUtils.copy( File.join(ASSETS_PATH,stylesheet), File.join(Application.app.stylesheet_path, File.basename(stylesheet) ) )
      end
    end
  end



end
