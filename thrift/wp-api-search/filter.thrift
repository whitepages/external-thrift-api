# This file contains the search query filter object definition.

namespace java com.whitepages.wp.api.search
namespace rb WP.API.Search

include "wp-data/constants.thrift"

struct FindFilter {
  //1:  list<search_constants.SearchType> type_filter,
  2:  list<constants.uuid> category_filter,
  //3:  list<constants.uuid> location_filter,
  4:  list<constants.uuid> neighborhood_filter,
  5:  list<constants.uuid> chain_filter,
  //6:  list<constants.uuid> company_filter,
  //7:  list<constants.uuid> department_filter,
  //8:  list<constants.uuid> job_title_filter,
  //9:  list<constants.AgeRange> age_range_filter,
  //10: list<constants.Gender> gender_filter,
  //11: list<constants.uuid> provider_filter
}

# TODO: should we unify all IDs on uuid?
# TODO: do we need a provider filter?
#  11: list<constants.Provider> provider_filter,


# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
