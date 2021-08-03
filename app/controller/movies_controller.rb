class MoviesController < ApplicationController
    
    # READ all movies
    get '/movies' do
        redirect_if_not_logged_in

        @movies = current_user.movies
        erb :'movies/index'
    end

    # CREATE new movie (render form)
    get '/movies/new' do
        redirect_if_not_logged_in

        erb :'movies/new'
    end

    # READ 1 movie
    get '/movies/:id' do
        redirect_if_not_logged_in
        redirect_if_not_authorized
        #why do we not have to pass in Movie.find(params[:id])?
        #@movie = Movie.find_by_id(params[:id])
        erb :'movies/show'
    end

    # CREATE new movie (save in db)
    post '/movies' do
        redirect_if_not_logged_in
        #movie = Movie.new(title: params["title"])

        # movie = Movie.new(params["movie"])
        # movie.user_id = session["user_id"]
        movie = current_user.movies.build(params["movie"])

        if movie.save
            redirect "/movies/#{movie.id}"
        else
            flash[:error] = "#{movie.errors.full_messages.join(", ")}"
            redirect "/movies/new"
        end
    end

    # UPDATE 1 movie (render form)
    get '/movies/:id/edit' do
        redirect_if_not_logged_in
        redirect_if_not_authorized
        #@movie = Movie.find_by_id(params[:id])

        erb :'movies/edit'
    end

    # UPDATE 1 movie (save in db)
    patch '/movies/:id' do
        redirect_if_not_logged_in
        redirect_if_not_authorized
        #movie = Movie.find_by_id(params[:id])
        #movie.title = params["title"]
        #if movie.save and the rest is the same

        
        if @movie.update(params["movie"])
            redirect "/movies/#{@movie.id}"
        else
            redirect "/movies/#{@movie.id}/edit"
        end
    end

    # DELETE 1 movie
    delete "/movies/:id" do
        redirect_if_not_logged_in
        redirect_if_not_authorized

        @movie.destroy

        redirect "/movies"
    end

    private

    def redirect_if_not_authorized
        @movie = Movie.find_by_id(params[:id])
        if @movie.user_id != session["user_id"]
            redirect "/movies"
        end
    end
end