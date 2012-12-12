#!/usr/bin/env ruby
require File.expand_path('../../config/boot',__FILE__)
include SPM
require "erb"
require "fileutils"

def self.params(*args)
  options = {}
  args.each do |option|
    if option.any?
      option.each do |opt|
        x = opt.split(/\:/,2)
        options[x[0].to_sym] = x[1]
      end
    end
  end
  options
end

def print_syntax
  puts <<-EOF

     SimplePageManager
     -----------------
     1st define your pages in data_development/n.json
     where n is the number of the page (1.json,2.json,...)

     Example for file 1.json
     {"id":1,"title":"First Testpage", body: "Lorem ipsum ..."}

     Then call:

     bin/spm.rb build_pages  # ... will build html_development/1.html
     bin/spm.rb index format:html > html_development/index.html
     open html_development index.html # should show you a index page with link to 1.html
		 

  EOF
  .gsub(/^     /,'')
end

unless ARGV[0]
  print_syntax
else
  app = Application.new( :development )
  app.run(ARGV[0], params(ARGV[1..-1]))
end

