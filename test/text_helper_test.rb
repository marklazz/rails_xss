require 'test_helper'

class TextHelperTest < ActionView::TestCase

  def setup
    @controller = Class.new do
      attr_accessor :request
      def url_for(*args) "http://www.example.com" end
    end.new
  end

  def test_simple_format_with_escaping_html_options
    assert_dom_equal(%(<p class="intro">It's nice to have options.</p>),
                     simple_format("It's nice to have options.", :class=>"intro"))
  end

  def test_simple_format_should_not_escape_safe_content
    assert_dom_equal(%(<p>This is <script>safe_js</script>.</p>),
                     simple_format('This is <script>safe_js</script>.'.html_safe))
  end

  def test_simple_format_escapes_unsafe_content
    assert_dom_equal(%(<p>This is &lt;script&gt;evil_js&lt;/script&gt;.</p>),
                     simple_format('This is <script>evil_js</script>.'))
  end

  def test_truncate_should_not_be_html_safe
    assert !truncate("Hello World!", :length => 12).html_safe?
  end

  def test_highlight_should_be_html_safe
    assert highlight("This is a beautiful morning", "beautiful").html_safe?
  end

  def test_highlight_should_not_escape_safe_content
    assert_dom_equal(%(This is <script><strong class=\"highlight\">safe_js</strong></script>),
                     highlight('This is <script>safe_js</script>'.html_safe,  'safe_js'))
  end

  def test_highlight_should_escape_unsafe_content
    assert_dom_equal(%(This is &lt;script&gt;<strong class=\"highlight\">evil_js</strong>&lt;/script&gt;),
                     highlight('This is <script>evil_js</script>',  'evil_js'))
  end

  def test_excerpt_should_not_be_html_safe
    assert !excerpt('This is a beautiful! morning', 'beautiful', 5).html_safe?
  end

  def test_auto_link_should_be_html_safe
    email_raw    = 'santiago@wyeworks.com'
    link_raw     = 'http://www.rubyonrails.org'

    assert auto_link(nil).html_safe?
    assert auto_link('').html_safe?
    assert auto_link("#{link_raw} #{link_raw} #{link_raw}").html_safe?
    assert auto_link("hello #{email_raw}").html_safe?
  end

  def test_auto_link_should_not_escape_safe_text
    assert_dom_equal(%(test of <a href=\"mailto:marklazz.uy@gmail.com\">marklazz.uy@gmail.com</a> with <script>safe_js</script>),
                     auto_link('test of marklazz.uy@gmail.com with <script>safe_js</script>'.html_safe))
  end

  def test_auto_link_escapes_unsafe_text
    assert_dom_equal(%(test of <a href=\"mailto:marklazz.uy@gmail.com\">marklazz.uy@gmail.com</a> with &lt;script&gt;evil_js&lt;/script&gt;),
                     auto_link('test of marklazz.uy@gmail.com with <script>evil_js</script>'))
  end

  def test_auto_link_should_retrieve_html_safe
    text = 'test of marklazz.uy@gmail.com with <script>safe_js</script>'
    assert auto_link(text).html_safe?
  end
end
