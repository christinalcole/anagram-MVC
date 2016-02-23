def three_letters?(input)
  if (input.length<=3)
   return true
  else
   return false
  end
end

def distinct_letters?(input)
  letter_array = input.chars
  unique_letters = letter_array.uniq
  if (unique_letters.length == letter_array.length)
    return true
  else
    return false
  end
end

def valid_input?(input)
  if three_letters?(input) && distinct_letters?(input)
    return true
  else
    return false
  end
end


get '/' do
  erb :index
end

post '/' do
  word = params[:word]
  if valid_input?(word)
    redirect "/anagrams/#{word}"
  else 
    @error = "Oh no!  Try again--but this time, stick to 3-letter words with no repeating letters."
    erb :index
  end
end

get '/anagrams/:word' do
  @word = params[:word]
  alphabetized_string = @word.chars.sort.join
  @anagrams = Word.where("letters=?", alphabetized_string)
#  @anagrams = Word.find_anagram(@word)
  erb :show
end
