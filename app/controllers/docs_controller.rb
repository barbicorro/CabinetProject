class DocsController < ApplicationController

before_action :find_doc, only: [:show,:edit,:update,:destroy]
	
	def index
		if (user_signed_in?)
			@docs = Doc.where(user_id: current_user)
		else
			redirect_to new_user_session_path
		end
	end

	def show
	end

	def new
		if (user_signed_in?)
			@doc = current_user.docs.build
		else
			redirect_to new_user_session_path
		end
	end

	def create
		@doc = current_user.docs.build(doc_params)
		if @doc.save
			redirect_to @doc 
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @doc.update(doc_params)
			redirect_to @doc
		else
			render 'edit'
		end
	end

	def destroy
		if @doc.destroy
			redirect_to docs_path
		end
	end

private 
	
	def find_doc
		if (user_signed_in?)
		@doc = Doc.find(params[:id])
		else
			redirect_to new_user_session_path
		end
	end

	def doc_params
		params.require(:doc).permit(:title,:content)
	end

end
