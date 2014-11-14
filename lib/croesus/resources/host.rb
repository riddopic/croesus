
# Delphix Source API template

Croesus::DSL.evaluate do
  resource :host do
    description  'The representation of a host object.'
    root         '/resources/json/delphix/host'

    get '/resources/json/delphix/host' do
      description 'Returns the list of all hosts in the system.'
      returns     Array
      name        :list
    end

    get '/resources/json/delphix/host/{ref}' do
      description 'Retrieve the specified Host object.'
      returns     Array
      name        :read
    end

    post '/resources/json/delphix/host/{ref}' do
      description 'Update the specified Host object.'
      name        :update
    end
  end
end
