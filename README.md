# Morpheus
## A RESTful API Client library built over Typhoeus
* The project is working toward a DSL that is very ActiveResource/ActiveRecord-like with some features stolen from other great libraries like DataMapper.
* We started working on this at a point when we felt we were pushing ActiveResource to its limits.
* We wanted a little more flexibility in terms of API coupling.
* We have plans to make Morpheus as flexible as possible in terms of query interface, and resource representation.
* Additionally, Morpheus is built on top of Typhoeus and will be building in intuitive interfaces for working with parallel requests.

    ```Ruby
    class Dummy < Morpheus::Base
      property :name
      property :created_at
      property :has_smarts

      belongs_to :thingy
      has_many :thingamabobs
      has_one :doohickey
    end
    ```

## Creating new resources
* Morpheus uses ActiveModel and so has an interface that tries to not stray too far from the similar ActiveRecord interface.

    ```Ruby
    @dummy = Dummy.new(
      :name       => "Dumb",
      :has_smarts => false,
      :thingy_id  => 2)                                # => #<Dummy:0x1016858d8>
    @dummy.new_record?                                 # => true
    @dummy.save                                        # => POST http://example.com/dummies
    ```

## Finding existing resources
* Resources can be retrieved with as little as their classname and unique identifier.

    ```Ruby
    @dummy = Dummy.find(1)                             # => GET http:example.com/dummies/1
    @dummy.new_record?                                 # => false
    @dummy.name                                        # => "Dumb"
    ```

## Updating existing resources
* Resources can be updated just in the same way you would expect from a Active* library.

    ```Ruby
    @dummy.name = "Dumber"                             # => "Dumber"
    @dummy.save                                        # => PUT http://example.com/dummies/1
    @dummy.update_attributes(:has_smarts => true)      # => PUT http://example.com/dummies/1
    ```

## Associations
* Morpheus was originally conceived at a point when we needed ActiveResource with a little more.
* Associations are a bit of that 'little more'.

    ```Ruby
    @dummy.thingy                                      # => GET http://example.com/thingies/2
    @dummy.thingamabobs                                # => GET http://example.com/dummies/1/thingamabobs
    @dummy.doohickey                                   # => GET http://example.com/dummies/1/doohickey
    ```

## Query Interface
* ARel has a beautiful query interface.
* We have ported its method-chaining style to fit our query interface.

    ```Ruby
    Dummy.all                                          # => GET http://example.com/dummies
    Dummy.find(1,2,3)                                  # => GET http://example.com/dummies?ids=1,2,3

    Dummy.where(:name => "Dumb")                       # => GET http://example.com/dummies?name=Dumb
    Dummy.where(:name => "Dumb", :has_smarts => false) # => GET http://example.com/dummies?name=Dumb&has_smarts=false
    Dummy.limit(1)                                     # => GET http://example.com/dummies?limit=1
    Dummy.result_per_page = 25                         # => 25
    Dummy.page(3)                                      # => GET http://example.com/dummies?limit=25&offset=50
    ```

## More about the project
Design informed by Service-Oriented Design with Ruby and Rails by Paul Dix, [Amazon](http://www.amazon.com/Service-Oriented-Design-Rails-Addison-Wesley-Professional/dp/0321659368)
