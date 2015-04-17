class Attachment < ActiveRecord::Base
  def uploaded_file(contest, params)
    puts contest.inspect
    incoming_file = params[:attachment][:attachment]
    name =  'test.csv'
    directory = "public/"
    path = File.join(directory, name)
    
    File.open(path, "wb") { |f| f.write(incoming_file.read) }
    
    projects = CSV.open(path)
    projects.drop(1).each do |row|
      puts row.inspect
      parameters = {"name" => row[0], "location" => row[1]}
      category_name = row[2]
      if !contest.categories.exists?("name"=> category_name)
        create_category(contest, category_name)
      end
      parameters["category_id"] = contest.categories.find_by_name(category_name).id
      @project = contest.projects.build(parameters)
      @project.save
      puts @project.inspect
    end
    
=begin    
    
    workbook = Spreadsheet.open(path)
    worksheet = workbook.worksheet(0)
    worksheet.default_format = "standard"
    1.upto worksheet.last_row_index do |index|
      row = worksheet.row(index)
      puts row.format(2).name
      puts row[2]
      parameters = {"name" => row[0].to_s, "location" => row[1].to_s}
      if !contest.categories.exists?("name"=> row[2])
        create_category(contest, row[2])
      end
      parameters["category_id"] = contest.categories.find_by_name(row[2]).id
      @project = contest.projects.build(parameters)
      @project.save
      puts @project.inspect
    end
    
=end
    
  end
  
  def create_category(contest, category_name)
    parameters = {"name" => category_name}
    @category = contest.categories.build(parameters)
    @category.save
  end

  # def filename=(new_filename)
  #   write_attribute("filename", sanitize_filename(new_filename))
  # end

  # private
  # def sanitize_filename(filename)
  #   #get only the filename, not the whole path (from IE)
  #   just_filename = File.basename(filename)
  #   #replace all non-alphanumeric, underscore or periods with underscores
  #   just_filename.gsub(/[^\w\.\-]/, '_')
  # end
end
