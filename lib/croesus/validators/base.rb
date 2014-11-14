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

class Croesus::Validator::Base
  attr_accessor :name

  def initialize(name)
    unless name.is_a?(String) && name.size > 0
      raise StandardError.new(
        'Validator must be initialized with a valid name '\
        '(string with length greater than zero).'
      )
    end

    self.name = name
  end

  def should_validate?(name)
    self.name == name
  end

  def presence_error_message
    "#{self.name} required"
  end

  def validate(key, value, validations, errors)
    raise ValidationError.new(
      'Validate should not be called directly on Croesus::Validator::Base'
    )
  end
end
