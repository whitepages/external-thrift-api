# This file contains the search service context definition.

namespace java com.whitepages.wp.api.search
namespace rb WP.API.Search

include "wp-data/constants.thrift"

struct Context {

  /** unique identifier for consuming application */
  1:  required string app_id,

  /** some app_id's require the presentation of a credential */
  2:  optional string app_credential,

  /** app may be acting for a user */
  3:  optional string app_user_id,

  /** app's user user may have a credential */
  4:  optional string app_user_credential,

  /** client locale (default: EN_us) */
  12: optional string locale,

}

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
