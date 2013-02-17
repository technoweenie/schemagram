module Schemagram
  class Generator
    def initialize(object, &block)
      @object = object
      instance_eval(&block)
    end

    def type(value, &block)
      @object.setup_type(value, &block)
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
      def property(name, type, options = nil)
        @object.properties << Schema::Property.new(name, type, options)
      end
    end
  end
end

