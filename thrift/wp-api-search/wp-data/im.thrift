# This file contains the standard instant messaging contact definition.

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"

//TODO flesh this out
enum IMProvider {
  Custom,
  AIM,
  MSN,
  Yahoo,
  Google,
  Skype,
  FreenodeIRC,
}

enum IMProtocol {
  Unknown,
  AIM,
  XMPP,
  IRC,
  Skype,
  MSN,
}

/**
 * This data structure describes an Instant Messaging contact
 */
struct Im {
  1:  required string      handle,
  2:  optional IMProvider  im_provider,
  3:  optional IMProtocol  im_protocol,
  4:  optional string      service_address,

  //TODO relationship?
  /** time period this email is valid for */
  5: optional constants.Period        valid_period,

}

# Copyright (c) 2012 by Whitepages, Inc. All Rights Reserved.
