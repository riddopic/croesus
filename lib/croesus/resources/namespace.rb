
# Delphix Source API template

Croesus::DSL.evaluate do
  resource :namespace do
    description  'Objects within namespaces are always read-only. Attempts to ' \
                 'modify those objects, or perform read-write operations using '\
                 'them, will fail. When a namespace is failed over '\
                 '(activated), all objects become read-write (assuming there '  \
                 'are no conflicts in terms of names or shared resources) and ' \
                 'it is no longer possible to receive subsequent replication '  \
                 'updates.'
    root         '/resources/json/delphix/namespace'

    get '/resources/json/delphix/namespace' do
      description 'List Namespace objects on the system.'
      returns     Array
      name        :list
    end

    get '/resources/json/delphix/namespace/{ref}' do
      description 'Retrieve the specified Namespace object.'
      returns     Array
      name        :read
    end

    post '/resources/json/delphix/namespace/{ref}' do
      description 'Update the specified Namespace object.'
      name        :update
    end

    delete '/resources/json/delphix/namespace/{ref}' do
      description 'Deletes a namespace and all of the objects contained within '\
                  'it. This will cause all of the objects in the namespace to ' \
                  'be permanently removed.'
      name        :delete
    end
  end
end
