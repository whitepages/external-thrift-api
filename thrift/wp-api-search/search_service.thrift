# This file contains the search service interface definition.

namespace java com.whitepages.wp.api.search
namespace rb WP.API

include "wp-data/constants.thrift"
include "wp-data-serverexception/server_exception.thrift"

include "result.thrift"
include "context.thrift"
include "query.thrift"
include "qualifiers.thrift"
include "selection.thrift"
include "filter.thrift"
include "error_codes.thrift"

service Search {

  /**
    * Given a list of EntityID's, retrieve one or more entities.
    * The results vector will be in same order as EntityID list.
    */
  result.Result retrieve(
    1: list<constants.EntityID>       ids,
    4: context.Context                context
  ) throws (1: server_exception.ServerException e),

  /**
   * Given a Query, return one or more Entities.  Note that the Query object must specify desired EntityType -- One of Person, Phone, Location or Busines.
   * Results ordering will be based on search scoring and ranking.
   */
  result.Result find(
    1: query.Query                query,
    5: context.Context            context
  ) throws (1: server_exception.ServerException e),


}

# Copyright (c) 2012 by Whitepages, Inc. All Rights Reserved.
