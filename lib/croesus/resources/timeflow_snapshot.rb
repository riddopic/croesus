
# Delphix Source API template

Croesus::DSL.evaluate do
  resource :timeflow do
    description  'Timeflow snapshots represent a point in time within a '       \
                 'Timeflow that is used as the base point for provisioning. A ' \
                 'provisioning operation begins at a timeflow snapshot and '    \
                 'performs additional operations to bring the database to the ' \
                 'requested state. Snapshots themselves may or may not be '     \
                 'provisionable, and can be associated with dSources or VDBs.'
    root         '/resources/json/delphix/snapshot'

    get '/resources/json/delphix/snapshot' do
      description 'Returns a list of snapshots on the system or within a '      \
                  'particular object. By default, all snapshots within the '    \
                  'domain are listed.'
      returns     Array
      name        :list
    end

    get '/resources/json/delphix/snapshot/{ref}' do
      description 'Retrieve the specified TimeflowSnapshot object.'
      returns     Array
      name        :read
    end

    post '/resources/json/delphix/snapshot/{ref}' do
      description 'Update the specified TimeflowSnapshot object.'
      name        :update
    end

    delete '/resources/json/delphix/snapshot/{ref}' do
      description 'Delete the specified TimeflowSnapshot object.'
      name        :delete
    end
  end
end
