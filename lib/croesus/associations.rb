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

module Croesus::Associations

  def has_many(resource, options = {})
    class_name = options[:class_name] || "Croesus::#{resource.to_s.classify}"

    class_eval do
      define_method resource do
        instance_variable_get("@#{resource}") ||
          instance_variable_set("@#{resource}", Croesus::ResourceCollection.new(
            class_name.constantize, self.satisfaction, options[:url]))
      end
    end
  end

  def belongs_to(resource, options = {})
    class_name = options[:class_name] || "Croesus::#{resource.to_s.classify}"
    parent_id = options[:parent_attribute] || "#{resource}_id"

    class_eval do
      define_method resource do
        instance_variable_get("@#{resource}") ||
          instance_variable_set("@#{resource}",
            class_name.constantize.new(parent_id, self.satisfaction))
      end
    end
  end
end
