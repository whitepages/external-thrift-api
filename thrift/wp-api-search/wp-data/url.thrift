#
#
# Copyright (c) 2011 by Whitepages, Inc. All Rights Reserved.
#
# File name: url.thrift
# Author:    Jay Hoover
# Date:      03/16/2011
#
# This file contains the standard URL definition.
#

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"

/**
 * This class represents a URL that could be entered by the user, crawled,
 * sourced or generated. Type may or may not be known.
 */

// TODO: add documentation to all values
struct Url {
  1: optional string   url,
  2: optional string   display_name,
  3: optional string   type,
  4: optional string   extended_type,
  5: optional constants.SharingLevel  sharing_level
}
// turn type into WeakEnum, support at least "premium_details" and "website", "profile_url" (XADListing), "tracking", "extra_info"
// extended_type: "save_to_outlook" / "hear_more_xml"

// QUESTION: What happens when PersonalPrimaryUrl is also the FacebookUrl?
// QUESTION: Do we need a short_display_name?

