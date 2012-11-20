# -*- encoding : utf-8 -*-"
#
# @author Andi Altendorfer <andreas@altendorfer.at>
#
require "rspec"
require File.expand_path('../../../app/models/template_finder',__FILE__)

describe "TemplateFinder" do

  it "should initialize a template" do
    template = TemplateFinder.find('default')
    template.class.should == Template
  end

end