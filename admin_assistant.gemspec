Gem::Specification.new do |s|
  s.name = 'admin_assistant'
  s.version = '1.0.0'
  s.date = '2009-08-02'
  s.author = 'Francis Hwang'
  s.description = 'admin_assistant is a Rails plugin that automates a lot of features typically needed in admin interfaces.'
  s.summary = 'admin_assistant is a Rails plugin that automates a lot of features typically needed in admin interfaces.'
  s.email = 'sera@fhwang.net'
  s.homepage = 'http://github.com/fhwang/admin_assistant/tree/master'
  s.files = %w(MIT-LICENSE README) +
            Dir.glob('*.rb') + 
            ['Rakefile'] +
            Dir.glob('lib/*.rb') +
            Dir.glob('lib/admin_assistant/*.rb') + 
            Dir.glob('lib/admin_assistant/*/*.rb') +
            Dir.glob('lib/images/*.png') +
            Dir.glob('lib/javascripts/*.js') +
            Dir.glob('lib/stylesheets/*.css') +
            Dir.glob('lib/views/*.erb') +
            Dir.glob('tasks/*.rake') +
            %w(vendor/ar_query/MIT-LICENSE vendor/ar_query/README) +
            Dir.glob('vendor/ar_query/*.rb') +
            Dir.glob('vendor/ar_query/*/*.rb') +
            Dir.glob('vendor/ar_query/*/*.rake')
  s.add_dependency 'will_paginate'
end
