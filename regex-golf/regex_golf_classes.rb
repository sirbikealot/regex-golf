# regex_golf_classes.rb

# classes required for regex_golf.rb to run


GETWORDS = <<-TEXT 
Press ENTER after each word.
Press ENTER twice in a row when you are finished.
TEXT

CHECKLIST = <<-TEXT
Check this list. Are they any misspelled words?
  Don't worry yet if the list is missing a word --
    We'll get to that later.
Are there any misspelled words? [Y/n] 
TEXT

class WordGetter

  attr_accessor :to_match, :to_reject
  
  # def initialize
  # end

  def get_match_words
    puts "Enter your list of words to match."
    print GETWORDS
    @to_match = gets("\n\n").chomp
    print_word_list(@to_match, "match")
    check_list_complete(@to_match)
  end

  def check_list_for_errors(words = to_match)
    print CHECKLIST
    complete = gets.chomp.downcase
    while complete != "n"
      puts "Type the misspelled words here:"
      misspelled = gets("\n\n").chomp
      misspelled.each do |m|
        words = words.split.delete(m).join('\n') # May not update list if words doesn't point to correct list
      end
      check_list_for_errors(words) # May not update list if words doesn't point to correct list
    end
  
  end


  def get_reject_words
    puts "Enter your list of words to reject."
    print GETWORDS
    @to_reject = gets("\n\n").chomp
    print_word_list(@to_reject, "reject")
    check_list_complete(@to_reject)
  end

  def print_word_list(words = @to_match, match_reject = "match")
    puts "This is your list of words to #{match_reject}. Please check it:"
    words.split.sort.each {|w| puts w}
  end

  def check_list_complete(words = to_match)
    puts "Is the list complete? (Y for Yes, any other key for No)"
    complete = gets.chomp.downcase
    while complete != "y"
      puts "Add the missing words here:"
      @to_match += gets("\n\n").chomp
      print_word_list(@to_match, "match")
      puts "Is the list complete? (Y for Yes, N for No)"
      complete = gets.chomp.downcase
    end
  end

end


## Add script that asks for regex

class StringMatcher

  attr_accessor :all_words , :regex , :regex_string

  def initialize(to_match, to_reject, regex_string = String.new)
    @to_match = to_match.split
    @to_reject = to_reject.split
    @all_words = @to_match + @to_reject
    @regex_string = regex_string
    @regex = Regexp.new(@regex_string) # default empty string for rake tests
    puts "Now try a regular expression."
    puts "Don't prepend or append with delimiters ('/')."
  end

  def get_regex
    @regex_string = gets.chomp
    @regex = Regexp.new(@regex_string)
    match_words?
    if match_words?
      puts "Hooray! Now copy your regex and paste in the web site input field."
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

class RegexPrinter

  def initialize(regex_string)
    @regex = Regexp.new(regex_string)
  end

  def remove_regex_delimiters # Regex Golf site requires delimiter removal
    @regex.inspect[1...-1]
  end

end


