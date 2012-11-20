# -*- encoding : utf-8 -*-"
#
# @author Andi Altendorfer <andreas@altendorfer.at>
#
require "rspec"
require File.expand_path('../../../app/models/template',__FILE__)

describe Template do

  it "should load template file" do
    template = Template.new(File.expand_path('../../../templates/default.html.erb',__FILE__))
    template.read.should match(/<html>/)
  end

end