# -*- encoding : utf-8 -*-"
#
# @author Andi Altendorfer <andreas@altendorfer.at>
#

class PagesController

  include ApplicationHelper

  def initialize(*args)
    Application.app.log( "PagesController initialized with args: #{args.inspect}", Logger::DEBUG)
  end

  def create(*params)
    Application.app.log( "Create/Update page with: #{params.first.inspect}", Logger::DEBUG)
    Page.create(params.first)
  end
  alias_method :update, :create

end