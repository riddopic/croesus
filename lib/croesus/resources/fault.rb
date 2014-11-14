
# Delphix Source API template

Croesus::DSL.evaluate do
  resource :fault do
    description  'A representation of a fault, with associated user object.'
    root         '/resources/json/delphix/fault'

    get '/resources/json/delphix/fault' do
      description 'Returns the list of all the faults that match the given '    \
                  'criteria.'
      returns     Array
      name        :list
    end

    get '/resources/json/delphix/fault/{ref}' do
      description 'Retrieve the specified Fault object '      \
                  'criteria.'
      returns     Array
      name        :read
    end

    post '/resources/json/delphix/fault/{ref}/resolve' do
      description 'Marks the fault as resolved. The system will attempt to '      \
                  'automatically detect cases where the fault has been resolved; '\
                  'but this is not always possible and may only occur on '        \
                  'periodic intervals. In these cases, the user can proactively ' \
                  'mark the fault resolved. This does not change the underlying ' \
                  'disposition of the fault - if the problem is still present '   \
                  'the system may immediately diagnose the same problem again. '  \
                  'This should only be used to notify the system of resolution '  \
                  'after the underlying problem has been resolved.'
                  'criteria.'
      returns     Array
      name        :resolve
    end
  end
end
