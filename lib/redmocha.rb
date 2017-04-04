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

  def hungarian
    # takes underscore string
    words = self.split("_")
    words.map { |w| if w == words.first then w else w.capitalize end }.join("")
  end
end

Dir["#{path}/gdxlibs/\*.jar"].each do |jar|
  require jar.sub("#{path}/", "")
end

Dir["#{path}/includes/\*.rb"].each do |rb|
  require_relative rb.sub("#{path}/", "").sub(".rb", "")
end

class RMGame
  include com.badlogic.gdx.ApplicationListener
  attr_reader :batch, :font, :shape, :config

  # When Application is first created
  def create
    @batch = com.badlogic.gdx.graphics.g2d.SpriteBatch.new
    @font = com.badlogic.gdx.graphics.g2d.BitmapFont.new
  end

  # Everytime Appication renders itself
  def render
    update
    @batch.begin
    @shape.begin unless @shape.nil?
    display
    @shape.end unless @shape.nil?
    @batch.end
  end

  # Enable ShapeRenderer
  def enable_shape_drawer
    @shape = com.badlogic.gdx.graphics.glutils.ShapeRenderer.new if @shape.nil?
  end

  # Disable ShapeRenderer
  def disable_shape_drawer
    unless @shape.nil?
      @shape.dispose
      @shape = nil
    end
  end

  # Get rid of resources used by Application
  def dispose
    @shape.dispose unless @shape.nil?
    @batch.dispose unless @batch.nil?
    @font.dispose unless @font.nil?
  end

  # Run the Application
  def run
    com.badlogic.gdx.backends.lwjgl.LwjglApplication.new(self, @config)
  end

  # Clear the screen with a certain color and alpha
  def clear(r, g, b, a)
    com.badlogic.gdx.Gdx.gl.glClearColor(r, g, b, a)
    com.badlogic.gdx.Gdx.gl.glClear(com.badlogic.gdx.graphics.GL20.GL_COLOR_BUFFER_BIT)
  end

  # User updates entities in game
  def update
    dispose
    raise NotImplementedError, "Must implement update method"
  end

  # User displays entities of game
  def display
    dispose
    raise NotImplementedError, "Must implement display method"
  end

  # Inherit these only when needed

  # When Application pauses
  def pause
  end

  # When Application resumes
  def resume
  end

  # Do something when Application is resized to certain dimensions
  def resize(width, height)
  end

  protected

  def initialize(title, width, height)
    @config = com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration.new
    @config.title = title
    @config.width = width
    @config.height = height
  end
end

