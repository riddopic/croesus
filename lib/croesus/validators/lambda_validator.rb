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

class Croesus::Validator::LambdaValidator < Croesus::Validator::Base
  def initialize
    super('_lambda')  # The name of the validator, underscored as it won't usually be directly invoked (invoked through use of validator)
  end

  def should_validate?(item)
    if item.is_a?(Proc)
      if item.arity == 1
        true
      else
        raise InvalidArgumentCount.new(
          "Lambda validator should only accept one argument; " \
          "supplied lambda accepts #{item.arity}."
        )
      end
    else
      false
    end
  end

  def presence_error_message
    'is not valid'
  end

  def validate(key, value, lambda, errors)
    unless lambda.call(value)
      errors[key] = presence_error_message
    end

  rescue
    errors[key] = presence_error_message
  end
end

Croesus.append_validator(Croesus::Validator::LambdaValidator.new)
