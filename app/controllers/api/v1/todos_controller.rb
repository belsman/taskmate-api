class Api::V1::TodosController < ApplicationController
    before_action :authorize_request
    before_action :set_todo, only: [:update, :destroy]

    def index
      @todos = @current_user.todos
      render json: @todos
    end

    def create
      @todo = @current_user.todos.build(todo_params)
      if @todo.save
        render json: @todo, status: :created
      else
        render json: { errors: @todo.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @todo.update(todo_params)
        render json: @todo
      else
        render json: { errors: @todo.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @todo.destroy
      head :no_content
    end

    private

    def set_todo
      @todo = @current_user.todos.find_by(id: params[:id])
      return render json: { error: 'Not Found' }, status: :not_found unless @todo
    end

    def todo_params
      params.require(:todo).permit(:title, :status)
    end

    def authorize_request
        header = request.headers['Authorization']
        token = header.split(' ').last if header
        begin
          decoded = JWT.decode(token, Rails.application.secret_key_base)[0]
          @current_user = User.find(decoded['user_id'])
          
        rescue
          render json: { errors: 'Unauthorized' }, status: :unauthorized
        end
      end
end
