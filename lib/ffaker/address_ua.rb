# encoding: utf-8

require 'ffaker/address'

module FFaker
  module AddressUA
    extend ModuleUtils
    extend self

    POSTAL_CODE_FORMAT        = ['#####']
    BUILDING_NUMBER_FORMATS   = %w(## # ###)
    APPARTMENT_NUMBER_FORMATS = %w(# ## ###)

    def country
      COUNTRY.sample
    end

    def city(with_identifier = false)
      identifier = if with_identifier then "м." else "" end
      "#{identifier} #{CITY.sample}"
    end

    def village(with_identifier = false)
      identifier = if with_identifier then "с." else "" end
      "#{identifier} #{VILLAGE.sample}"
    end

    def province(with_special_regions = true)
      if with_special_regions
        (PROVINCE + SPECIAL_REGION + AUTONOMOUS_REPUBLIC).sample
      else
        PROVINCE.sample
      end
    end

    def zip_code
      numerify_mask(POSTAL_CODE_FORMAT, true)
    end

    def street_name
      "вул. #{STREET.sample}"
    end

    def square_name
      "пл. #{SQUARE.sample}"
    end

    def avenue_name
      "пр. #{AVENUE.sample}"
    end

    def street_address(include_secondary = false)
      str = "#{street_name}, #{building_number}"
      str << ", кв. #{appartment_number}" if include_secondary
      str
    end

    def building_number
      numerify_mask(BUILDING_NUMBER_FORMATS)
    end

    def appartment_number
      numerify_mask(APPARTMENT_NUMBER_FORMATS)
    end

    def full_address(settlement_type = :city)
      case settlement_type
      when :city
        "Україна, #{zip_code}, #{city(true)}, #{street_address(true)}"
      when :village
        "Україна, #{zip_code}, #{province(false)}, #{village(true)}, #{street_address}"
      end
    end

    def envelope_address(devider = "</br>")
      "#{FFaker::NameUA.last_name_male} #{FFaker::NameUA.first_name_male} #{FFaker::NameUA.middle_name_male}" + devider +
      "#{street_address(true)}" + devider +
      "#{city(true)}" + devider +
      "#{province}" + devider +
      "#{zip_code}"
    end

    private

    def numerify_mask(masks_arr, allow_first_zero = false)
      if allow_first_zero
        FFaker.numerify(masks_arr)
      else
        masks_arr.sample.sub(/#/) { (rand(9)+1).to_s }.gsub(/#/) { rand(10).to_s }
      end
    end
  end
end
