require 'test_helper'

class NumberHelperTest < ActionView::TestCase

  def test_number_helpers_outputs_are_html_safe
    assert number_to_human_size(1).html_safe?
    assert number_to_human_size(1000000).html_safe?
    assert !number_to_human_size("<script></script>").html_safe?
    assert number_to_human_size("asdf".html_safe).html_safe?

    assert number_with_precision(1, :strip_insignificant_zeros => false).html_safe?
    assert number_with_precision(1, :strip_insignificant_zeros => true).html_safe?
    assert !number_with_precision("<script></script>").html_safe?
    assert number_with_precision("asdf".html_safe).html_safe?

    assert number_to_currency(1).html_safe?
    assert !number_to_currency("<script></script>").html_safe?
    assert number_to_currency("asdf".html_safe).html_safe?

    assert number_to_percentage(1).html_safe?
    assert !number_to_percentage("<script></script>").html_safe?
    assert number_to_percentage("asdf".html_safe).html_safe?

    assert number_to_phone(1).html_safe?
    assert !number_to_phone("<script></script>").html_safe?
    assert number_to_phone("asdf".html_safe).html_safe?

    assert number_with_delimiter(1).html_safe?
    assert !number_with_delimiter("<script></script>").html_safe?
    assert number_with_delimiter("asdf".html_safe).html_safe?
  end
end
