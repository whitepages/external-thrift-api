# This file contains the query selection controls

namespace java com.whitepages.wp.api.search
namespace rb WP.API.Search

include "wp-data/constants.thrift"

enum EagerLoadTypeE {
   Flat = 0,                    # follow all links to depth given by eager_load_depth
   PersonSerpWithMembersAt      # follow person->phones; person->locations->person only
}
typedef constants.WeakEnum EagerLoadType

enum SortOrderE {
  Descending = 0,
  Ascending
}
typedef constants.WeakEnum SortOrder

enum SortByE {
  Relevance = 0,
  Distance,
  Name
}
typedef constants.WeakEnum SortBy

/** selection controls for pagination and result set limiting */
struct CommonSelection {
  /**
   * number of reference indirections starting from result entities to
   * materialize in result dictionaries. Used only if eager_load_type
   * is unset or set to Flat.
   */
  1:  optional i32 eager_load_depth,	// @@@ Consider CoreSite FindPerson

 /**
  * Define an eager load shape. If unset, defaults to Flat which
  * uses eager_load_depth.
  */
  2:  optional EagerLoadType eager_load_type,
}


/** selection controls for pagination and result set limiting */
struct RetrieveSelection {
  # inline until HOISTING supported
  # 10: required CommonSelection       base,  //@HOIST
  /**
   * number of reference indirections starting from result entities to
   * materialize in result dictionaries. Used only if eager_load_type
   * is unset or set to Flat.
   */
  1:  optional i32 eager_load_depth,	// @@@ Consider CoreSite FindPerson

 /**
  * Define an eager load shape. If unset, defaults to Flat which
  * uses eager_load_depth.
  */
  2:  optional EagerLoadTypeE eager_load_type,
}

/** selection controls for pagination and result set limiting */
struct FindSelection {
  /** 0-base index of first result from result set for desired page */
  1:  optional i32 page_first,

  /** number results to fill desired page */
  2:  optional i32 page_len,

  /** maximum number of results to retrieve (default 100) */
  3:  optional i32 max_results,

  /* deprecated for field in qualifiers.phone_reputation_ctl */
  //  optional i32 hc_comment_limit,

  4:  optional SortOrder sort_order,

  5:  optional SortBy sort_by,

  # inline until HOISTING supported
  # 10: required CommonSelection       base,  //@HOIST
  /**
   * number of reference indirections starting from result entities to
   * materialize in result dictionaries. Used only if eager_load_type
   * is unset or set to Flat.
   */
  10:  optional i32 eager_load_depth,	// @@@ Consider CoreSite FindPerson

 /**
  * Define an eager load shape. If unset, defaults to Flat which
  * uses eager_load_depth.
  */
  11:  optional EagerLoadType eager_load_type,
}

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
