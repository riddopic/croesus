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
  module Querying
    module ClassMethods
      def read(id, options = nil)
        { id: id, options: options, model: self, hit: false }
      end
      alias_method :get, :read
      alias_method :find, :read

      def read!(id, options = nil)
        read(id, options) || raise(NotFound.new(id))
      end
      alias_method :get!, :read!
      alias_method :find!, :read!

      def read_multiple(ids, options = nil)
        { ids: ids, options: options, model: self, hits: 0, misses: 0 }
      end
      alias_method :get_multiple, :read_multiple
      alias_method :find_multiple, :read_multiple

      def key?(id, options = nil)
        { id: id, options: options, model: self }
      end
      alias :has_key? :key?

      def load(id, attrs)
        attrs ||= {}
        instance = constant_from_attrs(attrs).allocate
        instance.initialize_from_database(attrs.update('id' => id))
      end

      def constant_from_attrs(attrs)
        self if attrs.nil?
        type = attrs[:type] || attrs['type']
        self if type.nil?
        type.constantize
      rescue NameError
        self
      end
      private :constant_from_attrs
    end
  end
end
