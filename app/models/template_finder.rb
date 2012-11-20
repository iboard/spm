# -*- encoding : utf-8 -*-"
#
# @author Andi Altendorfer <andreas@altendorfer.at>
#
require File.expand_path('../template.rb', __FILE__)

module TemplateFinder

  TEMPLATE_PATH = File.expand_path('../../../templates',__FILE__)

  def self.find(name)
    filename = File.join( TEMPLATE_PATH, name + ".html.erb" )
    Template.new( filename )
  end

end