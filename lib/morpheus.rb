# We are using Yalj::Ruby for its JSON parsing hotness.
require 'yajl/json_gem'

# Typhoeus is used for HTTP requests. The libcurl library allows us to make multiple requests in parallel.
require 'typhoeus'

# ActiveModel provides validations, errors, naming...
require 'active_model'

# The bulk of the library consists of the Base class and its mix-in modules, the request/response wrappers,
# mocking, configuration, errors, and classes managing associations, reflections, relations, and typecasting.
module Morpheus
  autoload :Version, 'morpheus/version'

  autoload :Base,           'morpheus/base'
  autoload :Configuration,  'morpheus/configuration'
  autoload :Filter,         'morpheus/filter'
  autoload :Mock,           'morpheus/mock'
  autoload :Reflection,     'morpheus/reflection'
  autoload :Relation,       'morpheus/relation'
  autoload :Request,        'morpheus/request'
  autoload :RequestQueue,   'morpheus/request_queue'
  autoload :RequestCache,   'morpheus/request_cache'
  autoload :Response,       'morpheus/response'
  autoload :ResponseParser, 'morpheus/response_parser'
  autoload :TypeCaster,     'morpheus/type_caster'
  autoload :UrlBuilder,     'morpheus/url_builder'

  # Mixins provide behaviors to the Base class.
  autoload :Associations,    'morpheus/mixins/associations'
  autoload :Attributes,      'morpheus/mixins/attributes'
  autoload :Conversion,      'morpheus/mixins/conversion'
  autoload :Filtering,       'morpheus/mixins/filtering'
  autoload :Finders,         'morpheus/mixins/finders'
  autoload :Introspection,   'morpheus/mixins/introspection'
  autoload :Persistence,     'morpheus/mixins/persistence'
  autoload :Reflections,     'morpheus/mixins/reflections'
  autoload :RequestHandling, 'morpheus/mixins/request_handling'
  autoload :ResponseParsing, 'morpheus/mixins/response_parsing'
  autoload :UrlSupport,      'morpheus/mixins/url_support'

  # Error classes
  autoload :ConfigurationError,          'morpheus/errors'
  autoload :NetConnectNotAllowedError,   'morpheus/errors'
  autoload :RemoteHostConnectionFailure, 'morpheus/errors'
  autoload :ResourceNotFound,            'morpheus/errors'
  autoload :UnrecognizedTypeCastClass,   'morpheus/errors'
  autoload :ServerError,                 'morpheus/errors'
  autoload :InvalidResponseCode,         'morpheus/errors'
end

# Associations for application objects, typically ActiveRecord, to resource
module Morpheus
  module Client
    autoload :Associations,  'morpheus/client/associations'
    autoload :LogSubscriber, 'morpheus/client/log_subscriber'
  end
end

# The Railtie loads the LogSubscriber for printing output to the Rails log, and
# Associations which plug-in to ActiveRecord to link associated resources.
require 'morpheus/client/railtie'     if defined?(Rails)
require 'morpheus/client/inflections' if defined?(ActiveSupport)

# There are some Typhoeus patches contained here.
require 'ext/typhoeus'
