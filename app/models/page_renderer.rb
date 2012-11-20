# -*- encoding : utf-8 -*-"
#
# @author Andi Altendorfer <andreas@altendorfer.at>
#

class PageRenderer
  attr_reader :page, :template

  def initialize(_page,_template=nil)
    @page = _page
    @template = _template || TemplateFinder.find('default')
  end

  def render(to_file=nil)
    _html = ERB.new(template.read)
    _result = _html.result(page.get_binding)
    if to_file
      _file = File.open(to_file,'w+')
      _file << _result
      _file.close
    end
    _result
  end
end