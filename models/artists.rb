require('pg')
require_relative('../db/sql_runner.rb')

class Artist

    attr_reader :id, :name

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @name = options['name']
    end

    def save()
        sql = "INSERT INTO artists
        (
          name
        ) VALUES
        (
          $1
        )
        RETURNING id"
        values = [@name]
        returned_array = SqlRunner.run(sql, values)
        artists_hash = returned_array[0]
        @id = artists_hash['id'].to_i()
    end

    def albums()
        sql = "SELECT * FROM albums WHERE artist_id = $1"
        values = [@id]
        albums = SqlRunner.run(sql, values)
        return albums.map{|album| Album.new(album)}
    end

    def self.all()
       sql = "SELECT * FROM artists"
       artists = SqlRunner.run(sql)
       return artists.map{|artist| Artist.new(artist)}
     end


end
