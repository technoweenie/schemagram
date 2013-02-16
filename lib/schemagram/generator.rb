module Schemagram
  class Generator
    def initialize(object, &block)
      @object = object
      instance_eval(&block)
    end

    def property(name, type, options = nil)
      @object.properties << Schema::Property.new(name, type, options)
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
  end
end

