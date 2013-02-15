module Schemagram
  VERSION = "0.0.1"

  def self.schema(key)
    case value = schemas[key]
    when Array
      require value.shift
      klass = value.inject(Object) do |mod, name|
        mod.const_get(name)
      end
      schemas[key] = klass
    else
    end
  end

  def self.schemas
    @schemas ||= {}
  end

  dir = File.dirname(__FILE__) << "/schemagram"
  require "#{dir}/schema"

  schemas[:draft_4] = ["#{dir}/schemas/draft_4", "Schemagram", "Schemas", "Draft4"]
end
