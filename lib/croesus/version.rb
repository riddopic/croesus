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

# The version number of the Croesus Gem
#
# @return [String]
#
# @api public
module Croesus
  # Contains information about this gem's version
  module Version
    MAJOR = 0
    MINOR = 1
    PATCH = 3

    # Returns a version string by joining MAJOR, MINOR, and PATCH with '.'
    #
    # Example
    #
    #   Version.string # '1.0.3'
    def self.string
      [MAJOR, MINOR, PATCH].join('.')
    end
  end

  VERSION = Croesus::Version.string
end
