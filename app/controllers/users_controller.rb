class UsersController < ApplicationController

def update
	@user = current_user
	location = params.require(:user).permit(:longitude, :latitude)
	@user.update!(location)
end

end

