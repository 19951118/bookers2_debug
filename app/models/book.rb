class Book < ApplicationRecord
  has_many :book_comments, dependent: :destroy
  has_many :favorites,dependent: :destroy
  belongs_to :user
  
  validates :title, presence:true
  validates :body, presence:true,length:{maximum:200}
  validates :category, presence:true
  
  #indexの並び順を変更する。descが昇順、escが降順。
  scope :latest, -> {order(created_at: :desc)} #最新-データ取り出し-作成日時
  scope :old, -> {order(created_at: :asc)} #最古-データ取り出し-作成日時
  scope :star_count, -> {order(star: :desc)} #星の多さ-データ取り出し-starカラム
  
  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%' + content)
    else
      Book.where('title LIKE ?', '%' + content + '%')
    end
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
