# frozen_string_literal: true

require "test_helper"

class TestTag < Minitest::Test
  def test_form_for
    expected_form = File.read("./test/hexlet_code/fixtures/form.html")
    struct_user = Struct.new(:name, :job, :gender, keyword_init: true)
    user = struct_user.new name: "rob", job: "developer", gender: "Male"
    form = HexletCode.form_for user do |f|
      f.input :name, class: "hexlet"
      f.input :job, as: :text
      f.submit "Wow"
    end
    assert_equal expected_form, form
  end

  def test_single_quotes_tag
    assert_equal "<br>", HexletCode::Tag.build("br").chomp
  end

  def test_double_quotes_tag
    assert_equal "<div></div>", HexletCode::Tag.build("div").chomp
  end

  def test_tag_with_tezt
    assert_equal "<div>Tag with text</div>", HexletCode::Tag.build("div") { "Tag with text" }.chomp
  end

  def test_tag_with_attributes
    assert_equal "<div data=\"id-123-qwe\" class=\"hexlet_code-tag\"></div>",
                 HexletCode::Tag.build("div", data: "id-123-qwe",
                                              class: "hexlet_code-tag").chomp
  end

  def test_tag_with_attributes_and_text
    assert_equal "<div data=\"id-123-qwe\" class=\"hexlet_code-tag\">With text</div>",
                 HexletCode::Tag.build("div", data: "id-123-qwe",
                                              class: "hexlet_code-tag") { "With text" }.chomp
  end
end