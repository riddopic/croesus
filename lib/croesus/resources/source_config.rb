
# Delphix Source API template

Croesus::DSL.evaluate do
  resource :source_config do
    description  'The source config represents the dynamically discovered ' \
                 'attributes of a source.'
    root         '/resources/json/delphix/sourceconfig'

    get '/resources/json/delphix/sourceconfig' do
      description 'Returns a list of source configs within the repository or ' \
                  'the environment.'
      returns     Array
      name        :list
    end

    get '/resources/json/delphix/sourceconfig/{ref}' do
      description 'Retrieve the specified SourceConfig object.'
      returns     Object
      name        :read
    end

    post '/resources/json/delphix/sourceconfig' do
      description 'Create a new SourceConfig object.'
      returns     String
      name        :create
    end

    post '/resources/json/delphix/sourceconfig/{ref}' do
      description 'Update the specified SourceConfig object.'
      input       String
      name        :update
    end

    delete '/resources/json/delphix/sourceconfig/{ref}' do
      description 'Delete the specified SourceConfig object.'
      input       String
      name        :delete
    end

    delete '/resources/json/delphix/sourceconfig/{ref}/defaultType' do
      description 'None available'
      input       String
      name        :defaultType
    end

    delete '/resources/json/delphix/sourceconfig/{ref}/validateCredentials' do
      description 'Tests the validity of the supplied database credentials, ' \
                  'returning an error if unable to connect to the database'
      input       String
      name        :defaultType
    end
  end
end
