require File.expand_path("../helper", __FILE__)

class SchemagramTest < Test::Unit::TestCase
  def test_autoload_schema
    Schemagram.schemas[:test_schema] = ["test/unit", "SchemagramTest", "Schemas", "TestSchema"]
    assert_kind_of Array, Schemagram.schemas[:test_schema]

    assert_equal Schemas::TestSchema, Schemagram.schema(:test_schema)
    assert_equal Schemas::TestSchema, Schemagram.schemas[:test_schema]
  end

  module Schemas
    class TestSchema
    end
  end
end

