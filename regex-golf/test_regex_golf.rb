# test_regex_golf.rb

require_relative 'regex_golf_classes.rb'
require 'minitest/autorun'
require 'minitest/reporters' # for GREEN-RED display
Minitest::Reporters.use!

class TestRegexGolf < Minitest::Test

  def setup

    @test_match = %q{abac accede adead babe bead bebed bedad bedded bedead bedeaf caba caffa dace dade daff dead deed deface faded faff feed}
    @test_reject = %q{beam buoy canjac chymia corah cupula griece hafter idic lucy martyr matron messrs mucose relose sonly tegua threap towned widish yite}
      
    @url = 'https://regex.alf.nu/2'
    @url_wrong = 'https://regex.alf.nu/3'

    @regex_string = "[a-df][a-e][a-f]{2}\w?"
    @bad_regex_string = "/\w+/"

    @w = WordGetter.new
    @r = RegexPrinter.new(@regex_string)

  end

  def test_final_result_is_string_no_delimiters
    assert_equal String, @r.remove_regex_delimiters.class
    assert_equal @regex_string, @r.remove_regex_delimiters
  end

  def test_creates_instance_of_wordgetter_class
    assert_equal WordGetter, @w.class
  end

  def test_gets_string_from_webpage
    assert_equal String, @w.get_html_string(@url).class
  end

  def test_gets_match_word_list_from_webpage
    assert_equal @test_match, @w.get_match_from_html(@url).join(" ")
  end

  def test_gets_reject_word_list_from_webpage
    assert_equal @test_reject, @w.get_reject_from_html(@url).join(" ")
  end

  def test_fails_on_page_mismatch
    refute_equal @test_match, @w.get_match_from_html(@url_wrong).join(" ")
  end

  def test_match_words_method_with_correct_web_address
    @w.get_match_from_html(@url)
    @w.get_reject_from_html(@url)
    @s = StringMatcher.new(@w.to_match, @w.to_reject, @regex_string)
    assert @s.match_words?
  end

  def test_match_words_method_with_correct_web_address_bad_regex
    @w_bad = WordGetter.new
    @w_bad.get_match_from_html(@url)
    @w_bad.get_reject_from_html(@url)
    @s_bad = StringMatcher.new(@w_bad.to_match, @w_bad.to_reject, @bad_regex_string)
    refute @s_bad.match_words?
  end

end
