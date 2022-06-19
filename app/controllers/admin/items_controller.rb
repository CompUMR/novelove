class Admin::ItemsController < ApplicationController
  # 読書ページ
  def reading
    @item = Item.find(params[:id])
    # 保存したテキストファイルを開いて読み込む。
    @item.upload_file.open do |f|
      @content = f.read()
      @content.force_encoding("UTF-8")
      # テキストをHTMLに変換。
      @content = @content.gsub(/\r\n/, "\n").gsub(/\r/, "\n").gsub(/\n/, "<br>")
    end
  end

  # 小説一覧画面の表示
  def index
    @title = "小説一覧"
    set_items(Item.all)
  end

  # 小説詳細画面
  def show
    @item = Item.find(params[:id])
  end

  # 小説編集画面
  def edit
    @item = Item.find(params[:id])
  end

  # 小説情報の更新
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      # itemsコントローラのshow.html.erbへ遷移。
      redirect_to admin_item_path(@item), notice: "小説情報を更新、保存しました。"
    else
      render :edit # 入力にエラーがあった場合は再度edit.html.erbを表示。
    end
  end

  def search
    word = params[:search_word]
    searched = Item.where("name like ?", "%#{word}%")
    @title = "検索結果: " + word
    set_items(searched)
    render :index
  end

  private
  # 引数で渡されたitems(小説)の数を@items_countに格納、10件ずつの小説情報を@itemsに格納。
  def set_items(source)
    @items_count = source.size
    @items = Kaminari.paginate_array(source).page(params[:page]).per(10)
  end

  def item_params
    params.require(:item).permit(:upload_file, :name, :introduction, :image, :is_active, :genre_id)
  end
end
