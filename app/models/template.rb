# -*- encoding : utf-8 -*-"
#
# @author Andi Altendorfer <andreas@altendorfer.at>
#

class Template
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def read
    File.read(path)
  end

end