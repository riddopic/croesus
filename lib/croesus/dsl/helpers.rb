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

module Croesus::DSLHelpers
  def self.included(base)
    base.extend(ClassMethods)
  end
  private_class_method :included

  module ClassMethods
    def setter(*method_names)
      method_names.each do |name|
        send :define_method, name do |data|
          instance_variable_set "@#{name}".to_sym, data
        end
      end
    end

    def varags_setter(*method_names)
      method_names.each do |name|
        send :define_method, name do |*data|
          instance_variable_set "@#{name}".to_sym, data
        end
      end
    end
  end
end
