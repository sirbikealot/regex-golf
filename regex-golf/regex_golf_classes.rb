# regex_golf_classes.rb

## classes required for regex_golf.rb to run

require 'uri'
require 'open-uri'
require 'net/http'
require 'openssl'
require 'json'

WELCOME = <<-TEXT 
Hello, and thank you for using my regex_golf tool.
If you've played Regex Golf <regex.golf.au> you've probably found yourself
testing different Regexps in a REPL.  You have to type in all the "to match"
and "to reject" words.  This tool does that work for you.  

After verifying the words to match and words to reject, you can try 
different Regexps.  This tool will tell you when you've successfully
matched all "match" words without matching any of the "reject" words.

I know it's a real pain to come up with a clever, short Regexp, only to
discover that the Regex Golf site doesn't want the delimiters and you lose
points right off the bat. This tool will remove the '/' delimiters from your
Regexp before you copy and paste it into the Regex Golf web site.  

Let's get started.

Enter the web address of the Regex Golf page you're working on."
  such as https://regex.alf.nu/2"
Make sure you use enter the full address, including the protocol,"
  such as [https://]
TEXT

CHECKWORDS = <<-TEXT
The web page has been downloaded and the words to match and words to reject are saved.
Some levels in the Regex Golf have VERY long lists of strings to match or reject.

Do you want to check either of these lists? [Y/n] 
TEXT

GETWORDS = <<-TEXT 
Now you're going to identify any incorrect (or misspelled) words.
In this step the program will remove the incorrect words. In the step that follows
  you will have the opportunity to insert the correct word(s).
Type the misspelled words here. Hit ENTER after each word.
Press ENTER twice in a row when you are done.
TEXT

CHECKLIST = <<-TEXT
This is your current list. Are any incorrect or misspelled words?
  Don't worry yet if the list is missing a word --
    We'll get to that later. 
Are there any misspelled words? [Y/n] 
TEXT

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
    uri = URI.parse(URI.encode(url.strip))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response.body
  end

  # 4) Retrieve Match and Reject word lists from web page and create arrays for each

  def get_match_from_html(url = @url)
    @words_from_html = JSON.parse(get_html_string(url).scan(%r{.+({.+name.+mult.+})})[0][0][0...-1])["json"][1...-1]
    @to_match = @words_from_html.scan(%r{\A\[(.+)\],\[})[0][0][1...-1].split('","')
  end

  def get_reject_from_html(url = @url)
    @words_from_html = JSON.parse(get_html_string(url).scan(%r{.+({.+name.+mult.+})})[0][0][0...-1])["json"][1...-1]
    @to_reject = @words_from_html.scan(%r{\],\[(.+)\]\z})[0][0][1...-1].split('","')
  end

  # 5) Present list of match(reject) words to user for confirmation (if desired)

  def confirm_match_words
    print "\n", CHECKWORDS
    @confirm = gets.chomp.downcase
    if @confirm == "n"
      get_match_from_html(url = @url)
    else
      get_match_from_html(url = @url).each {|w| puts w }
      print "This is your list of words to match. Please compare it to the web page\nAre they all correct?[Y/n]"
      correct = gets.chomp.downcase
      if correct =~ /n/
        check_match_list_for_errors
      end
    end
  end

  def confirm_reject_words
    if @confirm == "n"
      get_reject_from_html(url = @url)
    else
      get_reject_from_html(url = @url).each {|w| puts w }
      print "This is your list of words to reject. Please compare it to the web page\nAre they all correct?[Y/n]"
      correct = gets.chomp.downcase
      if correct =~ /n/
        check_reject_list_for_errors
      end
    end
  end

  # 6) Identify misspellings of match(reject) words and add missing words (if applicable)

  def check_match_list_for_errors
    print "\n", CHECKLIST
    spelled_correct = gets.chomp.downcase
    if spelled_correct !~ /n/
      print GETWORDS
      misspelled = gets("\n\n").chomp.split
      misspelled.each do |m|
        @to_match.delete(m)
      end
      @to_match.each {|w| puts w }
      check_match_list_for_errors
    end

  end

  def check_reject_list_for_errors
    print "\n", CHECKLIST
    spelled_correct = gets.chomp.downcase
    if spelled_correct !~ /n/
      print GETWORDS
      misspelled = gets("\n\n").chomp.split
      misspelled.each do |m|
        @to_reject.delete(m)
      end
      @to_reject.each {|w| puts w }
      check_reject_list_for_errors
    end
  end

  def check_match_list_complete
    print "Is the list complete?[Y/n]"
    complete = gets.chomp.downcase
    if complete !~ /y/
      puts "Add the missing words here.\nPress ENTER twice in a row when you are done:"
      words_to_add = gets("\n\n").chomp.split
      @to_match += words_to_add
      print_word_list(@to_match, "match")
      check_match_list_complete
    end
  end

  def check_reject_list_complete
    print "Is the list complete?[Y/n]"
    complete = gets.chomp.downcase
    if complete !~ /y/
      puts "Add the missing words here.\nPress ENTER twice in a row when you are done:"
      words_to_add = gets("\n\n").chomp.split
      @to_reject += words_to_add
      print_word_list(@to_reject, "reject")
      check_reject_list_complete
    end
  end

  def print_word_list(words = @to_match, match_reject = "match")
    puts "This is your list of words to #{match_reject}. Please check it:"
    words.sort.each {|w| puts w}
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
    @regex_string = gets.chomp
    @regex = Regexp.new(@regex_string)
    match_words?
    if match_words?
      puts "Hooray! Now copy your regex and paste into the web site input field:"
    else
      puts "That regular expression doesn't work.  Try another one."
      get_regex
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