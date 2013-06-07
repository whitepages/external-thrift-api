# This file contains the standard person info definition.
#

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"

/**
 * This structure contains information on a person’s name. This structure can
 * be used in a number of ways including the current name for a person as well
 * as historical names.
 */
struct PersonName {
  1: optional string salutation,        /** eg: Mr. Mrs, Dr. */
  2: optional string first_name,
  3: optional string preferred_first_name,    /** Person's preferred name (Bob vs Robert) */
  4: optional string middle_name,
  5: optional string last_name,
  6: optional string suffix, /** eg: Jr., Sr., III, IV */
  // QUESTION: should nicknames be specific to fname/lname/etc?
  7: optional list<string> nicknames,
  8: optional constants.Period	valid_for,  //@HOIST
}

/**
 * The person info object contains information about the person referenced in the
 * listing, such as their name, gender and age range.
 */
// TODO: fully document fields
struct PersonInfo {
  1: optional list<PersonName>                                   names,

  /** may be hidden, check age_range if so */
  3: optional constants.Date                                     birth_date,
  /** supplied when birth_date is masked */
  4: optional constants.AgeRange                                 age_range,

  5: optional constants.Date                                     death_date,

  6: optional constants.Gender                                   gender,
}

# Copyright (c) 2012 by Whitepages, Inc. All Rights Reserved.
