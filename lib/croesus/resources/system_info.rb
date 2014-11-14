
# Delphix Source API template

Croesus::DSL.evaluate do
  resource :system_info do
    description  'Retrieve system-wide properties and manage the state of ' \
                 'the system.'
    root         '/resources/json/delphix/system'

    get '/resources/json/delphix/system' do
      description 'Retrieve the specified SystemInfo object.'
      returns     Array
      name        :list
    end

    post '/resources/json/delphix/system' do
      description 'Update the specified SystemInfo object.'
      name        :update
    end
  end
end
