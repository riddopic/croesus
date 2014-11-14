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
  # The class that coerces objects based on the definitions that are registered
  # with it.
  class Coercer
    def initialize
      @coercions = Hash.new do |hash, origin|
        hash[origin] = Hash.new do |h, target|
          h[target] = Coercion.new(origin, target)
        end
      end
      @mutex = Mutex.new
    end

    # Registers a coercion with the Croesus library
    #
    # @param origin [Class] the class to convert
    # @param target [Class] what the origin will be converted to
    def register(origin, target, &block)
      raise(ArgumentError, 'block is required') unless block_given?

      @mutex.synchronize do
        @coercions[origin][target] = Coercion.new(origin, target, &block)
      end
    end

    # Removes a coercion from the library
    #
    # @param origin [Class]
    # @param target [Class]
    def unregister(origin, target)
      @mutex.synchronize do
        @coercions[origin].delete(target)
      end
    end

    # @param object [Object] the object to coerce
    # @param target [Class] what you want the object to turn in to
    def coerce(object, target)
      @mutex.synchronize do
        @coercions[object.class][target].call(object)
      end
    end
  end

  # This wraps the block that is provided when you register a coercion.
  class Coercion
    # Just passes the object on through
    PASS_THROUGH = ->(obj, _) { obj }

    # @param origin [Class] the class that the object is
    # @param target [Class] the class you wish to coerce to
    def initialize(origin, target, &block)
      @origin  = origin
      @target  = target
      @block   = block_given? ? block : PASS_THROUGH
    end

    # Calls the coercion
    #
    # @return [Object]
    def call(object)
      @block.call(object, @target)
    end
  end
end

%w(
  date_definitions
  date_time_definitions
  fixnum_definitions
  float_definitions
  integer_definitions
  string_definitions
  time_definitions
  hash_definitions
  boolean_definitions
).each { |file| require File.join('croesus/coercions/', file) }

module Croesus::Coercions
  def self.bind_to(coercer)
    Croesus::Coercions::DateDefinitions.bind_to(coercer)
    Croesus::Coercions::DateTimeDefinitions.bind_to(coercer)
    Croesus::Coercions::FixnumDefinitions.bind_to(coercer)
    Croesus::Coercions::FloatDefinitions.bind_to(coercer)
    Croesus::Coercions::IntegerDefinitions.bind_to(coercer)
    Croesus::Coercions::StringDefinitions.bind_to(coercer)
    Croesus::Coercions::TimeDefinitions.bind_to(coercer)
    Croesus::Coercions::HashDefinitions.bind_to(coercer)
    Croesus::Coercions::BooleanDefinitions.bind_to(coercer)
  end
end
