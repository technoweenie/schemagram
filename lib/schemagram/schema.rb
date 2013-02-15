module Schemagram
  class Schema
    class << self
      attr_accessor :schema_uri
    end

    attr_accessor :title
    attr_accessor :type
  end
end

