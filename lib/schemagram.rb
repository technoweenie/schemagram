module Schemagram
  VERSION = "0.0.1"

  def self.generate(schema_key, &block)
    if schema_class = schema(schema_key)
      schema = schema_class.new
      Generator.new(schema, &block)
      schema
    else
      raise ArgumentError, "Unknown schema #{schema_key.inspect} in #{schemas.keys.inspect}"
    end
  end

  def self.schema(key)
    case value = schemas[key]
    when Array
      require value.shift
      klass = value.inject(Object) do |mod, name|
        mod.const_get(name)
      end
      schemas[key] = klass
    else
      value
    end
  end

  def self.schemas
    @schemas ||= {}
  end

  dir = File.dirname(__FILE__) << "/schemagram"
  require "#{dir}/schema"
  require "#{dir}/generator"
  require "#{dir}/serializer"

  schemas[:draft_4] = ["#{dir}/schemas/draft_4", "Schemagram", "Schemas", "Draft4"]
end
