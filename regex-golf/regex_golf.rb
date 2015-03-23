#!/usr/bin/env ruby

## Ruby application to test regular expression before entering into Regex Golf
## See <regex.alf.nu>

words_to_match = String.new
words_to_reject = String.new
#to_match = words_to_match.split
#to_reject = words_to_reject.split
#all_words = to_match + to_reject


class StringMatcher

	# attr_accessor :all_words, :regex

	def initialize(to_match, to_reject, regex_string = String.new)
		@to_match = to_match
		@to_reject = to_reject
		@all_words = to_match + to_reject
		# @regex_string = regex_string
		@regex = Regexp.new(regex_string)
	end

	def match_words?
		@all_words.map do |word|
			word.match(@regex).string unless word.match(@regex).nil?
		end.compact == @to_match
	end

end

class RegexPrinter

	def initialize(regex_string)
		@regex = Regexp.new(regex_string)
	end

	def regex_printer
		"regex printed"
	end

	def remove_regex_delimiters # Regex Golf site requires delimiter removal
		@regex.inspect[1...-1]
	end

end

