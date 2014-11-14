
# Delphix Source API template

Croesus::DSL.evaluate do
  resource :fault_effect do
    description  'An error affecting a user object whose root cause is a ' \
                 'fault. A fault effect can only be resolved by resolving the ' \
                 'fault which is its root cause.'
    root         '/resources/json/delphix/fault/effect'

    get '/resources/json/delphix/fault/effect' do
      description 'Returns the list of all the fault effects that match the '     \
                  'given criteria.'
      returns     Array
      name        :list
    end

    get '/resources/json/delphix/fault/effect/{ref}' do
      description 'Retrieve the specified FaultEffect object.'
      returns     Array
      name        :read
    end
  end
end
