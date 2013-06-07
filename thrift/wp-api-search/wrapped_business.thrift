# This file contains the search api common definitions

namespace java com.whitepages.wp.api.search
namespace rb WP.API.Search

include "wp-data/business.thrift"

# following includes needed for hoisted Business
include "wp-data/constants.thrift"
include "wp-data/legal_entity_common.thrift"
include "wp-data/media.thrift"
include "wp-data/url.thrift"
include "wp-data/email.thrift"
include "wp-data/im.thrift"
include "wp-data/social_link.thrift"
include "wp-data/related_phone.thrift"
include "wp-data/related_location.thrift"

struct WrappedBusiness {
  // inline until HOIST supported
  //1: required business.Business  base,  //@HOIST
  /** Durable primary key */
  1:  required constants.BusinessID        id,

  /** Alternate unique identifier */
  2: required business.BusinessShortID     short_id,

  3: optional business.BusinessAltID       alt_id,

  /** business core name */
  5: required string                       name,

  6: optional string                       tagline,

  7: optional string                       description,

  # inline until HOISTING supported
  // common attributes shared petween people and businesses
  // 10: optional legal_entity_common.LegalEntityCommon common, //@HOIST
  /** Current and prior physical addresses for this entity */
  10:  optional related_location.RelatedLocations  locations,

  /** Current and prior phone numbers for this entity */
  11: optional related_phone.RelatedPhones         phones,

  //TODO should elements in this contact list be wrapped and labeled?
  /** List of email addresses for this listing */
  12:  optional list<email.Email>                  emails,

  //TODO should elements in this contact list be wrapped and labeled?
  /** List of IM addresses for this entity (currently not supported) */
  13:  optional list<im.Im>                        ims,

  /** List of media for this legal entity */
  14: optional list<media.Media>                   media,

  /** List of URLs for this legal entity */
  15: optional list<url.Url>                       urls,

  /** List of Social Network links for this legal entity */
  16: optional list<social_link.SocialLink>        social_links,


  // inline until HOIST is supported
  //  30: optional BusinessClaimInfo            claim_info, //@HOIST
  /** source of person info is online claim & edit capability; default: false */
  30:  required bool is_user_generated,
  /** claimed record, not third-party edit; default: false */
  31:  required bool is_claimed

  40: optional business.ProviderID                  provider,

  50: optional business.HoursOfOperation            hours_of_operation,
  51: optional list<string>                         payment_types,


  55: optional list<business.Subdepartment>         subdepartments,
  56: optional list<string>                         specialties,
  57: optional business.Chain                       chain,
  58: optional business.Category                    category,
  59: optional list<business.ProviderID>            additional_provider_ids,
  60: optional map<business.ProviderID, string>     enhanced_details_list


  // No known attributes at this level have been identified
  // 10: next attribute
}

# Copyright (c) 2012 by Whitepages, Inc. All Rights Reserved.
