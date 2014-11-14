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

# Registry for anonymous methods, not so anonymous now are you!
#
module Croesus::AnonoMod

  @registry = {}

  def self.registry
    @registry
  end

  def self.register(resource_name, mod)
    registry[resource_name] = mod
  end
end

# Mysteries abound, dynamic box of factory creation for API resources.
#
module Croesus::ModFactory
  include Croesus::Utils

  def initialize(name, mod = Module.new)
    @mod = mod
    @name = name
    Croesus::AnonoMod.register(name, @mod)
    assemble_module
    @mod
  end

  # Sets the description the Delphix Resource.
  #
  # @param [String] description
  #   the description of the API resource
  #
  # @return [Nil]
  #
  # @api public
  def add_description(description)
    @mod.instance_variable_set(:@description, description)
    @mod.define_singleton_method(:description) { @description }
  end

  # Sets the root endpoint for the resource.
  #
  # @param [String] root
  #   the root endpoint for the resource
  #
  # @return [Nil]
  #
  # @api public
  def add_root_endpoint(root)
    @mod.instance_variable_set(:@root, root)
    @mod.define_singleton_method(:root) { @root }
  end

  def add_method(dsl_object)
    raw = dsl_object.to_hash
    name = raw[:name]
    verb = raw[:verb]
    @mod.methods[name] = raw[:description]
    @mod.singleton_class.send(:alias_method, name, "api_#{verb.downcase}")
    define_help
  end

  private #   P R O P R I E T À   P R I V A T A   Vietato L'accesso

  # Internal: Define methods to handle a verb.
  #
  # verbs - A list of verbs to define methods for.
  #
  # Examples
  #
  #   define_verbs :get, :post
  #
  # Returns nil.
  def define_verbs(*verbs)
    verbs.each do |verb|
      define_verb(verb)
      define_api_verb(verb)
    end
  end

  # Internal: Defines a method to handle HTTP requests with the passed in
  # verb.
  #
  # verb - Symbol name of the verb (e.g. :get).
  #
  # Examples
  #
  #   define_verb :get
  #   # => get 'http://server.xyz/path'
  #
  # Returns nil.
  def define_verb(verb)
    @mod.define_singleton_method(verb.to_sym) do |*args, &block|
      class_eval "Croesus.#{verb}"
    end
  end

  # Internal: Defines a method to handle HTTP requests with the passed in
  # verb to a api endpoint.
  #
  # verb - Symbol name of the verb (e.g. :get).
  #
  # Examples
  #
  #   define_api_verb :get
  #   # => api_get '/resources/json/delphix/environment'
  #
  # Returns nil.
  def define_api_verb(verb)
    @mod.define_singleton_method("api_#{verb}") do |*args, &block|
      class_eval "Croesus.#{verb}(url(*args)).body"
    end
  end

  def define_help
    @mod.define_singleton_method :help do
      puts
      dyno_width = terminal_dimensions[0] - 32
      header title: "Available commands for #{@delphix_object}",
        align: 'center', width: terminal_dimensions[0]
      table border: true do
        row header: true, color: 'red'  do
          column 'Num', width: 3, align: 'right', color: 'blue', padding: 0
          column 'Method Name', width: 18, align: 'left', padding: 0
          column "Description (http://#{Croesus.server}/api/#" \
            "#{@delphix_object.downcase})",
            width: dyno_width, align: 'left', padding: 0
        end
        (@methods.keys).sort.each.with_index(1) do |method, i|
          row do
            column '%02d' % i
            column method
            column @methods[method.to_sym]
          end
        end
      end
      puts @description
    end
  end

  def assemble_module
    add_included_hook
    add_instance_variables
    be_polite_and_debuggable
    define_verbs('get', 'post', 'delete')
  end

  def add_included_hook
    @mod.send :include, Croesus::BasicMethods
    @mod.send :include, CommandLineReporter
    @mod.send :include, Croesus::Utils
  end

  def add_instance_variables
    @mod.instance_variable_set(:@delphix_object, classify(@name))
    @mod.define_singleton_method(:delphix_object) { @delphix_object }

    @mod.instance_variable_set(:@methods, {})
    @mod.define_singleton_method(:methods) { @methods }
  end

  def be_polite_and_debuggable
    @mod.define_singleton_method :to_s do
      "<#{self.class.name}:#{self.name}:#{object_id}>"
    end

    @mod.define_singleton_method :inspect do
      "<#{self.class.name}:#{self.name}:#{object_id} #{instance_variables}>"
    end
  end
end
