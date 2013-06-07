# This file contains the search api person data wrapper.

namespace java com.whitepages.wp.api.search
namespace rb WP.API.Search

include "wp-data/person.thrift"

# following includes needed for hoisted Person
include "wp-data/constants.thrift"
include "wp-data/person_info.thrift"
include "wp-data/legal_entity_common.thrift"
include "wp-data/work_info.thrift"
include "wp-data/media.thrift"
include "wp-data/url.thrift"
include "wp-data/email.thrift"
include "wp-data/im.thrift"
include "wp-data/social_link.thrift"
include "wp-data/related_phone.thrift"
include "wp-data/related_location.thrift"

struct WrappedPerson {
  // inline until HOIST supported
  //1: required person.Person      base,  //@HOIST
  /** Durable primary key */
  1:  required constants.PersonID          id,

  /** Alternate unique identifier */
  2: required person.PersonShortId                short_id

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


  // No known attributes at this level have been identified
  // 10: next attribute
}

# Copyright (c) 2012 by Whitepages, Inc. All Rights Reserved.
