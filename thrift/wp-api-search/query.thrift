# This file contains the search api query definitions

namespace java com.whitepages.wp.api.search
namespace rb WP.API.Search

include "wp-data/constants.thrift"

include "name_spec.thrift"
include "location_spec.thrift"

/** Search query object definition */
struct Query {
  /** type of desired result entity */
  1: required constants.EntityType           result_entity,

  /**
   * "what" or name spec
   */
  2:  optional name_spec.NameSpec            what,

  /**
   * "Where" or interpreted location spec
   */
  3: optional location_spec.LocationSpec     where,

  /**
   * Contains a raw unparsed phone_number field
   */
  4: optional string                phone_number

  /** find all names that start with whatever is passed in "name" */
  10: optional bool                 first_name_begins_with

  /** only return "exact" matches */
  11: optional bool                 exact_name_match

  /** Return phonetically matched names, defaults to true */
  12: optional bool                 phonetic_name_match

  /** Needs to be restricted to legal max/min value */
  20:  optional constants.Distance search_radius,

}

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
