
# Delphix Source API template

Croesus::DSL.evaluate do
  resource :source do
    description  'Sources represent external database instances outside the ' \
                 'Delphix system. These can be linked sources (which pull '   \
                 'data into Delphix from pre-existing databases) or virtual ' \
                 'sources which export data from Delphix to arbitrary targets.'
    root         '/resources/json/delphix/source'

    get '/resources/json/delphix/source' do
      description 'Lists sources on the system.'
      returns     Array
      name        :list
    end

    get '/resources/json/delphix/source/{ref}' do
      description 'Retrieve the specified Source object.'
      returns     Array
      name        :read
    end

    post '/resources/json/delphix/source/{ref}' do
      description 'Update the specified Source object.'
      input       Hash
      name        :update
    end

    post '/resources/json/delphix/source/{ref}/disable' do
      description 'Disables the given source such that Delphix no longer '     \
                  'interacts with the source. A disabled source has no data '  \
                  'available on the target host, and therefore cannot be '     \
                  'running. No monitoring is done for disabled sources.'
      input       String
      name        :disable
    end

    post '/resources/json/delphix/source/{ref}/enable' do
      description 'Enables the given source, exporting any necessary data and '\
                  'starting the source. Once enabled, the source will be '     \
                  'monitored by Delphix regardless of whether it is currently '\
                  'running, and the server will respond to changes in its '    \
                  'status appropriately.'
      input       Hash
      name        :enable
    end

    post '/resources/json/delphix/source/{ref}/start' do
      description 'Starts the given source. Only virtual sources can be '      \
                  'started and stopped. A stopped source is equivalent to '    \
                  'stopping the source through application-specific means, '   \
                  'and a source can be started or stopped both through this '  \
                  'interface as well as via the external application. A '      \
                  'stopped source is still monitored for availability and '    \
                  'policies can still run against a stopped source, if '       \
                  'applicable. Linked sources cannot be stopped, only virtual '\
                  'sources managed by the server can be started via this '     \
                  'mechanism.'
      input       String
      name        :start
    end

    post '/resources/json/delphix/source/{ref}/stop' do
      description 'Stops the given source. Only virtual sources can be '       \
                  'started and stopped. A stopped source is equivalent to '    \
                  'stopping the source through application-specific means, '   \
                  'and a source can be started or stopped both through this '  \
                  'interface as well as via the external application. A '      \
                  'stopped source is still monitored for availability and '    \
                  'policies can still run against a stopped source, if '       \
                  'applicable. Linked sources cannot be stopped, only virtual '\
                  'sources managed by the server can be stopped via this '     \
                  'mechanism.'
      input       String
      name        :stop
    end

    post '/resources/json/delphix/source/{ref}/upgrade' do
      description 'Upgrades the given source. This upgrade operation changes ' \
                  'the repository of the source to a higher version repository.'
      input       String
      name        :upgrade
    end
  end
end
