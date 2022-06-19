class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :last_name, presence: true
  validates :last_name_kana, presence: true

  # 引数ごとにstatus_color情報を取得。
  def get_status_color(active)
    active ? "text-success" : "text-muted"
  end

  # 退会ステータス情報を取得。
  def status
    get_status_string(is_active)
  end

  # 引数ごとに退会ステータスの文字列情報を取得。
  def get_status_string(active)
    active ? "有効" : "退会"
  end

end
