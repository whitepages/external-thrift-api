# This file contains the search result datastructure used only in
# search service.

namespace java com.whitepages.wp.api.search
namespace rb WP.API.Search

include "wp-data/constants.thrift"
include "wp-data-serverexception/server_exception.thrift"
include "wrapped_person.thrift"
include "wrapped_location.thrift"
include "wrapped_phone.thrift"
include "wrapped_business.thrift"
include "suggestions.thrift"
include "search_exception.thrift"

enum ResultStatusE {
  Success,    # query was fully sucessful, may be zero results, may have suggestions
  Partial,    # one or more errors occured, but at least one result was returned
  Failure     # one or more errors occured and no results
}
typedef constants.WeakEnum ResultStatus

struct ResultEntry {
  1: required constants.EntityID	id,

  // This makes sense for a person or business, but not necessarily for a phone or location
  2: required double			score,

  3: required bool			is_exact_match,

  4: optional list<search_exception.SearchException> entity_exceptions,
}

typedef constants.uuid ResultID

struct ResultMeta {

  1: required ResultID                  result_id,

  3: required constants.Timestamp	time_of_query,

  5: required double                    query_duration_secs,

  7: optional i32                       exact_match_count,

  /** Number of root results matching search */
  9: required i32                       total_result_count,
}

/**
 * Search result needs to represent an arbitrarily deep object graph of related data-objects (entities)
 * it's composed of an ordered result vector of typed EntityIDs and a dictionary mapping id to datum for each principle entity type
 *
 */
struct Result {
  /* Overall status of the result */
  1: required ResultStatus                           result_status

  /**
   * results is a list of ordered lists of result entries
   * one list per query in same order as input queries,
   * each list is ordered by relevance based on query
   *
   * result entries are tuple of typed EntityIDs and relevancy scores
   */
  2: required list<ResultEntry>               	    results,

  // For now, we've decided on multiple maps with a UUID key, rather than
  // a single map where all types are included as values.

  /** dictionary of all people in result or materially referenced in result graph */
  3: required map<constants.PersonID, wrapped_person.WrappedPerson>     people,

  /** dictionary of all businesses in result or materially referenced in result graph */
  4: required map<constants.BusinessID, wrapped_business.WrappedBusiness> businesses,

  /** dictionary of all locations in result or materially referenced in result graph */
  5: required map<constants.LocationID, wrapped_location.WrappedLocation> locations,

  /** dictionary of all phones in result or materially referenced in result graph */
  6: required map<constants.PhoneID, wrapped_phone.WrappedPhone>       phones,

  /** exceptions global to the request */
  22: required list<search_exception.SearchException>                          global_exceptions,

  // inline until HOIST supported
  //40: required ResultMeta result_meta, //@HOIST
  40: required ResultID                  result_id,

  41: required constants.Timestamp	time_of_query,

  42: required double                    query_duration_secs,

  43: optional i32                       exact_match_count,

  /** Number of root results matching search */
  44: required i32                       total_result_count,

}
