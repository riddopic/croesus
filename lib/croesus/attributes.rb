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

module Croesus
  class Attributes
    # @param params [Hash] the parameters you wish to initialize the model
    #    with. If the model does not have an accessor set, it will ignore
    #    the attribute passed.
    def initialize(attributes = {})
      self.attributes = attributes
    end

    # Sets the attributes on the model
    # @param attributes [Hash]
    def attributes=(attributes = {})
      attributes.each do |attr, value|
        self.send("#{attr}=", value) if self.respond_to?("#{attr}=")
      end
    end

    # Get and ser the attributes on the model.
    #
    # @return [Hash]
    def attributes
      hash = {}
      self.class.attributes.keys.each do |k|
        hash[k] = send(k) if respond_to?(k)
      end
      hash
    end

    def to_h
      self.attributes
    end

    def self.attributes
      @attributes ||= {}
    end

    # @override
    def self.attr_accessor(*args)
      args.each { |name| self.attributes[name] = Attribute.new(Object) }
      super
    end

    # Declares an attribute on the model
    #
    # @param name [String]
    # @param type [Class] a class that represents the type
    # @param options [Hash] extra options to apply to the attribute
    def self.attribute(name, type=String, options={})
      config = { writer: true, reader: true }.merge(options)

      attr = Attribute.new(type, options)
      self.attributes[name] = attr
      variable = "@#{name}"

      if config[:writer]
        define_method("#{name}=") do |object|
          val = Croesus.coercer.coerce(object, attr.type)
          instance_variable_set(variable, val)
        end
      end

      if config[:reader]
        define_method(name) do
          val = instance_variable_get(variable)
          unless val
            val = attr.default
            instance_variable_set(variable, val)
          end
          val
        end
      end
    end # def self.attribute
  end # class Attributes
end # module Croesus
