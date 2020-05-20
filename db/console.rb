require('pry')
require_relative('../models/artists.rb')
require_relative('../models/albums.rb')
#
artist1 = Artist.new({
    'name' => 'Eminem'
})

artist1.save()

artist2 = Artist.new({
    'name' => 'David Bowie'
})

artist2.save()

album1 = Album.new({
    'name' => 'Recovery',
    'genre' => 'rap',
    'artist_id' => artist1.id
})

album1.save()

album2 = Album.new({
    'name' => 'Aladdin Sane',
    'genre' => 'rock',
    'artist_id' => artist2.id
})

album2.save()

binding.pry
nil
