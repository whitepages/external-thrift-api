external-thrift-api
===================


## Introduction and Overview
WhitePages, Inc Pro API gives businesses the ability to easily integrate and leverage its industry leading People and Business search. The API is accessed via a RESTful interface using simple GET requests. The WhitePages.com API will provide JSON responses by default. This protocol is simple to use and accessible from any common web programming language on any machine with Internet access.  

WhitePages has organized it's data around four major entity types;

* [Phone](http://whitepages.github.io/external-thrift-api/gen-html/wrapped_phone.html): A phone number, familiar to us all, eg 206-285-0429.  Phones have phone numbers (obviously), carriers, line types (mobile, landline, etc) and other characteristics.
* [Person](http://whitepages.github.io/external-thrift-api/gen-html/wrapped_person.html): A person, always with a name, eg Scott Sikora.  People have birth dates, genders (male or female), and other characteristics.
* [Business](http://whitepages.github.io/external-thrift-api/gen-html/wrapped_business.html): A business, with a name, eg WhitePages.  Businesses have start dates, categories (eg Pizza Shop) and other characterstics.
* [Location](http://whitepages.github.io/external-thrift-api/gen-html/wrapped_location.html): A physical location, eg 1301 5th Avenue.  Locations have latitude and longitude coordinates, addresses, types (house, apartment, etc) and other characteristics.

WhitePages provides two major API calls;  

* [Find](http://whitepages.github.io/external-thrift-api/gen-html/search_service.html): Using [query parameters](http://whitepages.github.io/external-thrift-api/gen-html/query.html), find one or more People, Phones, Locations or Businesses.
* [Retrieve](http://whitepages.github.io/external-thrift-api/gen-html/search_service.html): Given the ID of a Person, Phone, Location or Business, retrieve more information.

### The WhitePages Graph

For information about the data graph model exposed by this API, see:

* [An overview of the graph model and key terminology](https://docs.google.com/a/whitepages.com/drawings/d/1MRwsoMD4WinksgbxHxgHlKLEfVRkAzqlCI6fQewGN5E/edit)
* [Relationships between the four core entity types](https://docs.google.com/a/whitepages.com/drawings/d/1p1G7CV33cVUfdQFMhq1h42bAopOEgHLbIUChpfgtl8s/edit)
* [Reference showing members of each entity type](https://docs.google.com/a/whitepages.com/drawings/d/19y5fY91Cj1O6CO8QjFBo2ysSW2EP9p8tkvby93ptIUg/edit)

#### Using find()

Example usage:

    query.result_type = :person
    query.what(:last_name => "smith")
    query.where(:unparsed_location => "seattle,wa")
    r = sal.find(query)

The find() method also takes other arguments. See [query parameters](http://whitepages.github.io/external-thrift-api/gen-html/query.html) for details.

The result of a find() call is an instance of SearchResult. See below.

#### Using retrieve()

Example usage:

    id = WP::Data::EntityID[:person, "UUID"]
    r = sal.retrieve(id)
    r = sal.retrieve([ id, id .. ])


#### Using the results of a find() or retrieve()

Both find() and retrieve() methods return the results in an instance of [Result](http://whitepages.github.io/external-thrift-api/gen-html/result.html#Struct_Result) or return an [ServerException](http://whitepages.github.io/external-thrift-api/gen-html/server_exception.html#Struct_ServerException) if any errors occur.


#### Traversing the graph

From any entity, you can follow links to other entities. For example, if a [Result](http://whitepages.github.io/external-thrift-api/gen-html/result.html#Struct_Result) contains [People](http://whitepages.github.io/external-thrift-api/gen-html/wrapped_person.html) you can find the locations with which each person is associated with in the Locations field.


#### Entity, Relationship, Navigation and Results fields

Each entity (such as a WP::SAL::Person instance) contains a set of per-entity methods,
such as "names" for Person, "phone_number" for Phones, and so on.

In addition, each entity can also include additional fields:

* Some fields depend on the link used to access the entity. These are
  called "Relationship fields", and are things like the period for
  which the link is valid.

* Some fields show how the entity was accessed by traversing the
  graph.  These are called "Navigation fields" and are things like the
  depth and parent entity.

* Some fields show search results information, such as score. These
  are only available on entities accessed directly from a
  SearchResults object.




### To gen-html


ssikora@scosikm0:~/repo/external-thrift-api$ thrift -r -gen html thrift/wp-api-search
