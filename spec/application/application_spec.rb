# -*- encoding : utf-8 -*-"
#
# @author Andi Altendorfer <andreas@altendorfer.at>
#
require "rspec"
require "spec_helper"

describe Application do

  before(:each) do
    @app = Application.new(:test, logger: nil, log_level: Logger::FATAL)
  end

  after(:all) do
    @app = Application.new(:test, logger: nil, log_level: Logger::FATAL)
    (1..16).to_a.each do |i|
      Page.create(id: i, title: "Page #{i}", body: "This is test page #{i} " + lorem() )
    end
    @app.run(:index, :format => :html, :output => File.join(@app.html_path,'index.html'))
    @app.run(:build_pages)
  end

  it "should exit with 0 if no errors" do
    @app.run().should == 0
    @app.run(:version).should == 0
  end

  it "should exit with -n if any errors" do
    @app.run(:unknown_command).should <= 0
  end

  it "should create the version-page run(:version)" do
    @app.run( :version )
    output_file = File.join(@app.html_path, 'version.html')
    File.exists?( output_file ).should be_true, "No output file created"
    File.read( output_file ).to_s.should =~ /#{VERSION}/
  end

  it "should create data-file run(:create, 1, '...', '...')" do
    @app.run( :create, id: 1, title: 'Page One', body: 'Body One' ).should == 0
    data_file = File.join(@app.data_path, '1.json')
    File.read(data_file).should match(/Page One/)
    File.read(data_file).should match(/Body One/)
  end

  it "should update data-file run(:update, 1, '...', '...')" do
    @app.run( :update, id: 1, title: 'Modified Page One', body: 'Modified Body One' ).should == 0
    data_file = File.join(@app.data_path, '1.json')
    File.read(data_file).should match(/Modified Page One/)
    File.read(data_file).should match(/Modified Body One/)
  end

  it "should clean up the output path run(:clean_pages)" do
    Page.create(id: 1, title: "A page to test" )
    @app.run(:clean_pages)
    File.directory?(@app.html_path).should be_false
    File.directory?(@app.data_path).should be_false
  end

  it "should build output files for all pages run(:build_pages)" do
    Page.create(id: 1, title: "Page One" )
    Page.create(id: 2, title: "Page Two" )
    @app.run(:build_pages)
    @app.run(:index, :format => :html, :output => File.join(@app.html_path,'index.html'))
    File.read(File.join(@app.html_path,'1.html')).should match(/<h1>Page One<\/h1>/)
    File.read(File.join(@app.html_path,'2.html')).should match(/<h1>Page Two<\/h1>/)
  end

  it "should have created the index page run(:index)" do
    File.read(File.join(@app.html_path,'index.html')).should match(/<li>.*Page One/)
    File.read(File.join(@app.html_path,'index.html')).should match(/<li>.*Page Two/)
  end

  it "should create assets/pages.css" do
    @app.run(:build_pages).should == 0
    @app.run(:index, :format => :html, :output => File.join(@app.html_path,'index.html')).should == 0
    File.read(File.join(@app.html_path,'1.html')).should match(/assets\/pages.css/)
    File.read(File.join(@app.html_path,'2.html')).should match(/stylesheet/)
    File.exists?(File.join(@app.html_path,'assets','pages.css')).should be_true
  end

  it "should build all at once run(:build)" do
    @app.run(:build, format: :html, output:'html_test/index.html').should == 0
    File.read(File.join(@app.html_path,'1.html')).should match(/assets\/pages.css/)
    File.read(File.join(@app.html_path,'2.html')).should match(/stylesheet/)
    File.exists?(File.join(@app.html_path,'assets','pages.css')).should be_true
  end

end
