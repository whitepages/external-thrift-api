# This file contains the standard company information definition.

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"

/**
 * Represents a unique company name and identifier. This company id can be
 * used to filter search results.
 */
struct Company {
  1: optional constants.uuid company_id,
  2: optional string         name,
  3: optional i32            count
}

// TODO: Should the company reference the listing_id for the company? NO: could have many locations

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
