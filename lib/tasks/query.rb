


class Tasks::Query
  def initialize params
    @query= params[:query]
    @file_name= params[:file_name]
    @config= params[:config]
  end


  def uri
  URI.parse(ENV['DB_URL'])
  end

  def source_db
    PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password) 
  end

  def output_file
    @file_name
  end

  def destination_db
    PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password) 
  end

  def query
    @query
  end 

  def save_to_csv data
      
    s=CSV.generate do |csv|
      if data.length != 0
        column_names = data.first.keys
        csv << column_names
        data.each do |x|
          csv << x.values
        end
      end
    end 
    File.write("#{@file_name}", s)
  end

  def run
    begin
      output =[]
      source_db.exec(query).each do |row|
        output << row
      end
      @file_name.nil? ? (return output) : (save_to_csv output) 
    rescue Exception => e
      p ("An error occurred #{e.backtrace} - #{e.class} -- #{e.message}")
    end 
    
  end

end
