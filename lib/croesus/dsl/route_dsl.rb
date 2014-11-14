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
  class RouteDSL
    include Croesus::DSLHelpers

    setter :name, :verb, :path, :description, :input, :returns
    varags_setter

    def initialize(verb, path, &block)
      instance_eval(&block)
      @name        ||= name
      @verb          = verb
      @path          = path
      @input       ||= nil
      @returns     ||= nil
      @description ||= description
    end

    def to_hash
      { name: @name, verb: @verb, path: @path, input: @input,
        returns: @returns, description: @description }
    end
  end
end
