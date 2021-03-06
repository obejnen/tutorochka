class Admin::CategoriesController < Admin::AdminController
    before_action :set_category, only: [:edit, :destroy, :update]

    def index
        @search = Category.ransack(params[:q])
        @categories = @search.result
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            redirect_to admin_categories_path, success: "Category was successfully created"
        else
            flash["danger"] = "Category was not created"
            render :new
        end
    end

    def edit
    end

    def update
        if @category.update_attributes(category_params)
            redirect_to admin_categories_path, success: "Category was successfully updated"
        else
            flash["danger"] = "Category was not updated"
            render :edit
        end
    end

    def destroy
        @category.destroy
        redirect_to admin_categories_path, success: "Category was successfully deleted"
    end

    private

    def set_category
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name)
    end
end