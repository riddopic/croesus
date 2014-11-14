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

module Croesus::Validator
  class ManyValidator < Base
    def initialize
      super('_many')  # The name of the validator, underscored as it won't usually be directly invoked (invoked through use of validator)
    end

    def should_validate?(validation)
      validation.is_a?(Croesus::Validations::Many)
    end

    def presence_error_message
      "enumerable required"
    end

    def validate(key, value, validations, errors)
      unless value.is_a?(Enumerable)
        errors[key] = presence_error_message
        return
      end

      element_errors = Array.new

      value.each_with_index do |element, i|
        ::Croesus.validator_for(validations.validation).validate(i, element, validations.validation, element_errors)
      end

      element_errors.each_with_index do |e, i|
        if e.respond_to?(:empty?) && e.empty?
          element_errors[i] = nil
        end
      end

      errors[key] = element_errors unless element_errors.all?(&:nil?)
    end
  end
end

Croesus.append_validator(Croesus::Validator::ManyValidator.new)
