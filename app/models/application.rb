# -*- encoding : utf-8 -*-"
#
# @author Andi Altendorfer <andreas@altendorfer.at>
#
require "logger"
class Application

  # @params [String] _env - :test, :develop, :production
  # @params [Hash] options - { :logger => $stdout, :log_level => Logger::INFO }
  def initialize(_env,options={})
    @defaults = { :logger => $stdout, :log_level => Logger::INFO }.merge(options)
    setup(_env)
    ensure_output_path
    ensure_data_path
  end

  def self.app
    @@app
  end

  def log(msg, level=nil)
    level ||=  @defaults[:log_level]
    @@logger.log(level, msg)
  end

  def output(msg)
    begin
      @@output << msg
    rescue => e
      puts "ERROR #{e.inspect}"
      puts msg
    end
  end

  def html_path
    @output_path ||= html_target_path()
  end

  def data_path
    @data_path ||= data_target_path()
  end

  def stylesheet_path
    @stylesheet_path ||= File.join(html_path,'assets')
    FileUtils.mkdir_p( @stylesheet_path ) unless File.directory?(@stylesheet_path)
    @stylesheet_path
  end

  def run( command=nil, *args)
    return 0 unless command
    ensure_output_path
    case command.to_sym
    when :version;     build_version_file; ERROR_NO_ERROR
    when :help;        print_help; ERROR_NO_ERROR
    else
      if CRUD_ACTIONS.include?(command.to_sym)
        log "INVOKING PAGES CONTROLLER ... ", Logger::DEBUG
        PagesController.new().send( command, *args )
        0
      elsif DEPLOYER_ACTIONS.include?(command.to_sym)
        log "INVOKING DISTRIBUTION CONTROLLER ... ", Logger::DEBUG
        DistributionController.new(data_path,html_path).send( command, *args )
        0
      else
        log "Command #{command.inspect} not found. ERR #{ERROR_COMMAND_NOT_FOUND}", Logger::ERROR
        ERROR_COMMAND_NOT_FOUND
      end
    end
  end

  private
  def print_help
    output "Help not implemented yet"
  end

  def build_version_file
    _f = File.open( File.join(html_path, 'version.html'), 'w+')
    _f.write(<<-_EOF_.gsub(/^    /,''))
    <html>
      <head>
        <title>SPM Version</title>
      </head>
      <body>
        <h1>Static Page Manager</h1>
        <p>VERSION = #{VERSION}</p>
      </body>
    </html>
    _EOF_
    _f.close()
  end


  def ensure_output_path
    unless File.directory?( html_path )
      Dir.mkdir( html_path )
    end
  end

  def ensure_data_path
    unless File.directory?( data_path )
      Dir.mkdir( data_path )
    end
  end

  def html_target_path
    case @environment
    when :test; File.expand_path('../../../html_test', __FILE__)
    when :development; File.expand_path('../../../html_development', __FILE__)
    else
      File.expand_path('../../../html', __FILE__)
    end
  end

  def data_target_path
    case @environment
    when :test; File.expand_path('../../../data_test', __FILE__)
    when :development; File.expand_path('../../../data_development', __FILE__)
    else
      File.expand_path('../../../data', __FILE__)
    end
  end

  def setup(_env)
    @@app = self
    @environment = _env
    @@logger = Logger.new(@defaults[:logger])
    @@output = @defaults[:stdout]
  end

end
