
# Delphix Source API template

Croesus::DSL.evaluate do
  resource :timeflow do
    description  'Timeflows represent a single provisionable timeline within a '\
                 'Database. The Delphix system currently only supports one '    \
                 'timeflow per database, though this may expand in the future. '\
                 'Each database has the notion of the `current` timeflow, '     \
                 'either the timeflow being synced from an external source '    \
                 '(for dSources) or the actively provisioned timeflow (for '    \
                 'VDBs). With only one timeflow supported per database, the '   \
                 'current timeflow is always the one and only timeflow for '    \
                 'the database.'
    root         '/resources/json/delphix/timeflow'

    get '/resources/json/delphix/timeflow' do
      description 'List Timeflow objects on the system.'
      returns     Array
      name        :list
    end

    get '/resources/json/delphix/timeflow/{ref}' do
      description 'Retrieve the specified Timeflow object.'
      returns     Array
      name        :read
    end

    post '/resources/json/delphix/timeflow/{ref}/repair' do
      description 'Manually fetch log files to repair a portion of a timeflow.'
      name        :repair
    end

    post '/resources/json/delphix/timeflow/{ref}/timeflowRanges' do
      description 'Fetches timeflow ranges in between the specified start and ' \
                  'end locations.'
      name        :timeflowRanges
    end
  end
end
