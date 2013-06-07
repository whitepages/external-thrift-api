# This file contains the standard server-side exception definition.

namespace java com.whitepages.wp.data
namespace rb WP.API.Search

include "wp-data/constants.thrift"
include "wp-data-serverexception/server_exception.thrift"

enum ExceptionTypeE {
     Other = 0,         # other error type not covered below
     Exception,         # program code exception
     TransientError,    # (probably) transient error such as timeout
     UpstreamError,     # some error returned from an upstream service
     InputError,        # error in query input, not related to a single field
     InputFieldError,   # input field required or invalid (field will be set)
     PermissionError,   # permissions not allowed
}
typedef constants.WeakEnum ExceptionType

/**
 * This data structure contains information about server exceptions or errors
 * which can be returned by WP::API::Search methods
 */
exception SearchException {
  /**
   * Type of exception
   */
  1: required ExceptionType type,

  /** Fields set when type == Exception (only) */

  // inline until HOIST supported
  //11: required server_exception.ServerException  exception,  //@HOIST

  /*
   * Name of the class that generated the exception
   * Required if type == Exception, otherwise never set
   */
  11: optional string classname,

  12: required string message,

  /*
   * Stack trace of the exception
   * Required if type == Exception, otherwise never set
   */
  13: optional list<string> backtrace,

  /*
   * Previous exception
   * optional if type == Exception, otherwise never set
   */
  14: optional list<server_exception.CausedBy> caused_by

  /* Fields that can be set when type != Exception */

  /**
   * Error code. Codes are defined in error_codes.thrift.
   *
   * Required for type != Exception, otherwise unset
   */
  20: optional i32            code,

  /**
   * If type == InputFieldError, then this field contains
   * the name of the input field that generated the error
   *
   * Required if code == InputFieldError, otherwise unset
   */
  30: optional string field,
}

# Copyright (c) 2012 by Whitepages, Inc. All Rights Reserved.
