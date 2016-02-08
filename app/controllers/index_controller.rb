get '/' do
  erb :index
end

post '/' do
  @word = params[:word]
  redirect "/anagrams/#{@word}"
end

get '/anagrams/:word' do
  @word = params[:word]
  @anagrams = Word.find_anagram(@word)
  erb :show
end