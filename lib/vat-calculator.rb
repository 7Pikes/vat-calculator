require "vat-calculator/version"

module Vat
  module Calculator
    def sum_of_vat_for *args
      calculate_sum(args) do |price, vat|
        (vat * price) / (100.0 + vat)
      end
    end

    def sum_without_vat_for *args
      calculate_sum(args) do |price, vat|
        price / (1 + vat / 100.0)
      end
    end

    def sum_with_vat_for *args
      calculate_sum(args) do |price, _|
        price
      end
    end

    def calculate_sum args
      options = args.extract_options!
      with_amount = options[:with_amount].nil? ? self.class.fields_for_calculations[:with_amount] : options[:with_amount]
      price_type = args.first

      price, vat = fields_values price_type, :vat
      sum = yield price, vat

      amount = field_value :amount
      with_amount ? sum * amount : sum
    end

    def fields_values *fields
      fields.map{ |field_name| field_value field_name}
    end

    def field_value field
      field_name = self.class.fields_for_calculations[field.to_sym]
      send field_name
    end

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def vat_calculations fields={}
        default_params = {:vat => :vat, :amount => :amount, :selling_price => :selling_price, :supplier_price => :supplier_price, :with_amount => true}
        @fields_for_calculations = default_params.merge fields
      end

      def fields_for_calculations
        @fields_for_calculations
      end
    end

  end
end

class ActiveRecord::Base
  def self.has_vat_calculator params={}
    include Vat::Calculator
    vat_calculations params
  end
end
