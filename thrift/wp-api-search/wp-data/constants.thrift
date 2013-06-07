# This file contains constants, enums and common type definitions used across
# the standard data objects


namespace java com.whitepages.wp.data
namespace rb WP.Data

typedef i16 WeakEnum

/** AgeRange is supplied when exact brith_date is masked for privacy */
enum AgeRange {
  Minor     = 0,
  Age18to24 = 18,
  Age25to29 = 25,
  Age30to34 = 30,
  Age35to39 = 35,
  Age40to44 = 40,
  Age45to49 = 45,
  Age50to54 = 50,
  Age55to59 = 55,
  Age60to64 = 60,
  Age65up   = 65,
}

/** person gender */
enum Gender {
  Female = 1,
  Male,
  Unknown,
}

enum ContactTypeE {
  Other = 1,
  Work,
  Home,
  Business,
}
typedef WeakEnum ContactType

//TODO: Some of these are values are of interest only internally, consider factoring them into a parrallel
enum RecordStatusE {
  Current = 1,
  Historical,
  Deceased,       # Should only be present on listing-wide contact status
  Inaccurate,
  Merged,         # Should only be present on listing-wide contact status
  Suppressed,
}
typedef WeakEnum RecordStatus

enum SharingLevelE {
  Private = 1,     # Hide entity
  Shared,          # Hide the zip4 and street-level address on location entities
  Public,          # Show entity
}
typedef WeakEnum SharingLevel

/** standard latitude, longitude tuple */
struct LatLong {
  1: required double latitude,
  2: required double longitude
}

/** units of distance */
enum DistanceUnit {
  Miles,
  Kilometers,
}

/** Distance measure */
struct Distance {
  1: required double       value,
  /** units of value, default: Miles */
  2: optional DistanceUnit unit,
}

/** Date structure allowing varied precision: could be year, year-month,
 * or year-month-dayofmonth
 */
struct Date {
  1: optional i32 year,
  2: optional i32 month,
  3: optional i32 day
}

/** Represents a Time Zone and all of its important properties */
struct Timezone {
  /** GMT Offset in minutes, Examples -800, +530 */
  1: required i32                      gmt_offset,

  /* Indicates if Time Zone observes Daylight Savings Time */
  2: required bool                     observes_dst,

  /* Standard name of Time Zone, Example 'PDT' or 'GMT' */
  3: optional string                   name,
}

// could we just do this instead?
//typedef string Timezone  // ISO-8601 http://en.wikipedia.org/wiki/ISO_8601#Time_zone_designators

typedef i64 Timestamp    // TODO: define units and origin

struct TimestampWithZone {
  1: required Timestamp time,
  2: required Timezone  zone,
}

/**
 * Closed date-time interval [start..stop]
 * (NOTE begin,end are thrift keywords, so we use start,stop)
 */
struct Period {
  /* begining of time period range, inclusive */
  1: optional Date start,
  /* end of time period range, inclusive */
  2: optional Date stop,
}

/** Valid WP data object types
 *   may be bit-masked when specifying acceptable/desired types on query
 */
enum EntityTypeE {
  // assign values as bit mask positions
  Person   = 0x01,
  Business = 0x02,
  Location = 0x04,
  Phone    = 0x08,
}

/**
 * on output, this will have one bit set corresponding to values
 * from EntityTypeE
 */
typedef WeakEnum EntityType

/**
 * used to request desired Entity Types may have multiple bits set
 * from EntityTypeE
 */
typedef EntityType RequestedEntityTypes

/** uuid is a string of 32 hex digits representing a 128-bit UUID
 * acceptable representations my include dashes seperating five groups in the form 8-4-4-4-12
 * see http://en.wikipedia.org/wiki/Universally_unique_identifier#Definition
 */
typedef string uuid

enum DurabilityTypeE {
  Durable,           // is durable
  Ephemeral,         // consistant only within a single result set
  Temporary,         // Re-retrievalble for some limited TTL
}
typedef WeakEnum DurabilityType

/** All WP data objects are uniquely identified by this typed entity id triple
 * By default EntityIDs are expected to be durable IDs a client may store and re-retrieve
 * Some objects are acquired through third parties that don't offer first class mappings,
 * in which case weaker gaurantees are made about the re-retrievability of the entity
 */
struct EntityID {
  /*
   * type should contain values from EntityTypeE
   */
  1: required EntityType    type,
  2: required uuid          uuid,
  3: optional DurabilityType durability
}

typedef EntityID PersonID
typedef EntityID BusinessID
typedef EntityID LegalEntityID
typedef EntityID LocationID
typedef EntityID PhoneID
