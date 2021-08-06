class Movie < ActiveRecord::Base
    belongs_to :user
    # class all method
    # class first method
    # class find/find_by/where (select)
    # save instance
    # update instance method
    # create instance (new/save together)
    # destroy instance method
    # destroy_all class method
    # destroy_by class method
    # attr_accessors for all columns

    # genre
    belongs_to :genre
    # genre getter
    # genre= setter
    # build_genre(attr) won't auto save
    # create_genre(attr)
    # create_genre!(attr)
    # reload_genre

    # director
    belongs_to :director

    validates :title, presence: true
    #makes sure that a title is present before a movie can be saved 
end