# regex_golf_classes.rb

require_relative 'regex_golf_data.rb'

require 'json'

class WordGetter

  attr_accessor :to_match, :to_reject

  # 1) Introduce program

  def welcome
    print WELCOME, "\n"
  end

  # 2) Get Regex Golf web page url from user

  def get_page_url
    @url = gets.chomp
  end

  #3) Retrieve text of entire web page

  def get_html_string(url = @url)
    response = `curl #{url}`
  end

  # 4) Retrieve Match and Reject word lists from web page and create arrays for each

  def get_allwords_from_html(url = @url)
    JSON.parse(get_html_string(url).scan(%r{.+({.+name.+mult.+})})[0][0][0...-1])["json"][1...-1]
  end

  def get_match_from_html(url = @url)
    @to_match = get_allwords_from_html(url).scan(%r{\A\[(.+)\],\[})[0][0][1...-1].split('","')
  end

  def get_reject_from_html(url = @url)
    @to_reject = get_allwords_from_html(url).scan(%r{\],\[(.+)\]\z})[0][0][1...-1].split('","')
  end

  # 5) Present list of match(reject) words to user for confirmation (if desired)

  def confirm_match_words
    print "\n", CHECKWORDS
    @confirm = gets.chomp.downcase
    print "\n"
    get_match_from_html(url = @url)
    unless @confirm =~ /n/
      print_word_list(@to_match, "match")
      correct = gets.chomp.downcase
      if correct =~ /n/
        check_match_list_for_errors
      end
    end
  end

  def confirm_reject_words
    print "\n"
    get_reject_from_html(url = @url)
    unless @confirm =~ /n/
      print_word_list(@to_reject, "reject")
      correct = gets.chomp.downcase
      if correct =~ /n/
        check_reject_list_for_errors
      end
    end
  end

  # 6) Identify misspellings of match(reject) words and add missing words (if applicable)

  def check_match_list_for_errors
    check_list(@to_match)
    if @spelled_correct !~ /n/
      print GETWORDS
      misspelled = gets("\n\n").chomp.split
      misspelled.each do |m|
        @to_match.delete(m)
      end
      check_match_list_for_errors
      check_match_list_complete
    end

  end

  def check_reject_list_for_errors
    check_list(@to_reject)
    if @spelled_correct !~ /n/
      print GETWORDS
      misspelled = gets("\n\n").chomp.split
      misspelled.each do |m|
        @to_reject.delete(m)
      end
      check_reject_list_for_errors
      check_reject_list_complete
    end
  end

  def check_match_list_complete
    print_word_list(@to_match, "match")
    complete = gets.chomp.downcase
    if complete !~ /y/
      get_missing_words
      @to_match += @words_to_add
      check_match_list_complete
    end
  end

  def check_reject_list_complete
    print_word_list(@to_reject, "reject")
    complete = gets.chomp.downcase
    if complete !~ /y/
      get_missing_words
      @to_reject += @words_to_add
      check_reject_list_complete
    end
  end

  private

    def check_list(list)
      print "\n"
      list.each_with_index {|w,i| puts "#{i+1}: #{w}" }
      print "\n", CHECKLIST
      @spelled_correct = gets.chomp.downcase
    end

    def get_missing_words
      puts "Add the missing words here.\nPress ENTER twice in a row when you are done:"
      @words_to_add = gets("\n\n").chomp.split
    end

    def print_word_list(words = @to_match, match_reject = "match")
      words.sort.each_with_index {|w,i| puts "#{i+1}: #{w}" }
      puts "This is your list of words to #{match_reject}. Please compare it to the web page."
      puts "Is the list complete, with all words correct?[Y/n]"
    end

end

#7) Prompt user to try Regexps and test against match(reject) word lists

class StringMatcher

  attr_accessor :regex_string

  def initialize(to_match, to_reject, regex_string = String.new)
    @to_match = to_match
    @to_reject = to_reject
    @all_words = @to_match + @to_reject
    @regex_string = regex_string # default empty string for tests
    @regex = Regexp.new(@regex_string) 
    puts "Now try a regular expression."
    puts "Don't prepend or append it with any delimiters ('/')."
  end

  def get_regex
    begin
      @regex_string = gets.chomp
      @regex = Regexp.new(@regex_string)
    rescue StandardError=>e
      puts e
      retry
    else
      match_words?
      if match_words?
        puts "Hooray! Now copy your regex and paste into the web site input field:"
      else
        puts "That regular expression doesn't work.  Try another one."
        get_regex
      end
    end
  end

  def match_words?
    @all_words.map do |word|
      word.match(@regex).string unless word.match(@regex).nil?
    end.compact == @to_match
  end

end

# 8) Print final Regexp without delimiters

class RegexPrinter

  def initialize(regex_string)
    @regex = Regexp.new(regex_string)
  end

  def remove_regex_delimiters # Regex Golf web site requires delimiter removal
    @regex.inspect[1...-1]
  end

end