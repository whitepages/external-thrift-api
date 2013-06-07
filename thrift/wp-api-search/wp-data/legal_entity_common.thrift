# Common informative information about people or businesses

namespace java com.whitepages.wp.data
namespace rb WP.Data

include "constants.thrift"
include "media.thrift"
include "url.thrift"
include "email.thrift"
include "im.thrift"
include "social_link.thrift"
include "related_phone.thrift"
include "related_location.thrift"

struct LegalEntityCommon {
  /** Current and prior physical addresses for this entity */
  1:  optional related_location.RelatedLocations  locations,

  /** Current and prior phone numbers for this entity */
  2: optional related_phone.RelatedPhones         phones,

  //TODO should elements in this contact list be wrapped and labeled?
  /** List of email addresses for this listing */
  3:  optional list<email.Email>                  emails,

  //TODO should elements in this contact list be wrapped and labeled?
  /** List of IM addresses for this entity (currently not supported) */
  4:  optional list<im.Im>                        ims,

  /** List of media for this legal entity */
  5: optional list<media.Media>                   media,

  /** List of URLs for this legal entity */
  6: optional list<url.Url>                       urls,

  /** List of Social Network links for this legal entity */
  7: optional list<social_link.SocialLink>        social_links,
}

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
