require 'grape'

module Blog

  class API < Grape::API
  
    resource :weblogs do
    
      get do
        Weblog.all.to_json
      end
      
      get ':id' do
        Weblog.find(params[:id]).to_json
      end
      
      get ':id/posts' do
        weblog = Weblog.find(params[:id])
        weblog.posts.to_json
      end
      
      post ':id/posts' do
        @weblog = Weblog.find(params[:id])
        @post = Post.new
        @post.title = params[:title] if params[:title]
        @post.body = params[:body] if params[:body]
        @weblog.posts << @post
        
        status 201
        @post.to_json
      end
      
      delete ':id/posts' do
        @weblog = Weblog.find(params[:id])
        @weblog.posts.clear
      end
      
      post do
        @weblog = Weblog.new
        @weblog.title = params[:title] if params[:title]
        @weblog.description = params[:description] if params[:description]
        @weblog.save 
        
        status 201
        @weblog.to_json
      end
      
      put ':id' do
        @weblog = Weblog.find(params[:id])
        @weblog.title = params[:title] if params[:title]
        @weblog.description = params[:description] if params[:description]
        @weblog.save
        
        @weblog.to_json
      end
      
      delete do
        Weblog.destroy_all().to_json
      end
    
      delete ':id' do
        Weblog.destroy(params[:id]).to_json
      end
    
    end 
    
    resource :posts do
    
      get do
        Post.all.to_json
      end
      
      get ':id' do
        Post.find(params[:id]).to_json
      end
      
      get ':id/comments' do
        @post = Post.find(params[:id])
        @post.comments.to_json
      end
      
      delete ':id/comments' do
        @post = Post.find(params[:id])
        @post.comments.clear
      end
      
      post ':id/comments' do
        @post = Post.find(params[:id])
        @comment = Comment.new
        @comment.name = params[:name] if params[:name]
        @comment.name = params[:body] if params[:body]
        @post.comments << @comment
        
        status 201
        @comment.to_json
      end
      
      delete ':id' do
        Post.destroy(params[:id]).to_json
      end
      
      put ':id' do
        @post = Post.find(params[:id])
        @post.title = params[:title] if params[:title]
        @post.body = params[:body] if params[:body]
        @post.save
        
        @post.to_json
      end
      
      delete do
        Post.destroy_all().to_json
      end
      
    end
    
    resource :comments do
      get do
        Comment.all.to_json
      end
      
      get ':id' do
        Comment.find(params[:id]).to_json
      end
      
      put ':id' do
        @comment = Comment.find(params[:id])
        @comment.name = params[:name] if params[:name]
        @comment.body = params[:body] if params[:body]
        @comment.to_json
      end
      
      delete ':id' do
        Comment.destroy(params[:id]).to_json
      end
      
      delete do
        Comment.destroy_all().to_json
      end      
    end
      
  end

end

