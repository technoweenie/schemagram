module Schemagram
  class Schema
    class << self
      attr_accessor :schema_uri
    end

    attr_accessor :title
    attr_accessor :type
    attr_reader :properties
    attr_reader :schema_uri

    def initialize
      @schema_uri = self.class.schema_uri
      @properties = []
    end

    def to_hash
      Serializer.new(self).output
    end

    class Property
      attr_reader :name
      attr_reader :type
      attr_reader :options

      def initialize(name, type, options = nil)
        @name = name.to_s
        @type = type.to_s
        @options = options || {}
      end
    end
  end
end

