# -*- encoding : utf-8 -*-"
#
# @author Andi Altendorfer <andreas@altendorfer.at>
#
require File.expand_path('../application',__FILE__)
require "json"

class Page

  attr_reader :params

  def self.data_path
    @data_path ||= Application.app.data_path
  end

  def self.find(_id)
    begin
      _f = File.open( File.join(Page.data_path, _id.to_s + ".json"), "r")
      params = JSON.parse(_f.read())
      _f.close
      Page.new(params)
    rescue => e
      Application.app.log "ERROR #{e.inspect}", Logger::ERROR
      nil
    end
  end

  def self.create(_params)
    page = Page.new(_params)
    page.save!
    page
  end


  def initialize(*args)
    @params = args.first
  end

  def save!
    begin
      _f = File.open( File.join(Page.data_path, params[:id].to_s + ".json"), "w+")
      _f.write(params.to_json)
      _f.close
      true
    rescue => e
      raise "File Error #{e.inspect}"
    end
  end

  # check for params[:method]
  def method_missing(m, *args, &block)
    ( !defined?(params[m.to_s]) && !defined?(params[m.to_sym]) ) ? super : ( params[m.to_sym] || params[m.to_s] )
  end

  def get_binding
    binding
  end

end