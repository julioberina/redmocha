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
