# -*- encoding : utf-8 -*-"
#
# @author Andi Altendorfer <andreas@altendorfer.at>
#
require "rspec"
require File.expand_path('../../../app/models/template_finder',__FILE__)
require File.expand_path('../../../app/models/page_renderer',__FILE__)
require File.expand_path('../../../app/models/page',__FILE__)

describe PageRenderer do

  before(:each) do
    @app = Application.new(:test)
  end

  it "should render a page with a given template" do
    page = Page.create(id: 1, title: 'Testpage', text: "hello world")
    PageRenderer.new(page).render.should match( /<h1>Testpage<\/h1>/)
  end
end