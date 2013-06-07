# This file contains facet definitions

namespace java com.whitepages.wp.api.search
namespace rb WP.API.Search

include "wp-data/constants.thrift"
include "wp-data/person.thrift"
include "wp-data/company.thrift"
include "wp-data/department.thrift"
include "wp-data/job_title.thrift"
include "wp-data/location.thrift"

enum SuggestionCharacterE {
  Facet,         # refines (filters) current search results
  Alternative,   # provides alternatives to current input
  Expansion,     # not used at present
}
typedef constants.WeakEnum SuggestionCharacter

enum SuggestionTypeE {
  Location = 0,
  JobTitle,
  Department,
  Company,
  BusinessChain,
  BusinessCategory,
  City,
  State,
  PostalCode,
  Neighborhood,
  MetroArea,
  County,
  Country,
  AgeRange,
}
typedef constants.WeakEnum SuggestionType

/**
 * XxxxSuggestion structures are generally of the form id, name which supply an id
 * which can be supplied to requery on the facet, and name is the simple display
 * name for the facet

** Represents location facet info. */
struct LocationSuggestion {
  1: optional constants.EntityID    id,   /** a location_id */
  2: optional string                name,
  3: optional location.LocationType type
}

/** Represents a unique business chain name and identifier. */
struct BusinessChainSuggestion {
  1: optional constants.uuid id,
  2: optional string         name,
}

/** business category facet information */
struct BusinessCategorySuggestion {
  1: optional constants.uuid id,
  2: optional string         name,
}

struct Suggestion {
  1: optional i32                         count,

 /**
  * Exactly one of the following should be set,
  * based on the SuggestionType of this suggestion
  */
  10: optional LocationSuggestion         location,
  11: optional job_title.JobTitle         job_title,
  12: optional department.Department      department,
  13: optional company.Company            company,
  14: optional BusinessChainSuggestion    business_chain,
  15: optional BusinessCategorySuggestion business_category,
  //TODO flesh more suggestion targets
}

struct SuggestionClass {
  1: required SuggestionType      type,
  2: required SuggestionCharacter character,
}

typedef list<Suggestion> SuggestionSet

typedef map<SuggestionClass,SuggestionSet> Suggestions

# Copyright (c) 2013 by Whitepages, Inc. All Rights Reserved.
