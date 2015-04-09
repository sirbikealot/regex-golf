#!/usr/bin/env ruby
# regex_golf.rb

## Ruby application to test regular expression before entering into Regex Golf
## See <regex.alf.nu>

## copy to /usr/local/bin so it's in $PATH?

require_relative 'regex_golf_classes.rb'

#words_to_match = String.new
#words_to_reject = String.new
#to_match = words_to_match.split
#to_reject = words_to_reject.split
#all_words = to_match + to_reject

w = WordGetter.new
w.get_match_words
w.get_reject_words
s = StringMatcher.new(w.to_match, w.to_reject)
s.get_regex
p = RegexPrinter.new(s.regex_string)
puts p.remove_regex_delimiters