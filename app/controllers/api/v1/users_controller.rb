module  Api
    module V1
        class UsersController < ApplicationController
            def index
                users = User.order('created_at DESC')
                render json: {
                    status: 'SUCCESS', 
                    message: 'users loaded successfully',
                    data: users
                }, status: :ok
            end
            
            def show 
                user = User.find(params[:id])
                render json: {
                    status: 'SUCCESS', 
                    message: 'user loaded successfully',
                    data: user
                }, status: :ok
            end

            def created
                user = User.new(user_params)
                if user.save
                    render json: {
                        status: 'SUCCESS',
                        message: 'user posted successefully'
                        data: users
                    }, status: :ok
                else
                    render json: { 
                        status: 'ERROR', 
                        message: 'user not saved', 
                        data: user.erros
                    }, status: :unprocessable_entity
                end
            end
            
            def update
				user = User.find(params[:id])
				if user.update_attributes(article_params)
					render json: {status: 'SUCCESS', message:'Updated article', data:user},status: :ok
				else
					render json: {status: 'ERROR', message:'Articles not update', data:user.erros},status: :unprocessable_entity
				end
            end

            def destroy
				user = Article.find(params[:id])
				user.destroy
				render json: {
                    status: 'SUCCESS', 
                    message:'Deleted user', 
                    data:user
                },status: :ok
            end
            
            private 
            def user_params
                params.permit(:name :phone)
            end
        end
    end
end