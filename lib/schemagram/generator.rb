module Schemagram
  class Generator
    attr_reader :object

    def initialize(object, &block)
      @object = object
      instance_eval(&block)
    end

    def type(value, &block)
      generator = Object.new(&block)
      @object.root = generator.object
    end

    def method_missing(method, *args)
      if args.size == 1 && @object.respond_to?("#{method}=")
        @object.send("#{method}=", args[0])
      elsif @object.respond_to?(method)
        block = block_given? ? Proc.new : nil
        @object.send(method, *args, &block)
      else
        super
      end
    end

    class Object < Generator
      def self.schema_class
        Schema::Object
      end

      def initialize(&block)
        super(self.class.schema_class.new, &block)
      end

      def property(name, type, options = nil)
        @object.properties <<
          if block_given? && type == :array
            generator = Array.new(&Proc.new)
            Schema::Array::Property.new(name, generator.object)
          else
            Schema::Object::Property.new(name, type, options)
          end
      end
    end

    class Array < Generator
      def self.schema_class
        Schema::Array
      end

      def initialize(&block)
        super(self.class.schema_class.new, &block)
      end

      def items(&block)
        instance_eval(&block)
      end
    end
  end
end

