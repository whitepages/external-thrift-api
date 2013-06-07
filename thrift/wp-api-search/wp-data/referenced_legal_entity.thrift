# This file contains the standard Referenced LegalEntity definitions.
#

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"

/** reference to Referenced LegalEntity with meta data about relationship */
struct ReferencedLegalEntity {
  1: required constants.EntityID      legal_entity_id,
  /** time period the relationship was valid */
  2: optional constants.Period        valid_for,
}

typedef list<ReferencedLegalEntity> ReferencedLegalEntities

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
