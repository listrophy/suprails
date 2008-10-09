#
# SuprailsPlugins
#

module SuprailsPlugins
  def initialize
    @plugins = []
  end
  
  def <<(plugin)
    @plugins.push(plugin)
  end
  
  def load_specified_plugins
    plugins = get_specified_plugins
  end
  
  private
  
  def get_specified_plugins
    available_plugins = []
    Dir.open('plugins') do |dir|
      dir.each {|fn| available_plugins << fn if plugins.include?(fn[/[^\.]*/,0])}
    end
    available_plugins
  end
end