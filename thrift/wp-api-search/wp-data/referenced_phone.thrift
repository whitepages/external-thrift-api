# This file contains the standard Referenced phone definitions.
#

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"

/** reference to Referenced phone with meta data about relationship */
struct ReferencedPhone {
  1: required constants.EntityID      phone_id,
  /** time period the relationship was valid */
  2: optional constants.Period        valid_for,
}

typedef list<ReferencedPhone> ReferencedPhones

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
