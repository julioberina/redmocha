require "java"

Dir["libs/\*.jar"].each { |jar| require jar }

java_import com.badlogic.gdx.Gdx
java_import com.badlogic.gdx.Game
java_import com.badlogic.gdx.graphics.GL20
