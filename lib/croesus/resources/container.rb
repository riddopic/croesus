
# Delphix Source API template

Croesus::DSL.evaluate do
  resource :container do
    description  'A container holding data.'
    root         '/resources/json/delphix/database'

    get '/resources/json/delphix/database' do
      description 'Returns a list of databases on the system or within a group.'
      returns     Array
      name        :list
    end

    get '/resources/json/delphix/database/{ref}' do
      description 'Retrieve the specified Container object.'
      returns     Object
      name        :read
    end

    post '/resources/json/delphix/database/{ref}' do
      description 'Update the specified Container object.'
      input       String
      name        :update
    end

    post '/resources/json/delphix/database/{ref}' do
      description 'Delete the specified Container object.'
      input       String
      name        :delete
    end

    post '/resources/json/delphix/database/export' do
      description 'Provision a physical database.'
      input       String
      name        :export
    end

    post '/resources/json/delphix/database/fileMapping' do
      description 'Generate file mappings for a particular timeflow point and ' \
                  'a set of rules.'
      input       String
      name        :fileMapping
    end

    post '/resources/json/delphix/database/link' do
      description 'Links the database specified by link parameters.'
      input       String
      name        :link
    end

    post '/resources/json/delphix/database/provision' do
      description 'Provisions the container specified by the provision ' \
                  'parameters.'
      input       String
      name        :provision
    end

    post '/resources/json/delphix/database/validateXpp' do
      description 'Validate the container for cross-platform provisioning.'
      input       String
      name        :validateXpp
    end

    post '/resources/json/delphix/database/xpp' do
      description 'Provisions the container specified by the provision ' \
                  'parameters to a different host platform.'
      input       String
      name        :xpp
    end

    post '/resources/json/delphix/database/{ref}/attachSource' do
      description 'Attaches a database source to a previously detached container.'
      input       String
      name        :attachSource
    end

    post '/resources/json/delphix/database/{ref}/connectionInfo' do
      description 'Returns the connection information for the source '\
                  'associated with this container.'
      input       String
      name        :connectionInfo
    end

    post '/resources/json/delphix/database/{ref}/detachSource' do
      description 'Detaches a linked source from a database.'
      input       String
      name        :detachSource
    end

    post '/resources/json/delphix/database/{ref}/refresh' do
      description 'Refreshes a container.'
      input       String
      name        :refresh
    end

    post '/resources/json/delphix/database/{ref}/requestXppUpload' do
      description 'Request upload for cross-platform provisioning. See ' \
                  'UploadParameters for more information on how to upload files.'
      input       String
      name        :requestXppUpload
    end

    post '/resources/json/delphix/database/{ref}/rollback' do
      description 'Rolls back a container.'
      input       String
      name        :rollback
    end

    post '/resources/json/delphix/database/{ref}/switchTimeflow' do
      description 'Switch to the latest point on the specified TimeFlow.'
      input       String
      name        :switchTimeflow
    end

    post '/resources/json/delphix/database/{ref}/sync' do
      description 'Performs SnapSync on a database.'
      input       String
      name        :sync
    end

    post '/resources/json/delphix/database/{ref}/testPerformanceModeDataLoss' do
      description 'Test the effect of data loss as might be seen as a result ' \
                  'of a Delphix Engine failure with performanceMode enabled.'
      input       String
      name        :testPerformanceModeDataLoss
    end

    get '/resources/json/delphix/database/{ref}/xppStatus' do
      description 'Get the cross-platform provisioning status of this container.'
      input       String
      name        :xppStatus
    end
  end
end
