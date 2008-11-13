class InsertionHelper
  
  def self.insert_at filename, line_number, contents
    file_contents = File.readlines(filename)
    file_contents.insert(line_number-1, "#{contents}\n")
    File.open(filename, 'w') {|f| f << file_contents }
  end
  
  def self.file_sub! filename, pattern, contents
    file_contents = File.read(filename)
    file_contents.sub!(pattern, contents)
    File.open(filename, 'w') {|f| f << file_contents }
  end
end