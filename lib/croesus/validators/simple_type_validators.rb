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

[
  Array,
  Complex,
  Enumerable,
  Float,
  Integer,
  Numeric,
  Range,
  Rational,
  Regexp,
  String,
  Symbol,
  Time
].each do |type|
  name = type.to_s.gsub(/(.)([A-Z])/,'\1_\2').downcase
  Croesus.append_validator(Croesus::Validator::SimpleValidator.new(
    name, lambda { |v| v.is_a?(type) })
  )
end
