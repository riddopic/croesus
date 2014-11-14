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
  class Base
    attr_accessor :hash, :validations, :errors

    def initialize(hash, validations)
      self.errors      = {}
      self.hash        = hash
      self.validations = validations.inject({
        }){ |memo,(k,v)| memo[k] = v.to_s.downcase; memo }
      validate
    end

    def valid?
      errors.empty?
    end

    def self.validate(hash, validations)
      new(hash, validations)
    end

    private #   P R O P R I E T À   P R I V A T A   Vietato L'accesso

    def validate
      Croesus.validator_for(hash).validate(
        :base, self.hash, self.validations, self.errors
      )
      self.errors = errors[:base]
    end
  end

  @@validators = []

  def self.append_validator(validator)
    unless validator.is_a?(Croesus::Validator::Base)
      raise ValidationError.new(
        'Validators inherit from Croesus::Validator::Base'
      )
    end

    if @@validators.detect { |v| v.name == validator.name }
      raise ValidationError.new('Validators must have unique names.')
    end

    @@validators << validator
  end

  def self.validator_for(item)
    @@validators.detect { |v| v.should_validate?(item) } ||
      raise(ValidationError.new("Could not find valid validator for: #{item}"))
  end

  module Validator
  end

  module Validations
  end
end

# Load validators
require 'croesus/validations/optional'
require 'croesus/validations/many'
require 'croesus/validators/base'
require 'croesus/validators/simple_validator'
require 'croesus/validators/hash_validator'
require 'croesus/validators/presence_validator'
require 'croesus/validators/simple_type_validators'
require 'croesus/validators/boolean_validator'
require 'croesus/validators/email_validator'
require 'croesus/validators/enumerable_validator'
require 'croesus/validators/lambda_validator'
require 'croesus/validators/optional_validator'
require 'croesus/validators/many_validator'
