ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
form do |f|
		f.inputs "Identity" do
		  f.input :username
		  f.input :email
		  f.input :points
		end
		f.inputs "Security" do
		  f.input :password
		  f.input :password_confirmation
		end
		f.inputs "Admin" do
		  f.input :admin
		end
		f.actions
	end

permit_params :email, :password

  index do
    selectable_column
    column :id
    column :email
    column :username
    column :points
    column :created_at
    column :last_sign_in_at
    column :admin
    actions
  end

# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
