# This file contains the standard work (employment) definition.

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"
include "company.thrift"
include "department.thrift"
include "job_title.thrift"

/**
 * This class represents information about employment related to a person's work listing.
 */
struct WorkInfo {
  /** persistent unique identifier for this work record */
  1: optional constants.uuid         work_id,

  /** Company Name if known */
  2: optional company.Company        employer,

  /** Department  if known */
  3: optional department.Department  department,

  /** Job Title if known */
  4: optional job_title.JobTitle     job_title,

  /** The address associated with this work info */
  6: optional constants.EntityID     location_id,

  /** Valid period */
  7: optional constants.Period        valid_for,

  //TODO core?
  /** Status of the contact ( current, inaccurate, etc ) */
  8: optional constants.RecordStatus record_status,

  //TODO core?
  9: optional constants.SharingLevel  sharing_level
}

# Copyright (c) 2012 by Whitepages, Inc. All Rights Reserved.
