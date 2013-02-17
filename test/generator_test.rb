require File.expand_path("../helper", __FILE__)

class GeneratorTest < Test::Unit::TestCase
  def test_sets_properties
    schema = Schemagram::Schema.new
    assert_nil schema.root

    Schemagram::Generator.new schema do
      type :object do
        title "foo"
      end
    end

    assert object = schema.root
    assert_equal "foo", object.title
  end

  def test_calls_methods
    schema = Schemagram::Schema.new
    assert_nil schema.root

    Schemagram::Generator.new schema do
      type :object do
        property :foo, :bar
      end
    end

    assert object = schema.root
    assert_equal 1, object.properties.size
    assert property = object.properties[0]
    assert_equal 'foo', property.name
    assert_equal 'bar', property.type
  end
end

