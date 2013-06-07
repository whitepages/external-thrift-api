# Name input spec

namespace java com.whitepages.wp.api.search
namespace rb WP.API.Search

include "wp-data/constants.thrift"

/** fielded representation of name component */
struct ParsedName {
  1: optional string         first_name,

  /** Could be name or initial */
  2: optional string         middle_name,

  3: optional string         last_name,

  /** Could restrict search to Jrs. */
  4: optional string         suffix,

  /** Mr, Dr, etc. */
  5: optional string         title,
}

struct ParsedBusiness {
  1: optional string         name,

  3: optional string         category,
}

/** union of supported name query input representations */
union NameSpec {
  /** Unparsed name field */
  1: string                        raw,

  /** Fielded name */
  3: ParsedName                    parsed_name,

  5: ParsedBusiness                parsed_business,

  7: list<constants.PersonID>      ids,
}

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
