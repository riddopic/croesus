
# Delphix Source API template

Croesus::DSL.evaluate do
  resource :about do
    description  'Retrieve static system-wide properties.'
    root         '/resources/json/delphix/about'

    get '/resources/json/delphix/about' do
      description 'Retrieve the specified PublicSystemInfo object.'
      returns     Array
      name        :list
    end
  end
end
