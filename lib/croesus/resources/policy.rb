
# Delphix Source API template

Croesus::DSL.evaluate do
  resource :policy do
    description  'The base policy type.'
    root         '/resources/json/delphix/policy'


    get '/resources/json/delphix/policy' do
      description 'Returns a list of policies in the domain.'
      returns     Array
      name        :list
    end

    get '/resources/json/delphix/policy/{ref}' do
      description 'Retrieve the specified Policy object.'
      returns     Array
      name        :read
    end

    post '/resources/json/delphix/policy' do
      description 'Creates a new policy, subject to restrictions (see docs).'
      name        :create
    end

    post '/resources/json/delphix/policy/{ref}' do
      description 'Update the specified Policy object.'
      name        :update
    end

    delete '/resources/json/delphix/policy/{ref}' do
      description 'Deletes the specified policy, subject to restrictions '\
                  '(see docs).'
      name        :delete
    end
  end
end
