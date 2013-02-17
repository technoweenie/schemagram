module Schemagram
  class Schema
    class << self
      attr_accessor :schema_uri
    end

    attr_accessor :root
    attr_reader :schema_uri

    def initialize
      @schema_uri = self.class.schema_uri
    end

    def to_hash
      Serializer.schema(self)
    end

    class Object
      attr_accessor :title
      attr_reader :properties

      def type
        :object
      end

      def initialize
        @properties = []
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

    class Array
      def initialize
        @items = []
      end

      def type
        :array
      end

      class Property
        attr_reader :name
        attr_reader :array

        def initialize(name, array)
          @name = name
          @array = array
        end
      end
    end
  end
end

