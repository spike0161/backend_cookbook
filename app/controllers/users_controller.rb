

  class UsersController < ApplicationController

    # before_action :update, only: [:edit]


      def index
          user =User.all
          render json: user.to_json(
              {:except => [:created_at, :updated_at] })
      end

      def show
          user = User.find(params[:id])
          render json: {user: user, favorites: user.recipes}
      end

    def edit
    end




  def create
    user = User.create(first_name: params[:firstname], last_name: params[:lastname], username: params[:username], password: params[:password])
    if user.valid?
       render json: { user: user,  favorites: user.recipes , status: :created }
    else
       render json: { error: "Failed to created user"}, status: :not_acceptable
    end
  end


    def update
      # byebug
      user = User.find(params[:id])
      user.bio = params[:bio]
      user.picture = params[:picture]
      user.save
      render json: {user: user, favorites: user.recipes}
    end



  def login
    user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
    render json: { user: user, favorites: user.recipes,
    successful: true,
    data: user,
    token: encode("id": user.id)
    }  else
  render json: { message: "Incorrect username or password",
  successful: false
}
      end
  end


# localStorage auth method
  def profile
    token = request.headers["Authentication"]
    user = User.find(decode(token)["id"])
    render json: {user: user, favorites: user.recipes}
  end

  end
