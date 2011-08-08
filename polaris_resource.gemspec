# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{polaris_resource}
  s.version = "0.2.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Ryan Moran}]
  s.date = %q{2011-08-08}
  s.description = %q{RESTful API Client}
  s.email = %q{ryan.moran@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "autotest/discover.rb",
    "lib/ext/typhoeus.rb",
    "lib/polaris_client/associations.rb",
    "lib/polaris_client/inflections.rb",
    "lib/polaris_client/log_subscriber.rb",
    "lib/polaris_client/railtie.rb",
    "lib/polaris_resource.rb",
    "lib/polaris_resource/associations/association.rb",
    "lib/polaris_resource/associations/belongs_to_association.rb",
    "lib/polaris_resource/associations/has_many_association.rb",
    "lib/polaris_resource/associations/has_one_association.rb",
    "lib/polaris_resource/base.rb",
    "lib/polaris_resource/configuration.rb",
    "lib/polaris_resource/errors.rb",
    "lib/polaris_resource/filter.rb",
    "lib/polaris_resource/mixins/associations.rb",
    "lib/polaris_resource/mixins/attributes.rb",
    "lib/polaris_resource/mixins/conversion.rb",
    "lib/polaris_resource/mixins/filtering.rb",
    "lib/polaris_resource/mixins/finders.rb",
    "lib/polaris_resource/mixins/introspection.rb",
    "lib/polaris_resource/mixins/persistence.rb",
    "lib/polaris_resource/mixins/reflections.rb",
    "lib/polaris_resource/mixins/request_handling.rb",
    "lib/polaris_resource/mixins/response_parsing.rb",
    "lib/polaris_resource/mixins/url_support.rb",
    "lib/polaris_resource/mock.rb",
    "lib/polaris_resource/reflection.rb",
    "lib/polaris_resource/relation.rb",
    "lib/polaris_resource/request.rb",
    "lib/polaris_resource/request_cache.rb",
    "lib/polaris_resource/request_queue.rb",
    "lib/polaris_resource/response.rb",
    "lib/polaris_resource/response_parser.rb",
    "lib/polaris_resource/type_caster.rb",
    "lib/polaris_resource/url_builder.rb",
    "polaris_resource.gemspec",
    "spec/dummy/Rakefile",
    "spec/dummy/app/controllers/application_controller.rb",
    "spec/dummy/app/helpers/application_helper.rb",
    "spec/dummy/app/models/purchase.rb",
    "spec/dummy/app/resources/attendee.rb",
    "spec/dummy/app/resources/author.rb",
    "spec/dummy/app/resources/automobile.rb",
    "spec/dummy/app/resources/book.rb",
    "spec/dummy/app/resources/conference.rb",
    "spec/dummy/app/resources/dog.rb",
    "spec/dummy/app/resources/item.rb",
    "spec/dummy/app/resources/meeting.rb",
    "spec/dummy/app/resources/speaker.rb",
    "spec/dummy/app/resources/state.rb",
    "spec/dummy/app/views/layouts/application.html.erb",
    "spec/dummy/config.ru",
    "spec/dummy/config/application.rb",
    "spec/dummy/config/boot.rb",
    "spec/dummy/config/database.yml",
    "spec/dummy/config/environment.rb",
    "spec/dummy/config/environments/development.rb",
    "spec/dummy/config/environments/production.rb",
    "spec/dummy/config/environments/test.rb",
    "spec/dummy/config/initializers/backtrace_silencers.rb",
    "spec/dummy/config/initializers/inflections.rb",
    "spec/dummy/config/initializers/mime_types.rb",
    "spec/dummy/config/initializers/polaris_resource.rb",
    "spec/dummy/config/initializers/secret_token.rb",
    "spec/dummy/config/initializers/session_store.rb",
    "spec/dummy/config/locales/en.yml",
    "spec/dummy/config/routes.rb",
    "spec/dummy/db/migrate/20110605002144_create_purchases.rb",
    "spec/dummy/db/test.sqlite3",
    "spec/dummy/public/404.html",
    "spec/dummy/public/422.html",
    "spec/dummy/public/500.html",
    "spec/dummy/public/favicon.ico",
    "spec/dummy/public/stylesheets/.gitkeep",
    "spec/dummy/script/rails",
    "spec/polaris_client/associations_spec.rb",
    "spec/polaris_resource/associations/association_spec.rb",
    "spec/polaris_resource/associations/belongs_to_association_spec.rb",
    "spec/polaris_resource/associations/has_many_association_spec.rb",
    "spec/polaris_resource/associations/has_one_association_spec.rb",
    "spec/polaris_resource/base_spec.rb",
    "spec/polaris_resource/configuration_spec.rb",
    "spec/polaris_resource/mixins/associations_spec.rb",
    "spec/polaris_resource/mixins/attributes_spec.rb",
    "spec/polaris_resource/mixins/conversion_spec.rb",
    "spec/polaris_resource/mixins/finders_spec.rb",
    "spec/polaris_resource/mixins/introspection_spec.rb",
    "spec/polaris_resource/mixins/persistence_spec.rb",
    "spec/polaris_resource/mixins/reflection_spec.rb",
    "spec/polaris_resource/mixins/response_parsing_spec.rb",
    "spec/polaris_resource/mock_spec.rb",
    "spec/polaris_resource/relation_spec.rb",
    "spec/polaris_resource/request_cache_spec.rb",
    "spec/polaris_resource/request_spec.rb",
    "spec/polaris_resource/response_spec.rb",
    "spec/polaris_resource/type_caster_spec.rb",
    "spec/shared/active_model_lint_test.rb",
    "spec/spec_helper.rb",
    "spec/support/configuration.rb"
  ]
  s.homepage = %q{http://github.com/ryanmoran/polaris_resource}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{RESTful API Client}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<yajl-ruby>, ["~> 0.8.2"])
      s.add_runtime_dependency(%q<typhoeus>, ["~> 0.2.4"])
      s.add_runtime_dependency(%q<activemodel>, ["~> 3.0.0"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0.0"])
      s.add_runtime_dependency(%q<i18n>, ["~> 0.5.0"])
      s.add_development_dependency(%q<rails>, ["= 3.0.7"])
      s.add_development_dependency(%q<sqlite3>, ["= 1.3.3"])
      s.add_development_dependency(%q<rspec-rails>, ["= 2.6.0"])
      s.add_development_dependency(%q<yard>, ["= 0.6.8"])
      s.add_development_dependency(%q<bundler>, ["= 1.0.14"])
      s.add_development_dependency(%q<jeweler>, ["= 1.6.0"])
      s.add_development_dependency(%q<rcov>, ["= 0.9.9"])
      s.add_development_dependency(%q<autotest>, ["= 4.4.6"])
      s.add_development_dependency(%q<rocco>, ["= 0.7.0"])
      s.add_development_dependency(%q<awesome_print>, ["= 0.4.0"])
      s.add_development_dependency(%q<pry>, ["= 0.8.3"])
    else
      s.add_dependency(%q<yajl-ruby>, ["~> 0.8.2"])
      s.add_dependency(%q<typhoeus>, ["~> 0.2.4"])
      s.add_dependency(%q<activemodel>, ["~> 3.0.0"])
      s.add_dependency(%q<activesupport>, ["~> 3.0.0"])
      s.add_dependency(%q<i18n>, ["~> 0.5.0"])
      s.add_dependency(%q<rails>, ["= 3.0.7"])
      s.add_dependency(%q<sqlite3>, ["= 1.3.3"])
      s.add_dependency(%q<rspec-rails>, ["= 2.6.0"])
      s.add_dependency(%q<yard>, ["= 0.6.8"])
      s.add_dependency(%q<bundler>, ["= 1.0.14"])
      s.add_dependency(%q<jeweler>, ["= 1.6.0"])
      s.add_dependency(%q<rcov>, ["= 0.9.9"])
      s.add_dependency(%q<autotest>, ["= 4.4.6"])
      s.add_dependency(%q<rocco>, ["= 0.7.0"])
      s.add_dependency(%q<awesome_print>, ["= 0.4.0"])
      s.add_dependency(%q<pry>, ["= 0.8.3"])
    end
  else
    s.add_dependency(%q<yajl-ruby>, ["~> 0.8.2"])
    s.add_dependency(%q<typhoeus>, ["~> 0.2.4"])
    s.add_dependency(%q<activemodel>, ["~> 3.0.0"])
    s.add_dependency(%q<activesupport>, ["~> 3.0.0"])
    s.add_dependency(%q<i18n>, ["~> 0.5.0"])
    s.add_dependency(%q<rails>, ["= 3.0.7"])
    s.add_dependency(%q<sqlite3>, ["= 1.3.3"])
    s.add_dependency(%q<rspec-rails>, ["= 2.6.0"])
    s.add_dependency(%q<yard>, ["= 0.6.8"])
    s.add_dependency(%q<bundler>, ["= 1.0.14"])
    s.add_dependency(%q<jeweler>, ["= 1.6.0"])
    s.add_dependency(%q<rcov>, ["= 0.9.9"])
    s.add_dependency(%q<autotest>, ["= 4.4.6"])
    s.add_dependency(%q<rocco>, ["= 0.7.0"])
    s.add_dependency(%q<awesome_print>, ["= 0.4.0"])
    s.add_dependency(%q<pry>, ["= 0.8.3"])
  end
end

