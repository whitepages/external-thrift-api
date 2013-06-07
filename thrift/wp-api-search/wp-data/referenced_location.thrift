# This file contains the standard Referenced location definitions.
#

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"

/** reference to Referenced location with meta data about relationship */
struct ReferencedLocation {
  1: required constants.EntityID      location_id,
  /** time period the relationship was valid */
  2: optional constants.Period        valid_for,
}

typedef list<ReferencedLocation> ReferencedLocations

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
