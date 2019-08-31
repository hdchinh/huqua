require 'pg'
require 'yaml'
require_relative 'string'
require_relative 'read_schema'
require_relative 'display_overview'
require_relative 'display_structure'
require_relative 'display_detail'

# Read database.yml
begin
  config_info = YAML.load_file('config/database.yml')

  $username = config_info["development"]["username"] || ENV["USER"]
  $password = config_info["development"]["password"] || ''
  $database = config_info["development"]["database"]
rescue StandardError => e
  puts "Missing database.yml or config in this file is wrong".red
end

# Connect to database
begin
  $conn = PG::Connection.connect(
    :hostaddr => "127.0.0.1", :port=>5432,
    :dbname   => $database,
    :user     => $username,
    :password => $password
	)
  puts "Congrats, you have good connection to database!\n".green
rescue StandardError => e
  puts "Can not connect to database...\n".red
end

# Main Class
class Huqua
  def self.notification
    tables = []
    if ARGV.size.zero?
      ReadSchema.read_schema(tables)
      DisplayOverview.show(tables)
    else
      tmp_arg = []
      ARGV.size.times { |item| tmp_arg.push(ARGV[item]) }

      if ARGV.size <= 2
        if(ARGV.size == 1)
          DisplayStructure.show(tables, tmp_arg)
        end
        if(ARGV.size == 2)
          DisplayDetail.show(tables, tmp_arg)
        end
      else
        puts "The number of arguments went wrong".red
      end
    end
  end
end
