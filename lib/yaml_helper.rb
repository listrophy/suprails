class YAMLHelper
  def self.create_yaml(file, values)
    directory = File.dirname(file)
    create_directory_unless_exists(directory)
    File.open(file, 'w') {|f| f << YAML::dump(values) }
  end

  def self.modify_yaml(file, values)
    if File.exist?(file)
      config = YAML::load(File.open(file))
      config.merge!(values)
    else
      config = values
    end
    create_yaml(file, config)
  end

  protected
  def self.create_directory_unless_exists(directory)
    directory = File.expand_path(directory)
    dir_arr = directory.split('/')
    curr_dir = ""
    dir_arr.each do |dir|
      curr_dir << "/#{dir}"
      unless File.exist?(curr_dir)
        Dir.mkdir(curr_dir)
      end
    end
  end
end
