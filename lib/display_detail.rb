module DisplayDetail
  def self.show(tables, tmp_arg)
    if tmp_arg[1].to_i > 0
      begin
        term = "SELECT * FROM #{tmp_arg[0]} where id = #{tmp_arg[1].to_i}"
        res = $conn.exec(term)
      rescue StandardError => e
        res = nil
      end

      if res
        res.each { |row|
          row.each do |key, value|
            puts "#{key}:".yellow + " #{value}\n"
          end
        }
      else
        puts "Can not find record, something went wrong".red
      end
    else
      puts "The second params need a integer!".red
    end
  end
end