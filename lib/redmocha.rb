path = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift path

require "java"
Dir["#{path}/gdxlibs/\*.jar"].each do |jar|
  require jar.sub("#{path}/", "")
end

Dir["#{path}/includes/\*.rb"].each do |rb|
  require_relative rb.sub("#{path}/", "").sub(".rb", "")
end

def rm_import(klass)
  
end

def rm_include(interface)
  
end

class RMScreen
  include RedMocha::Screen
  
  def initialize(game = nil)
    @game = game
  end
end

class RMGame < RedMocha::Game
  attr_accessor :title, :width, :height

  def initialize(title = "RedMocha Game", width = 800, height = 600)
    @title = title
    @width = width
    @height = height
  end

  def create
  end

  def run
    LwjglApplication.new(self, @title, @width, @height)
  end
end
