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
  # A single attribute that is attached to a model
  class Attribute
    attr_reader :type

    # @param type [Class] the class this attribute represents
    # @param options [Hash] extra options that can be prescribed
    def initialize(type = String, options = {})
      @type = type

      if options[:default].is_a?(Proc)
        @default = options[:default]
      else
        @default = -> { options[:default] }
      end
    end

    def default
      @default.call
    end
  end
end
