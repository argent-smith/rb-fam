require 'ffi'

module Fam

  ##
  # The low-level FAM operations
  #
  # @private
  module Native
    extend FFI::Library
    ffi_lib 'libfam.so'

    ##
    # Communication structures

    # struct FAMConnection {
    #     int fd;
    #     void *client;
    # };

    # A C struct describing a FAM connection
    #
    # @private
    class Connection < FFI::Struct
      layout(
        :fd,      :int,
        :client,  :pointer
      )
    end

    # struct FAMRequest {
    #     int reqnum;
    # };

    # A C struct describing a FAM request
    #
    # @private
    class Request < FFI::Struct
      layout(
        :regnum, :int
      )
    end

    # typedef enum FAMCodes {
    #     FAMChanged=1,
    #     FAMDeleted=2,
    #     FAMStartExecuting=3,
    #     FAMStopExecuting=4,
    #     FAMCreated=5,
    #     FAMMoved=6,
    #     FAMAcknowledge=7,
    #     FAMExists=8,
    #     FAMEndExist=9
    # } FAMCodes;

    # Constants in Codes indicate what kind of event happened that raised the
    # callback at the application level

    Codes = enum(
      :changed, 1,
      :deleted,
      :start_executing,
      :stop_executing,
      :created,
      :moved,
      :acknowledge,
      :exists,
      :end_exist
    )

    # typedef struct  FAMEvent {
    #     FAMConnection* fc;         /* The fam connection that event occurred on */
    #     FAMRequest fr;             /* Corresponds to the FamRequest from monitor */
    #     char *hostname;            /* host and filename - pointer to which */
    #     char filename[PATH_MAX];   /* file changed */
    #     void *userdata;            /* userdata associated with this monitor req. */
    #     FAMCodes code;             /* What happened to file - see above */
    # } FAMEvent;

    # FAM event descriptor


    class Event < FFI::Struct
      layout(
        :fc,        :pointer,
        :fr,        :pointer,
        :hostname,  :string,
        :filename,  :string,
        :userdata,  :pointer,
        :code,      Codes
      )
    end

  end
end
