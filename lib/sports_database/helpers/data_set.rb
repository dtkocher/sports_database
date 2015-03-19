module SportsDatabase
  module Helpers
    class DataSet

      class << self
        attr_accessor :column_names

        def column_names=(column_names)
          raise ArgumentError, "Must pass in none empty array" if column_names.nil? || !column_names.is_a?(Array) || column_names.empty?
          @column_names = column_names.map { |column_name| methodize(column_name) }
          @column_names.each do |column_name|
            self.send(:attr_accessor, column_name)
          end
        end

        def create(column_names)
          self.column_names = column_names
          self
        end

        def methodize(string)
          raise ArgumentError, "Must be a valid string" if string.nil? || string.empty?
          string.strip.gsub(/[:, ]/,"_").to_sym
        end
      end

      def set(column_name, value)
        send(DataSet.methodize("#{column_name}="), value)
      end

      def get(column_name)
        send(DataSet.methodize(column_name))
      end

      def to_hash
        hash = Hash.new
        self.class.column_names.each do |column_name|
          hash[:"#{column_name}"] = send(column_name)
        end

        hash
      end

    end
  end
end
