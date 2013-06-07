# This file contains the standard related Phone definitions.
#

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"
include "referenced_phone.thrift"

/** reference to related phone with meta data about relationship */
struct RelatedPhone {
  # inline until HOIST supported
  //1: required referenced_phone.ReferencedPhone ref,  //@HOIST
  1: required constants.EntityID      phone_id,
  /** time period the relationship was valid */
  2: optional constants.Period        valid_for,

  20: optional constants.ContactType   contact_type,
  /** text label describing the relationship, eg: Home, Office, Cell */
  21: optional string                  label,

  /**
   * The vanity string for the phone number. Can consist of numbers and
   * letters. Example "1-800-Flowers"
   */
  30: optional string                 vanity_string,

  /** this is a preferred phone contact */
  31: optional bool                    is_preferred,

  // group these in business extra info record
  32: optional bool		       is_tracking,  // remove from base phone
  33: optional string		       tracking_url,
  34: optional string		       campaign_id,

}

typedef list<RelatedPhone> RelatedPhones

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
