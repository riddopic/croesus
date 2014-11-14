
# Delphix Source API template

Croesus::DSL.evaluate do
  resource :group do
    description  'Database group.'
    root         '/resources/json/delphix/group'

    get '/resources/json/delphix/group' do
      description 'List Group objects on the system.'
      returns     Array
      name        :list
    end

    get '/resources/json/delphix/group/{ref}' do
      description 'Retrieve the specified Group object.'
      returns     Array
      name        :read
    end

    post '/resources/json/delphix/group' do
      description 'Create a new Group object.'
      name        :create
    end

    post '/resources/json/delphix/group/{ref}' do
      description 'Update the specified Group object.'
      name        :update
    end

    delete '/resources/json/delphix/group/{ref}' do
      description 'Deletes the specified group. Any databases within the group '\
                  'must be deleted first, otherwise this will fail.'
      name        :delete
    end
  end
end
