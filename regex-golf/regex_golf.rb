#!/usr/bin/env ruby

# regex_golf.rb

## Ruby application to test regular expression before entering into Regex Golf
## See <regex.alf.nu>

require_relative 'regex_golf_classes.rb'

w = WordGetter.new
w.welcome
w.get_page_url
w.confirm_match_words
w.check_match_list_complete
w.confirm_reject_words
w.check_reject_list_complete

s = StringMatcher.new(w.to_match, w.to_reject)
s.get_regex
p = RegexPrinter.new(s.regex_string)
puts p.remove_regex_delimiters