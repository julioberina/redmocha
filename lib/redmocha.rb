$LOAD_PATH.unshift File.expand_path("gdxlibs")

require "java"
Dir["\*.jar"].each { |jar| require jar.sub("gdxlibs/", "") }

java_import com.badlogic.gdx.Gdx
java_import com.badlogic.gdx.Game
java_import com.badlogic.gdx.graphics.GL20

class RedMocha < Game
  attr_accessor :title, :width, :height
  
  def initialize(title = "RedMocha Game", width = 800, height = 600)
    @title = title
    @width = width
    @height = height
  end

  def run
    LwjglApplication.new(self, @title, @width, @height, true)
  end
end
