require File.expand_path("../helper", __FILE__)

class SerializerTest < Test::Unit::TestCase
  # http://json-schema.org/examples.html
  def test_basic_example
    schema = Schemagram.generate :draft_4 do
      title "Example Schema"
      type :object
      property :firstName, :string, :required => true
      property :lastName, :string, :required => true
      property :age, :integer,
        :description => "Age in years",
        :minimum => 0
    end

    expected = {
      "$schema"=>"http://json-schema.org/draft-04/schema#",
      "title" => "Example Schema",
      "type" => "object",
      "properties" => {
        "firstName" => {
          "type" => "string"
        },
        "lastName" => {
          "type" => "string"
        },
        "age" => {
          "description" => "Age in years",
          "type" => "integer",
          "minimum" => 0
        }
      },
      "required" => ["firstName", "lastName"]
    }

    assert_equal expected, schema.to_hash
  end
end

