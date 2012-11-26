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

app = Application.new( :development )
puts "PARAMS=#{params(ARGV[1..-1]).inspect}"
app.run(ARGV[0], params(ARGV[1..-1]))

