class Public::ItemsController < ApplicationController

  # 小説一覧
  def index
    @title = "小説一覧"
    set_items(Item.all)
  end

  # 小説読書ページの表示
  def reading
    @item = Item.find(params[:id])
    # 保存したテキストファイルを開いて読み込む。
    @item.upload_file.open do |f|
      @content = f.read()
      # テキストをHTMLに変換。
      @content = @content.gsub(/\r\n/, "\n").gsub(/\r/, "\n").gsub(/\n/, "<br>")
    end
  end

  # 小説新規投稿画面の表示
  def new
    @item = Item.new
  end

  # 小説の新規投稿処理
  def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id
    # saveメソッドにif文を用いる事で、バリデーションの結果を検出。
    if @item.save
      # itemsコントローラのshowアクションを実行後、show.html.erb(小説詳細ページ)へ遷移。
      redirect_to item_path(@item), notice: "小説を投稿しました。"
    else
      render :new # 入力にエラーがあった場合は再度new.html.erbを表示。
    end
  end

  # 小説編集画面
  def edit
    @item = Item.find(params[:id])
  end

  # 小説情報の更新
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      # 入力内容にエラーがなければ、itemsコントローラのshow.html.erb(小説詳細ページ)へ遷移。
      redirect_to item_path(@item), notice: "小説情報を更新、保存しました。"
    else
      render :edit # 入力にエラーがあった場合は再度edit.html.erbを表示。
    end
  end

  def destroy
    item = Item.find(params[:id])  # データ（レコード）を1件取得。
    item.destroy  # データ（レコード）を削除
    # customersコントローラのpostedアクションを実行後、posted.html.erb(ユーザの投稿小説一覧画面)へ遷移。
    redirect_to customer_posted_path(current_customer.id), notice: "小説情報を削除しました。"
  end

  # 小説詳細
  def show
    @item = Item.find(params[:id])
    @post_comment = PostComment.new
  end

  # ジャンル選択時のメソッド
  def genre
    # 選択したジャンルの情報を格納。
    target = Genre.find(params[:id])
    searched = Item.where(genre: target)
    @title = target.name + "一覧"
    set_items(searched)
    render :index
  end

  # 検索メソッド
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
