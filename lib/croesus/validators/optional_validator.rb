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
  class OptionalValidator < Base
    def initialize
      # The name of the validator, underscored as it won't usually be directly
      # invoked (invoked through use of validator).
      super('_optional')
    end

    def should_validate?(validation)
      validation.is_a?(Croesus::Validations::Optional)
    end

    def validate(key, value, validations, errors)
      if value
        ::Croesus.validator_for(validations.validation).validate(key, value, validations.validation, errors)
        errors.delete(key) if errors[key].respond_to?(:empty?) && errors[key].empty?
      end
    end
  end
end

Croesus.append_validator(Croesus::Validator::OptionalValidator.new)
