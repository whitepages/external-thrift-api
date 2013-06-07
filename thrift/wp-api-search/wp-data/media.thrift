# This file contains the standard photo definition.

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"
include "url.thrift"

enum MediaTypeE {
  Image,
  Video,
  Audio,
  LogoImage
}
typedef constants.WeakEnum MediaType

/** This class represents a photo associated with a listing. */
struct Media {
  /** Url for accessing the photo */
  1: required url.Url full,
  2: optional url.Url compressed,
  3: optional string label,
  4: required MediaType type,

  //TODO core?
  /** Status of the contact ( current, inaccurate, etc ) */
  10: optional constants.RecordStatus record_status,

  //TODO core?
  /** Permitted Sharing Level (Public, Limited, Private) */
  11: optional constants.SharingLevel  sharing_level,
}
# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
