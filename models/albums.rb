require('pg')
require_relative('../db/sql_runner.rb')

class Album

    attr_reader :id, :name, :artist_id, :genre

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @name = options['name']
        @genre = options['genre']
        @artist_id = options['artist_id']
    end

    def save()
        sql = "INSERT INTO albums
        (
          name,
          artist_id,
          genre
        ) VALUES
        (
          $1, $2, $3
        )
        RETURNING id"
        values = [@name, @artist_id, @genre]
        returned_array = SqlRunner.run(sql, values)
        albums_hash = returned_array[0]
        @id = albums_hash['id'].to_i()
    end

    def artist()
        sql = "SELECT * FROM artists WHERE id = $1"
        values = [@artist_id]
        result = SqlRunner.run(sql, values)
        artist = result[0]
        return Artist.new(artist)
    end

    def self.all()
       sql = "SELECT * FROM albums"
       albums = SqlRunner.run(sql)
       return albums.map{|album| Album.new(album)}
     end


end
