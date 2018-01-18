class PagesController < ApplicationController
    respond_to :html

    def dashboard
      @admins = Admin.all
      respond_with @admins
    end

    def update
        admin = Admin.find_by(id: params[:id])
        return head status: :not_found unless admin
        return head status: :forbidden unless admin_signed_in? and current_admin.approved?
        if admin.update(admin_parameters_update)
            head status: :ok
        else
            render json: {error: admin.errors}, status: :bad_request
        end  
    end

    def admin_parameters_update
        params.require(:admin).permit(:approved)
    end
end
