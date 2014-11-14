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

class Croesus::Validator::EnumerableValidator < Croesus::Validator::Base
  def initialize
    super('_enumerable')  # The name of the validator, underscored as it won't usually be directly invoked (invoked through use of validator)
  end

  def should_validate?(item)
    item.is_a?(Enumerable)
  end

  def presence_error_message
    'value from list required'
  end

  def validate(key, value, validations, errors)
    unless validations.include?(value)
      errors[key] = presence_error_message
    end
  end
end

Croesus.append_validator(Croesus::Validator::EnumerableValidator.new)
