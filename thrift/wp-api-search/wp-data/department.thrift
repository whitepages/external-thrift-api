# This file contains the standard company department definition.

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"

/**
 * This data structure will represent a department within a company. This
 * department can be location specific or global to a company. For example
 * "Engineering" at "IBM" is a global department, where as "Shoes" is a
 * location-specific department at Nordstroms.
 */
struct Department {
  1: optional constants.uuid company_id,
  2: optional constants.uuid department_id,
  3: optional string         name,
  4: optional i32            count,
  5: optional bool           location_department
}

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
