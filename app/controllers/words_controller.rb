get '/words' do
  @word = Word.all
  erb :"words/index"
end

get '/words/new' do
  @word = Word.new
  erb :"/words/new"
end

get '/words/:id' do
  @word=Word.find(params[:id])
  erb :"words/show"
end

post '/words' do
  word = Word.create(text: params[:text])
  redirect "/words/#{word.id}"
end