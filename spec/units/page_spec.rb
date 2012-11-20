# -*- encoding : utf-8 -*-"
#
# @author Andi Altendorfer <andreas@altendorfer.at>
#
require "rspec"
require "spec_helper"

describe Page do

  before(:each) do
    @app = Application.new(:test)
  end

  it "should store id and title" do
    Page.create( id: 1, title: 'Testpage' )
    json = JSON.parse( File.read( File.join( Page.data_path, "1.json") ))
    json['id'].should == 1
    json['title'].should == 'Testpage'
  end

  it "should find a page by it's id" do
    page = Page.find(1)
    page.title.should == 'Testpage'
  end
end