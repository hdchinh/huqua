module DisplayStructure
  def self.show(tables, tmp_arg)
    if(['-v', '--v', '-version', '--version', 'version'].include?(tmp_arg[0]))
      puts "Your current version is: 2.0.0"
    else
      if(['-h', '--h', '-help', '--help', 'help'].include?(tmp_arg[0]))
        DisplayStructure.show_help
      else
        DisplayStructure.show_data(tables, tmp_arg)
      end
    end
  end

  def self.show_help
    puts "~> " + "Use " + "huqua".yellow + " to show overview of your database\n"
    puts "~> " + "Use " + "huqua table_name".yellow + " to show the structure of this table\n"
    puts "Ex: huqua users\n"
    puts "~> " + "Use " + "huqua table_name id".yellow + " to show detail record by id\n"
    puts "Ex: huqua users 2\n"
  end

  def self.show_data(tables, tmp_arg)
    begin
      term = "SELECT * FROM #{tmp_arg[0]} limit 1"
      res = $conn.exec(term)
    rescue StandardError => e
      res = nil
    end

    if res
      res.each { |row|
        row.each do |key, value|
          puts "#{key}".yellow
        end
      }
      puts "\n ~> To see more details type: " + "huqua #{tmp_arg[0]} id".green + " (ex: huqua #{tmp_arg[0]} 1)\n\n"
    else
      puts  "[warning]".yellow + "Can not find #{tmp_arg[0]} in database"
    end
  end
end
