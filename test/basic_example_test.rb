require File.expand_path("../helper", __FILE__)

class BasicExampleTest < Test::Unit::TestCase
  def test_schema_uri
    assert_match 'draft-04', @@schema.schema_uri
  end

  def test_title
    assert_equal "Example", @@schema.title
  end

  def test_properties
    assert_equal 2, @@schema.properties.size

    assert property = @@schema.properties[0]
    assert_equal 'name', property.name
    assert_equal 'string', property.type
    assert property.options[:required]
  end

  @@schema = Schemagram.generate :draft_4 do
    title "Example"
    property :name, :string, :required => true
    property :age, :integer
  end
end

