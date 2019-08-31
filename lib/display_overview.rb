module DisplayOverview
  def self.show(tables)
    if !tables.size.zero?
      puts "You have #{tables.size} tables in your database:".green
      tables.size.times do |n|
        term = "SELECT count(id) FROM #{tables[n]}"
        begin
          res = $conn.exec(term)
        rescue StandardError => e
          res = nil
        end

        result = res ? "~> #{tables[n]} (#{res[0]['count']})".yellow : "Can not find #{tables[n]} in database".red
        puts result
      end
    end
  end
end
