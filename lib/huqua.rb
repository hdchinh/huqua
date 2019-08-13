require 'pg'
require 'yaml'

# make color for output messages
class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(33)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end

# read database.yml file
begin
  config_info = YAML.load_file('config/database.yml')

  $username = config_info["development"]["username"] || ENV["USER"]
  $password = config_info["development"]["password"] || ''
  $database = config_info["development"]["database"]
rescue StandardError => e
  puts "Missing database.yml or config in this file is wrong".red
end

# start connect to database
begin
	$conn = PG::Connection.connect(
	  :hostaddr => "127.0.0.1", :port=>5432,
	  :dbname   => $database,
	  :user     => $username,
	  :password => $password
	)
  puts "Congrats, you have good connection to database !\n".green
rescue StandardError => e
  puts "Can not connect to database...\n".red
end

# main class
class Huqua

  def self.notification
    tables = []
    # no prams
    if ARGV.size.zero?
	    # read schema.rb file, collect tables name.
	    begin
		    File.open("db/schema.rb", "r") do |f|
			    f.each_line do |line|
				    if line.include?("create_table")
				  	  short_line = line.delete(' ')
				  	  table_name = ""
				  	  i = 13
				  	  while short_line[i] != "'" && short_line[i] != '"'
				  		  table_name << short_line[i].to_s
				  		  i = i + 1
						  end
				  	  tables.push(table_name)
				    end
				  end
			  rescue StandardError => e
				  puts "Something is wrong, Missing schema.rb or syntax error.".red
			  end
			end

			# read and show tables name and size data.
			if !tables.size.zero?
			  puts "You have #{tables.size} tables in your database:".green
			  tables.size.times do |n|
				  term = "SELECT count(id) FROM #{tables[n]}"
				  # get size table
				  begin
	    		  res = $conn.exec(term)
	    	  rescue StandardError => e
					  res = nil
				  end
				  # make color for fun
				  if n % 2 == 0
					  if res
						  puts "- #{tables[n]} (#{res[0]['count']})".blue
					  else
						  puts "Can not find #{tables[n]} in database".red
					  end
				  else
					  if res
						  puts "- #{tables[n]} (#{res[0]['count']})".yellow
					  else
						  puts "Can not find #{tables[n]} in database".yellow
					  end
				  end
			  end
		  end
	  end

		# params
		if !ARGV.size.zero?
		  # 1 params
		  if ARGV.size <= 2
			  if ARGV.size == 1
				  begin
					  term = "SELECT * FROM #{ARGV[0]} limit 1"
			      res = $conn.exec(term)		
				  rescue StandardError => e
					  res = nil
				  end
				  if res
				    res.each{ |row|
				      puts "The first record:".red << "#{row}\n"
				    }
			    else
			      puts "* Can not find #{tables[n].red} in database"
			    end
			  end

			  # 2 params
			  if ARGV.size == 2
				  if ARGV[1].to_i > 0
					  begin
						  term = "SELECT * FROM #{ARGV[0]} where id = #{ARGV[1].to_i}"
					    res = $conn.exec(term)								
					  rescue StandardError => e
						  res = nil
					  end
					  if res
					    res.each{ |row|
					      puts "The first record:".red << "#{row}\n"
					    }
				    else
				  	  puts "Can not find record, something is wrong".red
				    end
				  else
					  puts "The second params need a integer".red	
				  end
			  end	
			else
			  puts "The number of parameters is wrong".red
		  end
	  end
  end
  # end main class
end
