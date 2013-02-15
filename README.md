# Schemagram

Generate JSON Schema files from Ruby.

```ruby
# Basic example at http://json-schema.org/examples.html
Schemagram.generate :v4 do
  title "Example Schema"
  property :firstName, :string, :required => true
  property :lastName, :string, :required => true
  property :age, :integer,
    :description => "Age in years",
    :minimum => 0
end
```

```ruby
# Simple example at http://json-schema.org/example1.html
Schemagram.generate :v4 do
  title "Product set"
  type :array
  items do
    title: "Product"
    type: "object"

    propery :id, :number, :required => true
      :description => "The unique identifier for a product"

    property :name, :string :required => true

    property :price, :number, :required => true
      :minimum => 0,
      :exclusive_minimum => true

    property :tags, :array do
      items :type => :string
      update(:min_items => 1, :unique_items => true)
    end

    property :dimensions do
      property :length, :number, :required => true
      property :width, :number, :required => true
      property :height, :number, :required => true
    end

    property :warehouseLocation,
      :description => "Coordinates of the warehouse with the product",
      :ref => 'http://json-schema.org/geo'
  end
end
```
