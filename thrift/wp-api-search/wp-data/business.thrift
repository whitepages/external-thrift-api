# This file contains the core person data definition.

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"
include "legal_entity_common.thrift"

# following includes needed for hoisted legal_entity_common
include "media.thrift"
include "url.thrift"
include "email.thrift"
include "im.thrift"
include "social_link.thrift"
include "related_phone.thrift"
include "related_location.thrift"

/**
 * ALternative unique short key for a Business object.  (This is also known as the shortid or seoid.)
 */
typedef string BusinessShortID

typedef string BusinessAltID

/** information about the online claim status of a business */
struct BusinessClaimInfo {
  /** source of person info is online claim & edit capability; default: false */
  1:  required bool is_user_generated,
  /** claimed record, not third-party edit; default: false */
  2:  required bool is_claimed
}

typedef list<string> HoursOfOperation

typedef string ProviderID

typedef constants.uuid Chain
typedef constants.uuid Category

struct Subdepartment {
  1: required string name,
  2: optional list<related_phone.RelatedPhones> phones,
  3: optional HoursOfOperation hours_of_operation
}

/**
 * The listing object is the bucket that contains all of the data returned in
 * the search results. Most members of the listing will be optional and will
 * often be empty.
 */
struct Business {
  /** Durable primary key */
  1:  required constants.BusinessID        id,

  /** Alternate unique identifier */
  2: required BusinessShortID              short_id,

  3: optional BusinessAltID		   alt_id,  // used for third party entity lookup

  /** business name */
  5: required string                       name,

  6: optional string			   tagline,

  7: optional string			   description,

  # inline until HOISTING supported
  // common attributes shared petween people and businesses
  // 10: optional legal_entity_common.LegalEntityCommon common, //@HOIST
  /** Current and prior physical addresses for this entity */
  10:  optional related_location.RelatedLocations  locations,

  /** Current and prior phone numbers for this entity */
  11: optional related_phone.RelatedPhones         phones,

  //TODO should elements in this contact list be wrapped and labeled?
  /** List of email addresses for this listing */
  12: optional list<email.Email>                  emails,

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
  30: required bool is_user_generated,
  /** claimed record, not third-party edit; default: false */
  31: required bool is_claimed,

  40: optional ProviderID			provider,
  // does client need attribution provider?

  50: optional  HoursOfOperation		hours_of_operation,
  51: optional  list<string>			payment_types,

  // bsrpc supplies "data: Hash" WTF?

  // detail_urls to be represeted with special type in urls above
  // website_url too
  // not including wp_prem_campaign stuff
  // TODO make EnhancedDetails union ******************************************
  // TODO make ReviewSummary object, with review object ***********************
  // TODO make Menu object, and provider enum *********************************
  // TODO make Chain object (comment out count for now) ***********************
  // TODO make Category object ************************************************
  // TODO make ProviderID object (name, id:string) ****************************
  // Citysearch and Avvo provide ratings (probably not comparable)
  // DDC has 'products' .... do we care?
  // Create TrackingUrl type with name, url, description

  55: optional list<Subdepartment> subdepartments,
  56: optional list<string> specialties,
  57: optional Chain chain,
  58: optional Category category,
  59: optional list<ProviderID> additional_provider_ids,
  60: optional map<ProviderID, string> enhanced_details_list
}

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
