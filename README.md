external-thrift-api
===================

To gen-html

ssikora@scosikm0:~/repo/external-thrift-api$ thrift -r -gen html ~/repo/wp-api-search/thrift/wp-api-search


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
* {An overview of the graph model and key terminology[https://docs.google.com/a/whitepages.com/drawings/d/1MRwsoMD4WinksgbxHxgHlKLEfVRkAzqlCI6fQewGN5E/edit]
* {Relationships between the four core entity types[https://docs.google.com/a/whitepages.com/drawings/d/1p1G7CV33cVUfdQFMhq1h42bAopOEgHLbIUChpfgtl8s/edit]
* {Reference showing members of each entity type[https://docs.google.com/a/whitepages.com/drawings/d/19y5fY91Cj1O6CO8QjFBo2ysSW2EP9p8tkvby93ptIUg/edit]

#### Using find()

Example usage:

    query = WP::SAL::Query.new
    query.result_type = :person
    query.what(:last_name => "smith")
    query.where(:unparsed_location => "seattle,wa")
    r = sal.find(query)

The find() method also takes other arguments. See WP::SAL for details.

The result of a find() call is an instance of SearchResult. See below.

#### Using retrieve()

Example usage:

    id = WP::Data::EntityID[:person, "UUID"]
    r = sal.retrieve(id)
    r = sal.retrieve([ id, id .. ])

(Other simpler ways of specifing an ID will be provided. For now, you need to create
an instance of WP::Data::EntityID).

The result of a retrieve() call is an instance of SearchResult. See the next section.

#### Using the results of a find() or retrieve()

Both find() and retrieve() methods return the results in an instance of
WP::SAL::SearchResult, or raise an exception if any client-side errors occur. The
WP::SAL::SearchResult is an array, where each element is an entity (one of
WP::SAL::Person, WP::SAL::Business, WP::SAL::Location, WP::SAL::Phone and/or
WP::SAL::Null). The SearchResult array may be empty. Other methods on the Search Result
provide access to search informtion and exceptions.

The results can be treated as an array:

    r = sal.find(query)
    r.each do |result|
      # do something with result
    end

See gem-bin/sample-serp for an example of interating over the results and displaying them.

#### Traversing the graph

From any entity, you can follow links to other entities. If the target entity
was not loaded at time of the original find or retrieve, it will be transparently
loaded (using 'lazy-loading').

For example, if r is a WP::SAL::SearchResults containing people (WP::SAL::Person objects),
you can find the locations with which each person is associated using the locations
method. This returns an array (possibly empty but never nil) of WP::SAL::Location
objects:

    r.each do |person|
      # do something with person, such as
      puts person.best_name

      person.location.each do |location|
        # do something with location, such as
        puts location
        puts "  is valid for #{location.rel_valid_for}"
      end
    end

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

### Eager vs. lazy loading

Whenever you do a find() or retrieve(), you can specify an eager load depth. This value (which
defaults to 2 if not specified) determines how far in the graph to go for each result that matches
the query.

If you follow the graph beyond the eager load depth, entities will be retrieved as needed from the
server. The client does not need to do anything special to follow the graph to any desired depth.
The client can simply call the methods which return the linked classes, such as
locations on a person entity. For example, given a person object in person:

    locations.each do |location|
      puts "This person is associated with... #{location}"
    end

### Data Definitions

This gem defines the WP::SAL objects. The definition of WP::Data objects are in the wp-data
gem; the definition of WP::API::Search objects are in the wp-api-search gem.

### Internal APIs

As well as the APIs described above, there are two low-level API methods which provide direct access
to the methods defined in the SAL service (currently these are implemented locally).

These methods take arguments that are thrift objects (from WP::API::Search or WP::Data namespaces)
and return thrift objects.

These methods are:

    r = sal.retrieve(ids, context)  # id is an Array of WP::Data::EntityID objects
                                    # context is a WP::API::Search::Context object
                                    # r is a WP::API::Search::Result object

    r = sal.find(queries, context)  # queries is a WP::API::Search::Query
                                    # r and context are as for sal.retrieve
                                    # very few fields in 'queries' are supported

## Specification and Testing

To run the spec tests, use

    bundle exec rspec -c -fd spec/ut    # unit tests (do not access wp-sal-dispatch)
    bundle exec rspec -c -fd spec/it    # integration tests (uses wp-sal-dispatch)


## Limitations

Find-person-by-person only talks to das, and find-business-by-business only talks to bsrpc. This means
that phones that belong to a person discovered by a find-person-by-person will not have businesses
in their belongs_to field. The same is true for locations: a location discovered in a similar manner
will not report any businesses in its legal_entities_at. Similarly, phones and locations do not have
outward links to people when those phones and locations were discovered via a find-business-by-business.
This mirrors legacy behavior, and was done for performance reasons. If you want fully-defined
belongs_to/legal_entities_at, do a reverse-phone or reverse-location query.

Currently we link from a business to a location_id, but have no way to reverse this lookup. This means we
cannot properly populate businesses at a location that was not specified as part of the originaly query parameters.
We may update bsrpc to fix this soon.

# Developing and Testing SAL

SAL relies on four main gems:

[wp-sal]          The client library containing methods that client programs will call. This
                  gem calls methods in wp-sal-dispatch (in the future, wp-sal-dispatch will become
                  a service, and wp-sal will call wp-sal-dispatch as a service).
[wp-sal-dispatch] The code to query upstream services and return the results to wp-sal.
[wp-data]         The Thrift object definitions (and generated Ruby and Java code) for the
                  representation of data objects at Whitepages (people, locations, etc).
[wp-search-api]   The service API exposed by wp-sal-dispatch and corresponding object definitions.

Obtain the SAL code:

   cd src         # or wherever you put your local code repos
   git clone git@github.dev.pages:Development/wp-sal
   cd wp-sal

Install dependent gems and make sure the unit tests pass:

   bundle install
   bundle exec rspec -c spec/ut

You can now use SAL to access sample fixture data. Alternatively,
you can configure SAL to access live services, as described
in the next section.

