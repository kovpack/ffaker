# encoding: utf-8

require 'helper'

class TestAddressUA < Test::Unit::TestCase

  def setup
    @tester = FFaker::AddressUA
    @multiple_words_name_regexp = /\A[а-яА-ЯіїєґІЇЄҐ’\-\s]+\z/
  end

  def test_country
    assert_match @multiple_words_name_regexp, @tester.country
  end

  def test_city
    assert_match @multiple_words_name_regexp, @tester.city
  end

  def test_city_with_identifier
    assert_match /\Aм\.\s[а-яА-ЯіїєґІЇЄҐ’\-\s]+\z/, @tester.city(true)
  end

  def test_village
    assert_match @multiple_words_name_regexp, @tester.village
  end

  def test_village_with_identifier
    assert_match /\Aс\.\s[а-яА-ЯіїєґІЇЄҐ’\-\s]+\z/, @tester.village(true)
  end

  def test_province
    assert_match /\A[а-яА-ЯіїєґІЇЄҐ’\-\s\.]+\z/, @tester.province
  end

  def test_zip_code
    assert_match /\A\d{5}\z/, @tester.zip_code
  end

  def test_street_name
    assert_match /\Aвул\.\s[а-яА-ЯіїєґІЇЄҐ’\-\s]+\z/, @tester.street_name
  end

  def test_square_name
    assert_match /\Aпл\.\s[а-яА-ЯіїєґІЇЄҐ’\-\s]+\z/, @tester.square_name
  end

  def test_street_address
    assert_match /\Aвул\.\s[а-яА-ЯіїєґІЇЄҐ’\-\s]+,\s\d{1,3}\z/, @tester.street_address
  end

  def test_street_address_with_secondary
    assert_match \
      /\Aвул\.\s[а-яА-ЯіїєґІЇЄҐ’\-\s]+,\s\d{1,3},\sкв\.\s\d{1,3}\z/,
      @tester.street_address(true)
  end

  def test_building_number
    assert_match /\A\d{1,3}\z/, @tester.building_number
  end

  def test_appartment_number
    assert_match /\A\d{1,3}\z/, @tester.appartment_number
  end

  def test_full_address_city_type
    assert_match /\AУкраїна,\s\d{5},\sм\.\s[а-яА-ЯіїєґІЇЄҐ’\-\s]+,\s
      вул\.\s[а-яА-ЯіїєґІЇЄҐ’\-\s]+,\s\d{1,3},\sкв\.\s\d{1,3}
      \z/x, @tester.full_address(:city)
  end

  def test_full_address_village_type
    assert_match /\AУкраїна,\s\d{5},\s[а-яА-ЯіїєґІЇЄҐ’\-\s]+\sобл\.,\s
      с\.\s[а-яА-ЯіїєґІЇЄҐ’\-\s]+,\sвул\.\s[а-яА-ЯіїєґІЇЄҐ’\-\s]+,\s\d{1,3}
      \z/x, @tester.full_address(:village)
  end

  def test_envelope_address
    assert_match /\A[а-яА-ЯіїєґІЇЄҐ’\-\s]+\<\/br\>
      вул\.\s[а-яА-ЯіїєґІЇЄҐ’\-\s]+,\s\d{1,3},\sкв\.\s\d{1,3}\<\/br\>
      м\.\s[а-яА-ЯіїєґІЇЄҐ’\-\s]+\<\/br\>
      [а-яА-ЯіїєґІЇЄҐ’\-\s]+обл\.\<\/br\>
      \d{5}\z/x, @tester.envelope_address
  end
end
