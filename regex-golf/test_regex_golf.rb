# test_regex_golf.rb

require './regex_golf_classes.rb'
require 'minitest/spec' # for BDD blocks like ['describe','it', 'let','before', 'after'] and methods ['must','wont']
require 'minitest/autorun'
require 'minitest/reporters' # for GREEN-RED display
Minitest::Reporters.use!


class TestRegexGolf < Minitest::Test

  def setup
    @to_match = %q{
      abac accede adead babe bead bebed bedad bedded bedead bedeaf
      caba caffa dace dade daff dead deed deface faded faff feed
    }
    @to_reject = %q{
      beam buoy canjac chymia corah cupula griece hafter idic lucy
      martyr matron messrs mucose relose sonly tegua threap towned widish yite
    }
    
    @all_words = @to_reject + @to_match
  
    @regex_string = "[a-df][a-e][a-f]{2}\w?"
    @bad_regex_string = "/\w+/"
    @r = RegexPrinter.new(@regex_string)
    @m =            StringMatcher.new(@to_match, @to_reject, @regex_string)
  end

  def test_match_words_method_passes_when_correct
    assert @m.match_words?
  end

  def test_match_words_fails_with_bad_regex
    @m_bad = StringMatcher.new(@to_match, @to_reject, @bad_regex_string)
    refute @m_bad.match_words?
  end


  def test_final_result_is_string_no_delimiters
    assert_equal String, @r.remove_regex_delimiters.class
    assert_equal @regex_string, @r.remove_regex_delimiters
  end


end
