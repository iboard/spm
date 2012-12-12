module SPM
  VERSION="0.0.0"
  require File.expand_path('../../app/helpers/application_helper', __FILE__)
  require File.expand_path('../../app/models/application', __FILE__)
  require File.expand_path('../../app/models/page', __FILE__)
  require File.expand_path('../../app/models/template_finder', __FILE__)
  require File.expand_path('../../app/models/template', __FILE__)
  require File.expand_path('../../app/models/page_renderer', __FILE__)
  require File.expand_path('../../app/controllers/pages_controller', __FILE__)
  require File.expand_path('../../app/controllers/distribution_controller', __FILE__)
  require 'json'

  ERROR_NO_ERROR          =  0
  ERROR_COMMAND_NOT_FOUND = -1
  ERROR_FILE_NOT_FOUND    = -2

  CRUD_ACTIONS = :new, :create, :update, :edit, :show, :delete
  DEPLOYER_ACTIONS = :build_pages, :clean_pages, :index, :build

  TEMPLATE_PATH = File.expand_path('../../templates',__FILE__)
  ASSETS_PATH   = File.expand_path('../../app/assets/stylesheets',__FILE__)

  def lorem
    "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
     sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
     Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi
     ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit
     in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur
     sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt
     mollit anim id est laborum.</p>\n"*(rand(5)+1)
  end

end
