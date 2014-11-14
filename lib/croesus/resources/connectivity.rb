
# Delphix Source API template

Croesus::DSL.evaluate do
  resource :connectivity do
    description  'Tools to test connectivity of external resources.'
    root         '/resources/json/delphix/connectivity'

    post '/resources/json/delphix/connectivity/connector' do
      description 'Tests whether the specified host is accessible over Delphix '  \
                  'Connector protocol with the provided credentials. This '       \
                  'operates independent of any other objects in the Delphix '     \
                  'system. If the connection attempt is successful, then this '   \
                  'API call will return no data. If there is a problem '          \
                  'connecting to the host, an API error is returned.'
      returns     Array
      name        :connector
    end

    post '/resources/json/delphix/connectivity/jdbc' do
      description 'Tests whether the specified database is accessible over JDBC ' \
                  'with the provided credentials. This operates independent of '  \
                  'any other objects in the Delphix system. If the connection '   \
                  'attempt is successful, then this API call will return no '     \
                  'data. If there is a problem connecting to the host, an API '   \
                  'error is returned.'
      returns     Array
      name        :jdbc
    end

    post '/resources/json/delphix/connectivity/ssh' do
      description 'Tests whether the specified host is accessible over SSH with ' \
                  'the provided credentials. This operates independent of any '   \
                  'other objects in the Delphix system. If the connection '       \
                  'attempt is successful, then this API call will return no '     \
                  'data. If there is a problem connecting to the host, an API '   \
                  'error is returned.'
      returns     Array
      name        :ssh
    end
  end
end
