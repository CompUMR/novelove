class Public::HomesController < ApplicationController
  def top
    @new_items = Item.all.order(created_at: "DESC")[0..4]
    @genres = Genre.all
  end

  def about
    @items_count = Item.all.size
  end
end
