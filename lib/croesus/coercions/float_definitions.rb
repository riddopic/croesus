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

module Croesus::Coercions
  class FloatDefinitions
    def self.bind_to(coercer)
      coercer.register(Float, Time)     { |obj, _| Time.at(obj) }
      coercer.register(Float, Date)     { |obj, _| Time.at(obj).to_date }
      coercer.register(Float, DateTime) { |obj, _| Time.at(obj).to_datetime }
      coercer.register(Float, String)   { |obj, _| obj.to_s }
      coercer.register(Float, Integer)  { |obj, _| obj.to_i }
    end
  end
end
