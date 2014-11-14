
# Delphix Source API template

Croesus::DSL.evaluate do
  resource :source_repository do
    description  'Source repositories are containers for SourceConfig objects. '\
                 'Each Environment can contain any number of repositories, and '\
                 'repositories can contain any number of source ' \
                 'configurations. A repository typically corresponds to a ' \
                 'database installation.'
    root         '/resources/json/delphix/repository'

  end
end
