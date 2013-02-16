require File.expand_path("../helper", __FILE__)

class GeneratorTest < Test::Unit::TestCase
  def test_sets_properties
    schema = Schema.new
    assert_nil schema.title

    Schemagram::Generator.new schema do
      title "foo"
    end

    assert_equal "foo", schema.title
  end

  def test_calls_methods
    schema = Schema.new
    assert_equal [], schema.properties

    Schemagram::Generator.new schema do
      property :foo, :bar
    end

    assert_equal [[:foo, :bar]], schema.properties
  end

  class Schema
    attr_accessor :title
    attr_reader :properties

    def property(name, type)
      @properties << [name, type]
    end

    def initialize
      @properties = []
    end
  end
end

