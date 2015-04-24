## password-gen

###An interactive tool for lovers of Regex Golf

 -Ever played [Regex Golf](https://regex.alf.nu)? You are presented two lists of words, and you have to create a regular expression (Regexp) that matches all the words on the left-hand list ('good' words) while rejecting all the words on the right-hand list ('bad' words).

 -You score points for every 'good' word your regular expression matches, but you lose points for every 'bad' word your regular expression matches.  Furthermore, you lose a point for every character in your regular expression, which qualifies the game as a sort of Code Golf), so if you want to conserve your points you have to open a REPL and type in all the words before you start hacking out different Regexps in your favorite coding language.  This console tool, written entirely in Ruby, lets you try different regular expressions to match/reject word lists before entering your final solution into the [Regex Golf](https://regex.alf.nu) web site.

 -After you clone this repo, run `ruby regex_golf.rb` from the CLI and follow the instructions.


**16 April 2015**
 - Added feature to regex-golf to import word lists from the [Regex Golf](https://regex.alf.nu) web site so you don't have to type any of them!
