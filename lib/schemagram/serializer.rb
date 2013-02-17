require 'set'

module Schemagram
  class Serializer
    attr_reader :output

    def self.schema(schema)
      serialize do
        serialize_schema(schema)
        serialize_object(schema.root)
      end
    end

    def self.serialize
      instance = new
      instance.instance_eval(&Proc.new) if block_given?
      instance.output
    end

    def initialize
      @output = {}
    end

    def serialize_schema(schema, output = nil)
      if !output
        @output['$schema'] ||= schema.schema_uri
        output = @output
      end

      self
    end

    def serialize_object(object, output = @output)
      %w(title type).each do |attr|
        next unless value = object.send(attr)
        output[attr] = value.to_s
      end

      return if (properties = object.properties).empty?
      required = []
      properties_output = output['properties'] = {}
      properties.each do |property|
        properties_output[property.name] = serialize_property(property)
        (required << property.name) if property.options[:required]
      end
      output['required'] = required unless required.empty?

      self
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
