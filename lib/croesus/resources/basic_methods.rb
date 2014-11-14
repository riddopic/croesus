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

module Croesus::BasicMethods
  def self.included(base)
    base.extend(ClassMethods)
  end
  private_class_method :included

  module ClassMethods

    def url(ref: nil, filter: nil, action: nil)
      url = @root
      url = ref.nil?    ? url : "#{url}/#{ref}"
      url = filter.nil? ? url : "#{url}/#{filter}"
      url = action.nil? ? url : "#{url}/#{action}"
      Croesus.api_url(url)
    end
  end
end
