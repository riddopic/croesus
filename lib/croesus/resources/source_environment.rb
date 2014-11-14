
# Delphix Source Environment DSL
#
Croesus::DSL.evaluate do
  resource :source_environment do
    description  'The generic source environment schema.'
    root         '/resources/json/delphix/environment'

    get '/resources/json/delphix/environment' do
      description 'Returns the list of all source environments.'
      returns     Array
      name        :list
    end

    get '/resources/json/delphix/environment/{ref}' do
      description 'Retrieve the specified SourceEnvironment object.'
      returns     Object
      name        :read
    end

    post '/resources/json/delphix/environment' do
      description 'Create a new SourceEnvironment object.'
      returns     String
      name        :create
    end

    post '/resources/json/delphix/environment/{ref}' do
      description 'Update the specified SourceEnvironment object.'
      input       String
      name        :update
    end

    delete '/resources/json/delphix/environment/{ref}' do
      description 'Delete the specified SourceEnvironment object.'
      input       String
      name        :delete
    end

    post '/resources/json/delphix/environment/{ref}/disable' do
      description 'Disables the given environment.'
      input       String
      name        :disable
    end

    post '/resources/json/delphix/environment/{ref}/enable' do
      description 'Enables the given environment. This is only applicable for ' \
                  'disabled environments.'
      input       String
      name        :enable
    end

    post '/resources/json/delphix/environment/{ref}/refresh' do
      description 'Refreshes the given environment.'
      input       String
      name        :refresh
    end
  end
end
