# This file contains the core person data definition.

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"
include "person_info.thrift"
include "legal_entity_common.thrift"
include "work_info.thrift"

# following includes needed for hoisted legal_entity_common
include "media.thrift"
include "url.thrift"
include "email.thrift"
include "im.thrift"
include "social_link.thrift"
include "related_phone.thrift"
include "related_location.thrift"


/**
 * Alternative unique short key for a Person object.  This is a sequence of lowercase alphanumeric characters,
 * leaving out the letters 'o' and 'l'.  (This is also known as the shortid or seoid.)
 */
typedef string PersonShortId

/** information about the online claim status of a person */
struct PersonClaimInfo {
  /** source of person info is online claim & edit capability */
  1:  required bool is_user_generated,
  /** claimed record, not third-party edit */
  2:  required bool is_claimed
}

/**
 * The listing object is the bucket that contains all of the data returned in
 * the search results. Most members of the listing will be optional and will
 * often be empty.
 */
struct Person {
  /** Durable primary key */
  1:  required constants.PersonID          id,

  /** Alternate unique identifier */
  2: required PersonShortId                short_id

  /** person's core name and demographic info */
  # inline until HOISTING supported
  # 10: required person_info.PersonInfo       info,  //@HOIST
  10: optional list<person_info.PersonName>                       names,

  /** may be hidden, check age_range if so */
  11: optional constants.Date                                     birth_date,
  /** supplied when birth_date is masked */
  12: optional constants.AgeRange                                 age_range,

  13: optional constants.Date                                     death_date,

  14: optional constants.Gender                                   gender,

  # inline until HOISTING supported
  // common attributes shared petween people and businesses 
  // 20: optional legal_entity_common.LegalEntityCommon common, //@HOIST
  /** Current and prior physical addresses for this entity */
  20:  optional related_location.RelatedLocations  locations,

  /** Current and prior phone numbers for this entity */
  21: optional related_phone.RelatedPhones         phones,

  //TODO should elements in this contact list be wrapped and labeled?
  /** List of email addresses for this listing */
  22:  optional list<email.Email>                  emails,

  //TODO should elements in this contact list be wrapped and labeled?
  /** List of IM addresses for this entity (currently not supported) */
  23:  optional list<im.Im>                        ims,

  /** List of media for this legal entity */
  24: optional list<media.Media>                   media,

  /** List of URLs for this legal entity */
  25: optional list<url.Url>                       urls,

  /** List of Social Network links for this legal entity */
  26: optional list<social_link.SocialLink>        social_links,


  /* Reserving this for future data team/claim-edit work.  Not refined yet. */
  /** work/job descriptions for this person */
  40: optional list<work_info.WorkInfo>  work_info,

  # inline until HOISTING supported
  //  50: optional PersonClaimInfo              claim_info, //@HOIST
  /** source of person info is online claim & edit capability */
  50:  required bool is_user_generated,
  /** claimed record, not third-party edit */
  51:  required bool is_claimed

}

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
