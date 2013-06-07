# This file contains the standard email type definition.

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"

/** This data structure describes email contacts */
struct Email {

  /**
   * Unique GUID for this email
   *
   * optional for now as email is not yet first class entity
   */
  1: optional constants.uuid          id,
  
  /** Full normalized email address */
  2: required string                  email_address,

  /** Type of the contact ( residential, professional, business ) */
  3: optional constants.ContactType   contact_type,

  //TODO core?
  /** Indicates that the email should not be used for display. */
  4: optional bool                    is_relay_only,

  //TODO core?
  /** Permitted Sharing Level (Public, Limited, Private) */
  5: optional constants.SharingLevel  sharing_level,

  /* *
   * The address associated with this email
   * TODO: are emails bound to locations? use case?
   */
  // 5: optional constants.EntityId    location_id,

  // TODO core?
  /** Status of the contact ( current, inaccurate, etc ) */
  6: optional constants.RecordStatus record_status,

  //TODO relationship?
  /** time period this email is valid for */
  7: optional constants.Period        valid_period,

  /** Arbitrary textual label for the type of the contact */
  9: optional string                  label,

  /* *
   * Boolean flag indicating this is the owner's preferred contact of its type
   *
   * TODO: property of relationship, move this into a wrapper struct binding email to legal entity
   * 10: optional bool                   user_preferred,
   */

  //TODO core?
  /* * status of the email - mostly is it merged? */
  // 12: optional constants.ContactStatus  status,
}

# Copyright (c) 2012 by Whitepages, Inc. All Rights Reserved.
