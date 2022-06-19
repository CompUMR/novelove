class Item < ApplicationRecord
  # ActiveStrageを用いて画像(image)、txtファイル(upload_file)を投稿出来るよう設定。
  has_one_attached :image
  has_one_attached :upload_file
  belongs_to :customer
  belongs_to :genre
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # 独自バリデーション定義
  validate :file_text_length

  # 通常バリデーション定義
  validates :name, presence: true, length: { maximum: 100 }
  validates :introduction, presence: true, length: { maximum: 20000 }
  validates :is_active, inclusion: [true, false]

  def favorited_by?(user)
    favorites.exists?(customer_id: user.id)
  end

  def get_image(w, h)
    image.variant(resize_to_limit: [w, h]).processed
  end

  def status_color(active)
    active ? "text-success" : "text-muted"
  end

  def status
    get_status_string(is_active)
  end

  def get_status_string(active)
    active ? "公開中" : "非公開中"
  end

  private
  # 独自バリデーションメソッドの定義
  def file_text_length
    if self.attachment_changes['upload_file'].nil?
      return errors.add(:upload_file, message: "ファイルを選択して下さい")
    end
    # upload_fileの中身を、ActivestrageのDBに保存前にバイナリ(ASCIIコード)で取得。
    body = self.attachment_changes['upload_file'].attachable.read
    # UTF_8へ変換後、文字列長をlengthメソッドで取得。
    text_length = body.force_encoding(Encoding::UTF_8).length
    if (text_length < 200) || (70000 < text_length)
      errors.add(:upload_file, message: "txtファイルは200文字以上、70000文字以下のものを投稿して下さい")
    end
  end

end
