class Admin::GenresController < ApplicationController
  # ジャンル管理画面(一覧・追加を兼ねる)
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  # ジャンルデータ登録
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      # genresコントローラのindex.html.erbへ遷移。
      redirect_to admin_genres_path, notice: "ジャンルを正常に追加しました。"
    else
      @genres = Genre.all
      render :index # 入力にエラーがあった場合は再度index.html.erbを表示。
    end
  end

  # ジャンル編集画面
  def edit
    @genre = Genre.find(params[:id])
  end

  # ジャンルデータ更新
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      # genresコントローラのindex.html.erbへ遷移。
      redirect_to admin_genres_path, notice: "ジャンルを正常に保存しました。"
    else
      render :edit # 入力にエラーがあった場合は再度edit.html.erbを表示。
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
