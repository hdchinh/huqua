module ReadSchema
  def self.read_schema(tables)
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
        puts "Something went wrong, missing schema.rb or syntax error...".red
      end
    end
  end
end
