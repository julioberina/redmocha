Gem::Specification.new do |s|
  s.name = "redmocha"
  s.version = "0.0.5"
  s.date = "2017-01-19"
  s.description = "A JRuby wrapper for the Java game framework LibGDX"
  s.summary = "JRuby wrapper for LibGDX"
  s.authors = ["Julio Berina"]
  s.platform = "java"
  s.email = "julioberina@gmail.com"
  s.files = ["lib/redmocha.rb",
             "lib/gdxlibs/gdx-backend-lwjgl-natives.jar",
             "lib/gdxlibs/gdx-backend-lwjgl.jar",
             "lib/gdxlibs/gdx-natives.jar",
             "lib/gdxlibs/gdx-sources.jar",
             "lib/gdxlibs/gdx-tools.jar",
             "lib/gdxlibs/gdx.jar"
            ]
  s.homepage = "http://rubygems.org/gems/redmocha"
  s.license = "MIT"
end
