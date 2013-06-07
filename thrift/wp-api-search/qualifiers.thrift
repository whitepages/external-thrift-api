# This file contains the search api query flags definition

namespace java com.whitepages.wp.api.search
namespace rb WP.API.Search

include "wp-data/constants.thrift"


enum CNAMUsageE {
  None = 0,
  Standard,
  Extended,
}

typedef constants.WeakEnum CNAMUsage

struct PhoneReputationControl {
  1: optional bool show_spam_score,
  2: optional i16  max_comments = 0,  // default 0 means no comments
}

/**
 * Flags to control query behavior
 * all default to false unless otherwise specified
 */

struct CommonQualifiers {
  /** populate historical data in addition to current data in result objects (if allowed) */
  1:  optional bool show_historical,

  /** show sensitive (inferred) information (if allowed) */
  2:  optional bool show_sensitive,

  /** show UGC data in result (if allowed) */
  3:  optional bool show_ugc,

  /** show suppressed data in result (if allowed) */
  4:  optional bool show_suppressed,

  /** show private UGC data in result (if allowed) */
  5:  optional bool show_ugc_private,

  /** show containing locations on location objects, this is slow */
  6:  optional bool show_containing_locations,
}

struct RetrieveQualifiers {
  // inline until HOIST supported
  //1: required CommonQualifiers      base,  //@HOIST
  /** populate historical data in addition to current data in result objects */
  1:  optional bool show_historical,

  /** show sensitive (inferred) information (if allowed) */
  2:  optional bool show_sensitive,

  /** show UGC data in result (if allowed) */
  3:  optional bool show_ugc,

  /** show suppressed data in result (if allowed) */
  4:  optional bool show_suppressed,

  /** show private UGC data in result (if allowed) */
  5:  optional bool show_ugc_private,

  /** show containing locations on location objects, this is slow */
  6:  optional bool show_containing_locations,
}

struct FindQualifiers {
  // inline until HOIST supported
  //1: required CommonQualifiers      base,  //@HOIST
  /** populate historical data in addition to current data in result objects */
  1:  optional bool show_historical,

  /** show sensitive (inferred) information (if allowed) */
  2:  optional bool show_sensitive,

  /** show UGC data in result (if allowed) */
  3:  optional bool show_ugc,

  /** show suppressed data in result (if allowed) */
  4:  optional bool show_suppressed,

  /** show private UGC data in result (if allowed) */
  5:  optional bool show_ugc_private,

  /** show containing locations on location objects, this is slow */
  6:  optional bool show_containing_locations,

  /** Confine search to larger geographic area, defaults to true */
  10:  optional bool expand_search_area, // was expand_to_metro_area

  /* DEPRECATED for show_extended_telco */
  //  optional bool show_phone_meta,

  /** Show DNC information */
  11:  optional bool show_do_not_call,

  /** Show address meta information (USPS deliverability and kind) */
  12:  optional bool show_address_meta,

  /* deprecated, always on -- Show match field information in response, defaults to true */
  // optional bool show_match_fields,

  /** Blocks expensive queries when the requestor is determined to be a spider */
  13:  optional bool is_spider,

  /** enum value on what cnam services to use (if any) */
  14:  optional CNAMUsage use_cnam,

  /** include hitcounter, which populates spam score information */
  15:  optional PhoneReputationControl phone_reputation_ctl,

  /** include information from standard (cheap) external data provider */
  16:  optional bool use_standard_external_lookups,

  /** include information from premium (expensive/slow) external data provider */
  17:  optional bool use_premium_external_lookups,

  /* deprected -- always on */
  // optional bool use_name_classification,

  /** include more phone information from external provider */
  18:  optional bool show_extended_telco,

  /** include premium urls in bsrpc responses */
  40:  optional bool show_premium_urls,

  /** use tracking phones in result response */
  41:  optional bool use_tracking_phones,

  /** include yext location information */
  42:  optional bool show_yext_tags,

  /** use google version of PayForClick ad if one is available */
  43:  optional bool use_google_pfc,

  /** whether to display PayForClick ads that are in a preview state  */
  44:  optional bool show_pfc_preview,

  /** include user reviews in a bsrpc response */
  45:  optional bool show_reviews,

  /* move to context * indicates if the current search is a mobile request -- effects bsrpc impression tracking */
  //  optional bool is_mobile,

  /** use mobile version of PerForClick ad if one is available */
  46:  optional bool use_mobile_pfc,

  /** show nearby (unrelated) businesses */
  47:  optional bool show_nearby_businesses,

  /** turns xad overlay on, used in mobile */
  48:  optional bool show_xad_overlays,

  /** only return businesses belonging to a business chain */
  49:  optional bool only_show_chains,

  /** automatically lock search to single chain if certain
    * threshold is hit */
  50:  optional bool use_chain_autodrilldown,

  /** limit search to only return one business per chain, even if multiple are found */
  51:  optional bool limit_chain_results,

  /** use VRS data in the response */
  52:  optional bool show_phone_billing_location,

}



# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
