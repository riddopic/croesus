SOURCE
# ==============================================================================
#
# Sources represent external database instances outside the Delphix system.
# These can be linked sources (which pull data into Delphix from pre-existing
# databases) or virtual sources, which export data from Delphix to arbitrary
# targets.
#
# Sources are attached to Container (database) objects, which hold the actual
# data for the source. Every source has a SourceConfig object associated with
# it, though not all source configs have associated sources. The source config
# tracks information that is intrinsic to the external database, independent of
# whether it is incorporated into the Delphix system is any way. Both linked
# and virtual sources share the same config for a particular database type
# (though it may differ, for example, between Oracle single instance and RAC).
# Source configs without a source exist for externally-controlled
# (link-capable) databases, while source configs for virtual sources are
# created as needed and managed by Delphix. The hierarchy of objects is:
#
# * Source
# * SourceConfig
# * SourceRepository
# * SourceEnvironment
#
# Sources can have SourceRuntime properties that are not stored with the
# persistent representation of the object, but pulled on demand from the
# running database instance. These runtime properties therefore may not always
# be available, and cannot be manipulated via Delphix.
#
#    TypedObject
#        |__PersistentObject
#             |__UserObject
#                  |__Source
#                       |              -----\
#                       |__PgSQLSource       \
#                       |__OracleSource       \ ______ [ Known Subclasses ]
#                       |__MSSqlSource        /
#                       |__AppDataSource     /
#                                      -----/
#
#
module Croesus::API
  # P R O P E R T I E S
  #
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # config            | Reference to the configuration for the source.
  #                   | Type: Reference to SourceConfig.
  #                   | Constraints:
  #                   | Create: optional
  #
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # container         | Reference to the container being fed by this source,
  #                   | if any.
  #                   | Type: Reference to Container
  #
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # description       | A user-provided description of the source.
  #                   | Type: string
  #
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # enabled           | Flag indicating whether the source is enabled.
  #                   | Type: boolean
  #
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # runtime           | Runtime properties of this source.
  #                   | Type: SourceRuntime
  #
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # staging           | Flag indicating whether the source is used as a staging
  #                   | source for pre-provisioning. Staging sources are
  #                   | managed by the Delphix system.
  #                   | Type: boolean
  #
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # status            | Status of this source.
  #                   | Type: boolean
  #                   | Constraints:
  #                   | Acceptable values: DEFAULT, PENDING_UPGRADE
  #
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # virtual           | Flag indicating whether the source is managed by the
  #                   | Delphix system.
  #                   | Type: boolean
  #
  #
  # I N H E R I T E D   P R O P E R T I E S
  #
  # Object Type: UserObject
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # name              | Object name
  #                   | Type: objectName
  #                   | Constraints:
  #                   | Max Length: 256
  #                   | Create: optional
  #                   | Update: optional
  #
  # Object Type: PersistentObject
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # namespace         | Alternate namespace for this object, for replicated and
  #                   | restored objects.
  #                   | Type: Reference to Namespace
  #
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # reference         | Object reference.
  #                   | Type: Reference to PersistentObject
  #
  # Object Type: TypedObject
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # type              | Object type.
  #                   | Type: type
  #                   | Constraints:
  #                   | Required: true
  #
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  #
  class Source
    # S T A N D A R D   O P E R A T I O N S
    #
    # List
    # @note GET /resources/json/delphix/source
    # Lists sources on the system, optionally list only.
    #
    # @param [String] source
    # @option source database    List sources associated with the given
    #                            container reference.
    #                            Type: Reference to Container.
    # @option source environment List sources associated with the given source
    #                            environment reference.
    #                            Type: Reference to SourceEnvironment.
    # @option source repository  List sources associated with the given source
    #                            repository reference.
    #                            Type: Reference to SourceEnvironment
    #
    # @return [Array(Source)] Array of Type: Source
    #
    # @api public
    def self.list(source = nil)
      Croesus.get(filter_url(source))
    end
  end
end





