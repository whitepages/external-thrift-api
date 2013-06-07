# This file contains the standard phone type definition.

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"
include "related_location.thrift"
include "referenced_legal_entity.thrift"

enum LineTypeE {
  Landline = 0,
  Mobile,
  Voicemail,
  TollFree, // Receiver pays, e.g. 1-800
  Premium, // Premium phone number, e.g. 976
  NonFixedVOIP,
  FixedVOIP,
  Other
}
typedef constants.WeakEnum LineType

typedef i16 SpamScore

struct PhoneReputation {
  1: optional SpamScore  spam_score,
}

/**
 * This class encapsulates the information about a phone number including
 * validity & relay information.
 */
struct Phone {
  /** Durable primary key */
  1: required constants.PhoneID       id,

  /* *
   * Type of the phone ( landline, mobile, etc )
   * Default: Landline
   */
  2:  optional LineType                line_type,


  /**
   * Additional LegalEntities that share this phone
   */
  4: optional referenced_legal_entity.ReferencedLegalEntities     belongs_to,

  /**
   * The addresses associated with this phone
   */
  5: optional related_location.RelatedLocations  associated_locations,


  /**
   * Complete Undecorated phone number without Extension or country code. Example "2065551212"
   */
  20:  required string                 phone_number,

  /* *
   * The properly formatted display phone number. Example "(206)555-1212"
   *
   * This is returned by the server because the logic for formatting
   * international numbers can be quite complicated. If we decide to support
   * this, we will support this as a server-side function to prevent clients
   * from having to know about local exchange information.
   */
  // TODO: consider removing this
  21:  optional string                 display_phone,

  /**
   * International dialing for the country. Example "1" for USA & Canada
   * Default: 1
   */
  22: required string                 country_calling_code,

  /**
   * The extensions (number only) for the phone number. Example "143"
   * Default: there is no extension
   */
  25:  optional string                 extension,

  /**
   * Indicates that the phone is a tracking phone number.
   * Default: FALSE
   */
  26: optional bool                   is_tracking,

  /**
   * Indicates that sending SMS's to the phone is permissible
   * STOP messages received for this number will set this false
   * Default: True
   */
  31: optional bool                   is_sms_allowed,

  /**
   * Indicates that the phone is capable of receiving SMS messages
   * Default: FALSE
   */ 
  // TODO: KILL ??
  32: optional bool                    is_sms_capable,

  /**
   * Telco Carrier
   */
  33: optional string                  carrier,

  /**
   * Do not call
   * Default: False
   */
  34: optional bool                    do_not_call,

  /**
   * Whether this phone was user generated
   */
  35: optional bool                    is_user_generated,

  40: optional PhoneReputation         reputation,
}

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
