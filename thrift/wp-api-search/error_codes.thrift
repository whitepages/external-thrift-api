# This file contains the search service error codes

namespace java com.whitepages.wp.api.search
namespace rb WP.API.Search

/**
 * There are a different set of error codes for each
 * value of WP::Data::ExceptionTypeE.
 */


/* Error codes for ExceptionTypeE == Other */
/* none defined yet */

/* Error codes for ExceptionTypeE == TransientError */
/* none defined yet */

/* Error codes for ExceptionTypeE == UpstreamError */
enum UpstreamErrorsE {
  Unknown,

  # DAS2 errors
  DAS2NoResultField = 100,
  DAS2UnexpectedResultValue,

  # Dirsvc
  DIRSVCEntityNotFound = 200,
}

/* Error codes for ExceptionTypeE == InputError */
enum InputErrorsE {
  Unknown,
  InvalidQuery,

  # errors from people search (result type includes business)
  ParsedBusinessNotSupportedForPersonSearch = 100,

  # errors from business search (result type includes business)
  RawLocationNotSupportedForBusinessSearch = 200,
  ParsedNameNotSupportedForBusinessSearch,
  PersonIdsNotSupportedForBusinessSearch,

  # errors for multiple search types
  LatitudeAndLongitudeRequired = 300,
  PageFirstMustBeMultipleOfPageLen,

  # other errors
  InvalidEagerLoadType = 1000
}

/* Error codes for ExceptionTypeE == InputFieldError */
enum InputFieldErrorsE {
  Unknown,
  Missing,
  Invalid,
  TooShort,
}

/* Error codes for ExceptionTypeE == PermissionError */
enum PermissionErrorsE {
  Unknown,
  InvalidAppId,
  MissingAppId,
  MissingAppUserId,
  RequestedPermissionExceededAllowMaximum
}
