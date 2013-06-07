# This file contains the standard job_title definition.

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"

/**
 * This data structure generalizes the job title, allowing us to facet and
 * filter on title.
 */
struct JobTitle {
  1: optional constants.uuid id,
  2: optional string         name,
  3: optional i32            count
}

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
