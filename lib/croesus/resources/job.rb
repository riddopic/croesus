
# Delphix Source API template

Croesus::DSL.evaluate do
  resource :job do
    description  'Represents a job object.'
    root         '/resources/json/delphix/job'

    get '/resources/json/delphix/job' do
      description 'Returns a list of jobs in the system. Jobs are listed in '   \
                  'start time order.'
      returns     Array
      name        :list
    end

    get '/resources/json/delphix/job/{ref}' do
      description 'Retrieve the specified Job object.'
      returns     Array
      name        :read
    end

    post '/resources/json/delphix/job/{ref}' do
      description 'Update the specified Job object.'
      name        :update
    end
  end
end
