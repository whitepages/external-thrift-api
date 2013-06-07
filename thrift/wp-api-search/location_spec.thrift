# Location input spec

namespace java com.whitepages.wp.api.search
namespace rb WP.API.Search

include "wp-data/constants.thrift"

struct ParsedAddress {
  1:  optional string			street_line_1,
  2:  optional string			street_line_2,
  3:  optional string                   city,

  /** 5- or 9- digit US or 6-digit Canadian zipcode. Example "92019" or "S3D 3F3" */
  4:  optional string                   postal_code,

  /** 2 character state code. Example "WA" */
  5:  optional string                   state_code,

  /** Normalized country code. Example "US" */
  6:  optional string                   country_code,
}

/** Union of supported location query input representations */
union LocationSpec {
  /* uninterpreted location string */
  1: string	   	    	raw,

  /** location by id */
  2: constants.LocationID	location_id,

  /** parsed address fields */
  3: ParsedAddress		parsed_address,

  /** geographic point */
  4: constants.LatLong		lat_long,
}

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
