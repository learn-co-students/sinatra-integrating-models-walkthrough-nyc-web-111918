require_relative 'config/environment'
require_relative 'models/text_analyzer.rb'
require 'pry'

class App < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/' do
    @text_from_user = params[:user_text]
    @word_count=@text_from_user.split(" ").count
    @vowel_count=0
    @consenant_count=0
    @letter_hash={}
    @text_from_user.split("").each do |letter|
      if letter.downcase=='a' || letter.downcase=='e' || letter.downcase=='i' || letter.downcase=='o' || letter.downcase=='u'
        @vowel_count+=1
      else
        if letter!=" "
          @consenant_count+=1
        end
      end
      if letter!=" "
        if @letter_hash.include?(letter.downcase)
          @letter_hash[letter.downcase]+=1
        else
          @letter_hash[letter.downcase]=1
        end
      end
    end
    @most_common_letter=@letter_hash.sort_by{|key, value| value}.reverse[0][0].upcase
    @most_common_letter_count=@letter_hash.sort_by{|key, value| value}.reverse[0][1]

    erb :results
  end
end
