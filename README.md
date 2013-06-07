## Introduction and Overview

WhitePages, Inc Pro API gives businesses the ability to easily integrate and leverage its industry leading People and Business search. The API is accessed via a RESTful interface using simple GET requests. The WhitePages.com API will provide JSON responses by default. This protocol is simple to use and accessible from any common web programming language on any machine with Internet access.  

### The WhitePages Graph

WhitePages has organized it's data around four major entity types;

* [Phone](http://whitepages.github.io/external-thrift-api/gen-html/wrapped_phone.html): A phone number, familiar to us all, eg 206-285-0429.  Phones have phone numbers (obviously), carriers, line types (mobile, landline, etc) and other characteristics.
* [Person](http://whitepages.github.io/external-thrift-api/gen-html/wrapped_person.html): A person, always with a name, eg Scott Sikora.  People have birth dates, genders (male or female), and other characteristics.
* [Business](http://whitepages.github.io/external-thrift-api/gen-html/wrapped_business.html): A business, with a name, eg WhitePages.  Businesses have start dates, categories (eg Pizza Shop) and other characterstics.
* [Location](http://whitepages.github.io/external-thrift-api/gen-html/wrapped_location.html): A physical location, eg 1301 5th Avenue.  Locations have latitude and longitude coordinates, addresses, types (house, apartment, etc) and other characteristics.


For information about the data graph model exposed by this API, see:

* [An overview of the graph model and key terminology](http://whitepages.github.io/external-thrift-api/images/WP--SAL%20Entities%20and%20Graph%20Overview.pdf)
* [Relationships between the four core entity types](http://whitepages.github.io/external-thrift-api/images/WP--SAL%20Entity%20Relationships.pdf)
* [Reference showing members of each entity type](http://whitepages.github.io/external-thrift-api/images/WP--SAL%20Entity%20Members%20Reference.pdf)

### The WhitePages PRO API

WhitePages provides two major API calls;  

* [Find](http://whitepages.github.io/external-thrift-api/gen-html/search_service.html): Using [query parameters](http://whitepages.github.io/external-thrift-api/gen-html/query.html), find one or more People, Phones, Locations or Businesses.
* [Retrieve](http://whitepages.github.io/external-thrift-api/gen-html/search_service.html): Given the ID of a Person, Phone, Location or Business, retrieve more information.

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


<!-- To Generate HTML --> 
<!-- ssikora$ thrift -r -gen html thrift/wp-api-search --> 



## Appendix A:  JSON Result Format

### Description

Encapsulates the results of the query.

### Properties

| Key | Value Format | Description |
| --- | ------------ | ----------- |
| results           | Array\[EntityID\]         | The array of query result entity IDs. |
| dictionary        | Map\[EntityIDs&rarr;Entity\] | The dictionary of primary objects found during the query. |
| global_exceptions | Array\[Errors\]            | An array of errors. |

#### Results

The Array of EntityIDs that make up the result of the query. These IDs can be
looked-up in the `dictionary` to get the JSON serialization of the given entity.

#### Dictionary

A Map of EntityIDs to Entity JSON.  Relevant objects found in the `results` Array,
as well as the associated entities found in those results, are included in this
map.

#### Global Exceptions

An array of any warnings or errors found during this request.  Note that
sometimes warnings or errors can arise even when results are found.

## Person

| Key | Value Format | Description |
| --- | ------------ | ----------- |
| id | EntityID | The entity ID of this entity. |
| names | Array\[Name\] | The array of known names for this person. |
| birth_date | Date | The birthdate; check Age Range if blank. |
| age_range | AgeRange | The age range presented as a domain value. |
| death_date | Date | Date of death or null. |
| gender | Gender | Domain data for gender. |
| related_locations | Array\[EntityRelationship\] | Locations associated with this person |
| best_name | Name Struct | The best name from the array of names.
| best_location | Entity ID | The best location ID from the list of related locations. |
| associated_people | Array\[EntityRelationship\] | List of people associated. |
| phones | Array\[EntityRelationship\] | List of associated phones. |

### Example

```javascript
{
  "id": "Person|9c109eca-de36-4640-af66-32587d172285",
  "short_id": "8xzwyz7",
  "names": [
    {"first_name": "Amelia", "last_name": "Pond", "nicknames": ["Amy"]}
  ],
  "birth_date": null,
  "age_range": null,
  "death_date": null,
  "gender": "Male",
  "locations": [
    {
      "valid_for": {"start": { "year": 2012, "month": 11, "day": 8}},
      "contact_type": "home",
      "id": "Location|826e579f-1f86-4b9f-8641-b097da161b0e"
    }
  ],
  "phones": null,
  "best_name": "Max Rink",
  "best_location": "Location|826e579f-1f86-4b9f-8641-b097da161b0e",
  "associated_people": [
    {"id": "Person|27a01647-4e71-4d7f-8d0d-2183f6ea3193"},
    {"id": "Person|94f40255-d580-485d-906b-2b8ebcdfec9e"},
    {"id": "Person|3be3ddba-29c2-487d-9a39-9c6422abeb26"}
  ]
}
```

## Phone

Encapsulates the properties of a phone number.

| Key | Value Format | Description |
| --- | ------------ | ----------- |
| id | EntityID | The entity ID of this entity. | 
| line_type | Enumerated String | Gives the type of phone line. |
| belongs_to | Array\[EntityRelationship\] | Gives the EntityIDs for people and businesses that posess this phone number. |
| associated_locations | Array\[EntityRelationship\] | Gives the EntityIDs for locations associated with this phone number. |
| phone_number | String | The phone number |
| country_calling_code | String | Country calling code |
| extension | String or Null | The phone extension, if it has one |
| carrier | String | The telco carrier. |
| do_not_call | Boolean | Phone number on the do-not-call list? |
| repuatation | Number | The spam-score for this phone number
| best_location | EntityID | The EntityID of the best/preferred location from the associated loations |

### Landline Type

The landline type will be one of

* landline
* mobile
* voicemail
* tollfree
* premium
* non_fixed_voip
* fixed_voip
* other

### Example

```javascript
{
  "id": "Phone|599f6fef-a2e1-4b08-cfe3-bc7128b74bcc",
  "line_type": "landline",
  "belongs_to": [
    {"id":"Person|870bb764-8665-4add-92dc-0c457ccdeb60", "valid_for":{"start":{"year":2013,"month":2,"day":4}}}
    {"id":"Person|8bb8216a-1fb7-4b40-987a-f1d0ed66cc7d", "valid_for":{"start":{"year":2013,"month":2,"day":4}}},
    {"id":"Person|d94b9784-fe18-4eb2-915d-92996c353987", "valid_for":{"start":{"year":2013,"month":2,"day":4}}),
  ],
  "associated_locations": null,
  "phone_number": "7075552687",
  "display_phone": null,
  "country_calling_code": "1",
  "extension": null,
  "is_tracking": null,
  "carrier": null,
  "do_not_call": false,
  "reputation": null,
  "best_location": null
}
```

## Location

| Key | Value Format | Description |
| --- | ------------ | ----------- |
| id | EntityID | The entity ID of this entity. |
| type | LocationType | The type of this location. |
| valid_for | Period | The period of validity. |
| legal_entities_at | Array\[EntityRelationship\] | People and Businesses found at this location. |
| is_valid | Boolean | Has the address been validated. |
| validated_at | Date or null | Date of last validation, if on record. |
| city | String | The city. |
| postal_code | String | The postal code. |
| zip4 | String | The zip5 extension, if in US. |
| state_code | String | The state/province code. |
| country_code | String | The country code. |
| address | String | Complete street address. |
| house | String | House number. |
| street_name | String The name of the street. |
| street_type | String | Street type (i.e. "Hwy", "Ave" |
| pre_dir | String | Directional before a street name |
| post_dir | String | Directional after a street name |
| apt_number | String | Apartment number |
| apt_type | String | Unit type name, such as "Suite". |
| box_number | String | PO Box Number. |
| standard_address_line1 | String | The first line of the address. |
| standard_address_line1 | String | The second line of the address, |
| standard_address_location| String | The third line of the address. |
| is_receiving_mail | Boolean | Is the address receiving mail? |
| is_deliverable | Beoolean | Can mail be delivered to this address? |
| not_receiving_mail_reason | NotReceivingMailReason | If not receiving mail, what is the reason? |
| address_usage | AddressUsage | Is the address residential or business? |
| delivery_point | DeliveryPoint | What kind of delivery point type is this address? |
| box_type | BoxType | What kind of box is this address, if applicable. |
| address_type| AddressType | The type for this address. |
| lat_long | LatLong | The lat/long of this address in decimal degrees. |
| accuracy | GeoAccuracy | The accuracy of the lat/long given. |

### Location Type

Location type is one of

* address
* state
* city
* county
* neighborhood
* postalcode
* country
* zip_plus_4

### Address Type

* firm
* general_delivery
* highrise
* p_o_box
* rural_route
* street

### Not Receiving Mail Reason

* vacant
* new_construction
* rural

### Address Usage

* residentail
* business

### Delivery Point Type

* commercial_mail_drop
* p_o_box_throback
* p_o_box
* multi_unit
* single_unit

### Box Type

* facility
* contest
* detached
* non_personnel_unit
* school
* remittance
* caller_service

### Geo-Accuracy

* rooftop
* street
* postal_code
* city
* state
* country

### Examples

```javascript
{
  "id": "Location|b64589b0-e7af-416c-8d80-74652257ace4",
  "type": "address",
  "valid_for": {
    "start": {"year": 2012, "month": 2, "day": 29}
  },
  "legal_entities_at": [
    {"id": "Person|cb76a7ab-520e-4b9c-bff8-2d0fda0f24e8"},
    {"id": "Person|8bf5c76d-186b-4563-97cc-4583a9fbfa07"},
    {"id": "Person|9103c93f-2150-47d4-820c-32c3d8550006"},
    {"id": "Person|9366e6aa-9f87-43e8-8cf4-8d104528616b"},
    {"id": "Person|147a99fc-04c5-4577-8e73-f2e4197ab599"},
    {
      "valid_for": {"start": {"year": 2012, "month": 2, "day": 29}},
      "id": "Person|870bb764-8665-4add-92dc-0c457ccdeb60"
    }
  ],
  "is_valid": true,
  "validated_at": null,
  "city": "Sebastopol",
  "postal_code": "95472",
  "zip4": "6027",
  "state_code": "CA",
  "country_code": "US",
  "time_zone": null,
  "address": "4084 Gravenstein Hwy S, Sebastopol, CA 95472-6027",
  "house": "4084",
  "street_name": "Gravenstein",
  "street_type": "Hwy",
  "pre_dir": null,
  "post_dir": "S",
  "apt_number": null,
  "apt_type": null,
  "box_number": null,
  "standard_address_line1": "4084 Gravenstein Hwy S",
  "standard_address_line2": "",
  "standard_address_location": "Sebastopol, CA 95472-6027",
  "is_receiving_mail": true,
  "not_receiving_mail_reason": null,
  "usage": "residential",
  "delivery_point": "single_unit",
  "box_type": null,
  "address_type": "street",
  "lat_long": {"latitude": 38.360523, "longitude": -122.775069},
  "accuracy": "street"
}
```

## Business

| Key | Value Format | Description |
| --- | ------------ | ----------- |
| id | EntityID | The entity ID of this entity. |
| phones | Array\[EntityRelationship\] | List of associated phones. |
| name | String | Business name. |
| tagline | String | Optional business tagline. |
| description | String | Optional business description. |
| related_locations | Array\[EntityRelationship\] | Locations associated with this person |
| specialties | Array\[String\] | Business specialties. |
| chain | UUID | The businesss chain UUID, if in a chain. |

## EntityID

EntityIDs are encoded as single strings of the form `"type|UUID"`

Valid types are:

* `Person`
* `Phone`
* `Location`
* `Business`

### Examples

```javascript
"Location|11f66784-e436-4aa6-84c7-e53179c23ca8",
"Person|aca35f92-a04d-48cf-8cc7-a054e88d1293"
```

## Entity Relationship

Examples:

```javascript
{
    "id": "Person|03d2eacd-dc8e-4e23-9bb0-52194a3adae8",
    "valid_for": {"start":{"year":2011, "month":6, "day":27},
    "contact_type": "home"
}
```

## Date

Examples:

```javascript
{"year": 2011, "month":6, "day":27},
{"year": 2011, "month":6},
{"year": 2011},
```

## Name

Examples:

```javascript
{   "first_name": "Amelia",
    "last_name": "Pond",
    "nicknames": ["Amelia", "Amy"]
}
```
