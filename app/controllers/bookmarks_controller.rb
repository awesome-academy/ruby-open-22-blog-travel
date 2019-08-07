class BookmarksController < ApplicationController
  before_action :load_blog, only: %i(create destroy)
  before_action :load_place, only: %i(create destroy)

  def create
    if params[:type] == "Blog"
      @bookmark_blog = current_user.bookmarks.build bookmarkable: @blog

      respond_to do |format|
        format.js if @bookmark_blog.save
      end
    else
      @bookmark_place = current_user.bookmarks.build bookmarkable: @place

      respond_to do |format|
        format.js if @bookmark_place.save
      end
    end
  end

  def destroy
    @bookmark = Bookmark.find_by id: params[:id]

    if @bookmark.bookmarkable_type == "Blog"
      @destroy = "Blog"
    else
      @destroy = "Place"
    end

    respond_to do |format|
      format.js if @bookmark.destroy
    end
  end

  private

  def load_blog
    @blog = Blog.find_by id: params[:blog_id]
  end

  def load_place
    @place = Place.find_by id: params[:place_id]
  end
end
