class Word < ActiveRecord::Base
before_create :add_letters

def add_letters
  characters = self.text.chars
  alphabetized_characters = characters.sort
  self.letters = alphabetized_characters.join
end

def self.find_anagram(word)
# Converts string to array of letters
  letters = word.split(//)

  # Creates array to store anagrams of word
  possible_combos = []

  # Loops through array of letters, letter-by-letter
  letters.each do |letter|
    # Selects the remaining characters
    remaining = letters.select { |l| l != letter}

    # Creates an anagram by combining the letter and the remaining characters, then adds to array of possible anagrams
    possible_combos << letter + remaining.join('')

   # Creates a new anagram by combining the letter and the reverse of the remaining characters, then adds to array of possible combos
    possible_combos << letter + reverse_letters(remaining).join('')
end
 
  # Checks array of possible combinations against app dictionary of words, then adds only combos that are actually words to final anagram array
  anagram_array = []
  possible_combos.each do |combo|
    if Word.find_by_text(combo).present?
	anagram_array << combo
    end
  end

  # Returns anagram array
  anagram_array

end

def self.reverse_letters(arr)
  # Creates new array of same length as original array
  length = arr.length
  reversed_arr = Array.new(length)


  # Loops through original array and adds to new array, keeping index 
  arr.each_with_index do |letter, idx|
    reversed_arr[length - idx -1 ] = letter 
  end

reversed_arr

end
end