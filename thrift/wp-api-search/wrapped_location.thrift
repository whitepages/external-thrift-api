# This file contains the search api person data wrapper.

namespace java com.whitepages.wp.api.search
namespace rb WP.API.Search

include "wp-data/location.thrift"
include "wp-data/constants.thrift"

# needed for hoisted fields
include "wp-data/referenced_location.thrift"
include "wp-data/referenced_legal_entity.thrift"

struct WrappedLocation {
  // inline until HOIST supported
  //1: required location.Location  base,  //@HOIST
  /* Unique persistent location_id for this location */
  1:  required constants.LocationID     id,

  /** Specifies the type of location this represents */
  2:  required location.LocationType             type,

  /**
   * Period this location is valid
   */
  3: optional constants.Period         valid_for,

  /**
   * Additional LegalEntities that share this address
   */
  4: optional referenced_legal_entity.ReferencedLegalEntities     legal_entities_at,

  /* Whether we have validated the address with a validation service */
  10: optional bool                  is_valid,

  /* Date & time the validation was performed */
  // TODO: rnoble to suggest improvements
  12: optional constants.Date   validated_at,

  // TODO: Document the validation codes that could appear here and why
  // TODO: rnoble to suggest improvements
  14: required list<string>   validation_codes,

  /** Normalized city name. Example "Olympia" */
  20:  optional string                   city,

  /** 5-digit US or 6 digit Canadian zipcode. Example "92019" or "S3D 3F3" */
  21:  optional string                   postal_code,

  /** 4-digit US zipcode extension. Example "1020" */
  22:  optional string                   zip4,

  /** 2-character state or province code. Example "WA" */
  23:  optional string                   state_code,

  /** Normalized country code. Example "US" */
  24:  optional string                   country_code,

  /** TimeZone information for this location */
  29: optional constants.Timezone                 time_zone,


  /*
   * List of references to locations which contain this location.
   * generally one of each level of granularity greater then the Type of this location, eg
   * 
   *  Address => postalcode, neighborhood, city, county, state, country
   *  State => country
   *  City => county, state, country
   *  County => state, country
   *  Locale => ??
   *  Neighborhood => postalcode, city, county, state, country
   *  PostalCode => city, county, state, country
   *  LatLong => postalcode, neighborhood, city, county, state, country
   *  LocationId => huh??
   *  Country => none
   *
   * NOTE: no guarentees are made that this field will contain useful data yet
   *  Expect that we will fill in Address type locations with at least
   *  city, county, state, country
   */
  31: required referenced_location.ReferencedLocations   contained_by_locations,

  /**
   * The complete street address, including both lines as appropriate.
   * Example "S 123 Huron Ave SE, Apt 1-A"
   */
  50: optional string                 address,

  /** House Number. Example "123" */
  51: optional string                 house,

  /** Street Name. Example "Huron" */
  52: optional string                 street_name,

  /** Indicator of street type (Ex "Ave" in "NW 45th Ave") */
  53: optional string                 street_type,

  /** Directional before a street name (Ex, "NW" in "NW 45th Str") */
  54: optional string                 pre_dir,

  /** Directional after a street name (Ex, "NW" in "3rd Ave NW") */
  55: optional string                 post_dir,

  /** Number of the apartment or suite (Ex, "1-A") */
  56: optional string                 apt_number,

  /** Name of unit type (Ex, "Suite" in "Suite 102") */
  57: optional string                apt_type,

  /** PO Box number */
  58: optional string                box_number,

  /* *
   * Output from the validation process
   *  - line1 - street address
   *  - line2 - street address overflow
   *  - location - city, state, zip
   */
  69: optional string                standard_address_line1,
  70: optional string                standard_address_line2,
  71: optional string                standard_address_location,


  /* *********************************************
   *
   * Address property fields.
   * The next 5 fields mirror the hive address table
   * values
   *   
   ***********************************************/

  /**
   * is_receiving_mail
   **/ 
  75: optional bool                   is_receiving_mail,

  /**
   * not_receiving_mail: reason why address does not recieve mail
   **/ 
  76: optional location.AddressNotReceivingMailReason not_receiving_mail_reason,

  /**
   * usage: address usage - residential or business
   **/ 
  77: optional location.AddressUsage           usage,


  /**
   * delivery_point: is it a po_box, or apartment building...
   **/ 
  78: optional location.DeliveryPointType delivery_point,

  /* *
   * box_type: what sort of po_box is it?
   *    contest box, facility box...
   **/ 
  79: optional location.BoxType                box_type,


  /* *
   * incomplete reason: text description of why the address
   * is incomplete
   **/ 
  80: optional location.AddressIncompleteReason  incomplete_reason,


  /* *
   * address_type: CASS record type, only populated if location_type is Address
   **/
  81: optional location.AddressType            address_type,


  // ---------------------------------------------------------------------------
  // Geo Location fields
  // ---------------------------------------------------------------------------

  /**
   * Latitude,longitude in degrees
   */
  101: optional constants.LatLong               lat_long,

  /**
   * Accuracy of geolocation information
   */
  108: optional location.GeoAccuracy   accuracy,

  // Additional search context for this specific location

  /**
   * Distance between lat/long of this location and the logical lat/long
   * of the search center (reference_location in query input)
   */
  200: optional constants.Distance distance,
}

# Copyright (c) 2012 by Whitepages, Inc. All Rights Reserved.
