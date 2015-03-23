# test_regex_golf.rb

require './regex_golf'
require 'minitest/spec' # for BDD blocks like ['describe','it', 'let','before', 'after'] and methods ['must','wont']
require 'minitest/autorun'
require 'minitest/reporters' # for GREEN-RED display
Minitest::Reporters.use!


class TestRegexGolf < Minitest::Test

	def setup
		@to_match = ["abac", "accede", "adead", "babe", "bead",
								"bebed", "bedad", "bedded", "bedead", "bedeaf",
								"caba", "caffa", "dace", "dade", "daff", "dead", 
								"deed", "deface", "faded", "faff", "feed"]
		@to_reject = ["beam", "buoy", "canjac", "chymia", "corah", 
								"cupula", "griece", "hafter", "idic", "lucy",
								"martyr", "matron", "messrs", "mucose", "relose", 
								"sonly", "tegua", "threap", "towned", "widish", "yite"]
		
		@all_words = 						@to_reject + @to_match
	
		
		#@to_match_with_typo = 	(@ to_match[0..-2] << "veed").join(' ')

		@regex_string = "[a-df][a-e][a-f]{2}\w?"
		@r = RegexPrinter.new(@regex_string)
		@m = 						StringMatcher.new(@to_match, @to_reject, @regex_string)
		#@m_with_typo = StringMatcher.new(@to_match_with_typo, @regex_string)
	end

	def test_regex_printer
		assert_equal "regex printed", @r.regex_printer
	end

	def test_match_words_method_passes_when_correct
		assert @m.match_words?
	end

	# def test_match_words_fails_when_match_word_list_has_typo
	# 	refute @m_with_typo.match_words?
	# end


	def test_final_result_is_string_no_delimiters
		assert_equal String, @r.remove_regex_delimiters.class
		assert_equal @regex_string, @r.remove_regex_delimiters
	end


end


=begin

	def test_words_to_match_populate_array
		assert_equal to_match.class, Array
		assert_equal to_match.count, to_match_input.split.count
	end

	def test_words_to_reject_populate_array
		assert_equal to_reject.class, Array
		assert_equal to_reject.count, to_reject_input.split.count
	end

	def test_prints_words_to_match_to_console
	end

	def test_prints_words_to_reject_to_console
	end

	def test_accept_regex_with_forward_slash_delimiters
	end

	def test_accept_regex_with_no_delimiters
	end

	def test_print_success_if_matches_all
	end

	def test_print_success_if_matches_no_to_reject_words
	end

	def test_print_fail_if_any_match_words_missing
	end

	def test_print_fail_if_matches_any_to_reject_words
	end

	def test_regex_matches_zero_reject_words
	end

	def test_regex_matches_all_accept_words
	end

=end
