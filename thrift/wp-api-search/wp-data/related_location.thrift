# This file contains the standard related location definitions.
#

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"
include "referenced_location.thrift"

/** reference to related location with meta data about relationship */
struct RelatedLocation {
  // Inline until HOIST is supported
  //1: required referenced_location.ReferencedLocation ref,  //@HOIST
  1: required constants.EntityID      location_id,
  /** time period the relationship was valid */
  2: optional constants.Period        valid_for,

  20: optional constants.ContactType   contact_type,
  /** text label describing the relationship, eg: Home, Office, Cell */
  21: optional string                  label,

  /** sharing level for this location */
  22: optional constants.SharingLevel       sharing_level
}

typedef list<RelatedLocation> RelatedLocations

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
