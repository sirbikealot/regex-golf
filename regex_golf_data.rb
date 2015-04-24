# regex_golf_data.rb

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
This is your current list. Are any words incorrect or misspelled?
  Don't worry yet if the list is missing a word --
    We'll get to that later. 
Are there any misspelled words? [Y/n] 
TEXT