# This file contains the standard server-side exception definition.

namespace java com.whitepages.wp.data
namespace rb WP.Data

struct CausedBy {
  1: optional string classname,
  2: optional string message,
  3: optional list<string> backtrace,
}

/** This data structure contains information about a generic server error. */
exception ServerException {
  1: optional string classname,
  2: optional string message,
  3: optional list<string> backtrace,
  4: optional list<CausedBy> caused_by
}

# Copyright (c) 2012 by Whitepages, Inc. All Rights Reserved.
