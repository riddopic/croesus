# encoding: UTF-8
#
# Author: Stefano Harding <riddopic@gmail.com>
#
# Copyright (C) 2014 Stefano Harding
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied. See the License for the specific language governing
# permissions and limitations under the License.
#

# Debuging hook 'n' stow
require 'ap'

# Croesus Ruby bindings
require 'rest-client'
require 'command_line_reporter'

# Core Ruby Extentions
require 'croesus/core_ext/blank'
require 'croesus/core_ext/hash'

# Version
require 'croesus/version'

# Base
require 'croesus/utils'
require 'croesus/platform'
require 'croesus/querying'
require 'croesus/attribute'
require 'croesus/attributes'
require 'croesus/validations'
require 'croesus/identity_map'

# DSL
require 'croesus/dsl/dsl'
require 'croesus/dsl/helpers'
require 'croesus/dsl/mod_factory'
require 'croesus/dsl/resource_dsl'
require 'croesus/dsl/route_dsl'

# Resources
require 'croesus/resources/basic_methods'
require 'croesus/resources/about'
require 'croesus/resources/connectivity'
require 'croesus/resources/container'
require 'croesus/resources/fault'
require 'croesus/resources/fault_effect'
require 'croesus/resources/group'
require 'croesus/resources/host'
require 'croesus/resources/job'
require 'croesus/resources/namespace'
require 'croesus/resources/policy'
require 'croesus/resources/source'
require 'croesus/resources/source_config'
require 'croesus/resources/source_environment'
require 'croesus/resources/source_repository'
require 'croesus/resources/system_info'
require 'croesus/resources/timeflow'
require 'croesus/resources/timeflow_snapshot'

# Web CLient
require 'croesus/web_client/web_client'
require 'croesus/web_client/web_request'
require 'croesus/web_client/web_response'

# A library for supporting connections to the Delphix API.
#
module Croesus
  extend Utils::ClassMethods
  include IdentityMap
  include Querying
  include Utils

  NotFound             = Class.new StandardError
  APIError             = Class.new StandardError
  CoercionError        = Class.new StandardError
  ValidationError      = Class.new StandardError
  ConfigurationError   = Class.new StandardError
  InvalidStateError    = Class.new StandardError
  InvalidMethodError   = Class.new StandardError
  InvalidArgumentCount = Class.new StandardError

  API_VERSION          = { type: 'APIVersion', major: 1, minor: 3, micro: 0 }

  API_ENDPOINT         = '/resources/json/delphix'

  HTTP_HEADERS         = {
    'Accept'           =>  'application/json; charset=UTF-8',
    'Content-Type'     =>  'application/json; charset=UTF-8',
    'User-Agent'       =>  "Croesus/#{Croesus::VERSION} " \
                           "(#{RUBY_ENGINE}/#{RUBY_PLATFORM} " \
                           "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL})"
  }

  @@timeout = 10
  @@default_headers = {}

  # Represents an undefined parameter used by auto-generated option methods
  Undefined = Object.new.freeze

  class << self
    # @!attribute [rw] last_request
    #   @return [Hash] retruns the last request
    attr_accessor :last_request

    # @!attribute [rw] last_response
    #   @return [Hash] retruns the last response
    attr_accessor :last_response

    # @!attribute [rw] session
    #   @return [Hash] retruns current session state
    #   @return [#code] the response code from Delphix engine
    #   @return [#headers] beautified with symbols and underscores
    #   @return [#body] parsed response body
    #   @return [#raw_body] un-parsed response body
    attr_accessor :session

    # @!attribute [rw] server
    #   @return [String] Delphix server address
    attr_accessor :server

    # @!attribute [rw] api_user
    #   @return [String] username to authenticate with
    attr_accessor :api_user

    # @!attribute [rw] api_passwd
    #   @return [String] password for authentication
    attr_accessor :api_passwd

    # @!attribute [rw] verbose
    #   @return [Nothing] enables verbosity
    attr_accessor :verbose
  end

  @inheritance ||= 'not implemented'
  Croesus::IdentityMap.enabled = true

  # Returns the API endpoint for a given resource namespace by combining the
  # server address with the appropriate HTTP headers.
  #
  # @param resource [Resource] namespace
  #
  # @return [URL] return the URL for the API endpoint
  #
  # @api public
  def self.api_url(resource = nil)
    'http://' + @server + resource
  end

  def self.session
    Croesus.default_header(:cookies, cookies)
    @session ||= login(@api_user, @api_passwd)
  end

  # Establish a session with the Delphix engine and return an identifier
  # through browser cookies. This session will be reused in subsequent calls,
  # the same session credentials and state are preserved without requiring a
  # re-authentication call. Sessions do not persisit between incovations.
  #
  # @return [Hash] cookies
  #   containing the new session cookies
  #
  # @api public
  def self.cookies
    @resp ||= Croesus.post session_url,
      { type: 'APISession', version: API_VERSION }
    @resp.cookies
  end

  # Authenticates the session so that API calls can be made. Only supports basic
  # password authentication.
  #
  # @param [String] user
  #   user name to authenticate with
  # @param [String] passwd
  #   password to authenticate with
  #
  # @return [Fixnum, #code]
  #   the response code from Delphix engine
  # @return [Hash, #headers]
  #   headers, beautified with symbols and underscores
  # @return [Hash, #body] body
  #   parsed response body where applicable (JSON responses are parsed to
  #   Objects/Associative Arrays)
  # @return [Hash, #raw_body] raw_body
  #   un-parsed response body
  #
  # @api public
  def self.login(user = @api_user, passwd = @api_passwd)
    Croesus.post login_url,
      { type: 'LoginRequest', username: user, password: passwd }
  end

  # Provides a wraper around getting the URL for the resource by using the
  # resource_url shorthand.
  #
  # @return [URL] return the API URL for the given resource.
  #
  # @api public
  [:session, :login, :environment, :alert, :database, :source].each do |name|
    define_singleton_method(name.to_s + '_url') do
      api_url( '/resources/json/delphix/' + name.to_s)
    end
  end

  def self.validate(*args)
    Base.validate(*args)
  end

  def self.optional(validation)
    Validations::Optional.new(validation)
  end

  def self.many(validation)
    Validations::Many.new(validation)
  end

  # @!visibility private
  def self.to_s
    "<#{self.class.name}:#{self.name}:#{object_id} @session=#{@session}>"
  end
  alias :inspect :to_s

  # Hooks into the mixin process to add Croesus components to the given parent
  # automatically.
  #
  # @param [Class] parent the object this is being mixed into
  def self.included(parent)
    parent.class_eval do
      include InstanceMethods
      extend  ClassMethods
      "<#{self.class.name}:#{self.name}:#{object_id} @session=#{@session}>"
    end
  end
  private_class_method :included

  # From where forth do ye descend!
  def descendants
    ObjectSpace.each_object(::Class).select {|klass| klass < self }
  end
end
