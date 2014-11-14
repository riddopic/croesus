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

class Croesus::Validator::HashValidator < Croesus::Validator::Base
  def initialize
    super('hash')
  end

  def should_validate?(item)
    item.is_a?(Hash)
  end

  def validate(key, value, validations, errors)
    # Validate hash
    unless value.is_a?(Hash)
      errors[key] = presence_error_message
      return
    end

    # Hashes can contain sub-elements, attempt to validator those
    errors = (errors[key] = {})

    validations.each do |v_key, v_value|
      Croesus.validator_for(v_value).validate(
        v_key, value[v_key], v_value, errors
      )
    end

    # Cleanup errors (remove any empty nested errors)
    errors.delete_if { |k,v| v.empty? }
  end
end

Croesus.append_validator(Croesus::Validator::HashValidator.new)
