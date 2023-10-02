class TagsearchesController < ApplicationController
  def search
    @model = Book #search機能とは関係なし
    @word = params[:content]
    #テーブル内の条件に一致したレコードを配列の形で取得することができるメソッド。
    @books = Book.where("category LIKE?","%#{@word}%")
    render "tagsearches/search"
  end
end
