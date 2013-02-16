require 'set'

module Schemagram
  class Serializer
    attr_reader :output

    def initialize(schema)
      @output = {"$schema" => schema.schema_uri}
      serialize_schema(schema)
      serialize_object(schema)
    end

    def serialize_schema(schema, output = @output)
      %w(title type).each do |attr|
        if value = schema.send(attr)
          output[attr] = value.to_s
        end
      end
    end

    def serialize_object(object, output = @output)
      return if (properties = object.properties).empty?
      required = []
      properties_output = output['properties'] = {}
      properties.each do |property|
        properties_output[property.name] = serialize_property(property)
        (required << property.name) if property.options[:required]
      end
      output['required'] = required unless required.empty?
    end

    def serialize_property(property)
      output = {'type' => property.type}
      property.options.each do |key, value|
        next if UnSerializableProperties.include?(key)
        output[key.to_s] = value
      end
      output
    end

    UnSerializableProperties = Set.new [:required]
  end
end
