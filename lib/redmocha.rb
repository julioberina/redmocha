path = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift path
require "java"

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

Dir["#{path}/gdxlibs/\*.jar"].each do |jar|
  require jar.sub("#{path}/", "")
end

Dir["#{path}/includes/\*.rb"].each do |rb|
  require_relative rb.sub("#{path}/", "").sub(".rb", "")
end

def rm_import(klass)
  klass = klass.to_s.split("::")
  klass[klass.length-1] = klass.last.underscore.split("_").map { |w| w.upcase }.join("_")
  java_import klass.join("::")
end

def rm_include(interface)
  interface = interface.to_s.split("::")
  interface[interface.length-1] = interface.last.underscore.split("_").map { |w| w.upcase.join("_") }
  include interface.join("::")
end

class RMScreen
  include com.badlogic.gdx.Screen

  def initialize(game)
    @game = game
  end

  protected

  def render(delta)
    com.badlogic.gdx.Gdx.gl.glClearColor(0.0, 0.0, 0.0, 1.0)
    com.badlogic.gdx.Gdx.gl.glClear(com.badlogic.gdx.graphics.GL20::GL_COLOR_BUFFER_BIT)

    @game.batch.begin
    @game.font.draw(@game.batch, "RedMocha beats white mocha fam!", 20, 20)
    @game.batch.end
  end

  def show
  end

  def hide
  end

  def dispose
  end

  def pause
  end

  def resize(width, height)
  end

  def resume
  end
end

class RMGame < com.badlogic.gdx.Game
  attr_accessor :batch, :font, :title, :width, :height, :screen
  
  def create
    @batch = com.badlogic.gdx.graphics.g2d.SpriteBatch.new
    @font = com.badlogic.gdx.graphics.g2d.BitmapFont.new
    @screen = RMScreen.new(self)
    self.set_screen(@screen)
  end

  def render
    super
  end

  def dispose
    @batch.dispose unless @batch.nil?
    @font.dispose unless @font.nil?
  end

  def run
    com.badlogic.gdx.backends.lwjgl.LwjglApplication.new(self, @title, @width, @height)
  end

  protected

  def initialize(title = "RedMocha Game", width = 800, height = 600)
    @title = title
    @width = width
    @height = height
  end
end
