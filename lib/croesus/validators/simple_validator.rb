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

class Croesus::Validator::SimpleValidator < Croesus::Validator::Base
  attr_accessor :lambda

  def initialize(name, lambda)
    # lambda must accept one argument (the value)
    if lambda.arity != 1
      raise ValidationError.new(
        "Lambda should take only one argument; passed #{lambda.arity}"
      )
    end

    super(name)
    self.lambda = lambda
  end

  def validate(key, value, validations, errors)
    unless lambda.call(value)
      errors[key] = presence_error_message
    end
  end
end
