# This file contains the attributes for a listings social link.

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"


enum SocialNetwork {
     Facebook = 1,
     LinkedIn,
     Twitter,
     GooglePlus,
     Other = 255,
}

/**
 * This data structure will be used to support returning Social Link
 * information in search results and from Organic listings
 */
struct SocialLink {
  # the unique identifier provided by the social network
  1: required string  social_id,
  
  # the source of link
  2: required SocialNetwork source,

  # this maps to the vanity name/screen name/username from the service, if available
  3: optional string  user_name,

  //TODO core?
  # the social network application that fetched the ID (i.e. SCID, or Whitepages)
  # this is necessary because LinkedIn has unique IDs for a contact per-application
  4: required string  source_app,
  //TODO core?
  5: optional constants.SharingLevel  sharing_level

}

# Copyright (c) 2012 by Whitepages, Inc. All Rights Reserved.
