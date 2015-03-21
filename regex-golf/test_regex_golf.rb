# test_regex_golf.rb

require 'minitest/spec'
require 'minitest/autorun'
require 'regex_golf'

class TestRegexGolf < Minitest::Unit::TestCase # MiniTest v4
	# should inherit from Minitest::Test for MiniTest 5

	def setup
	end

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

	def final_regex_is_string
	end

	def final_regex_has_no_forward_slashes
	end

end
