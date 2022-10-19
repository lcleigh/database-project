require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

DatabaseConnection.connect('music_library')

artist_repository = ArtistRepository.new
album_repository = AlbumRepository.new

# .find will return the artist with the id=4
artist_3 = artist_repository.find(4)
p "Artist 3: #{artist_3.name}, Genre: #{artist_3.genre}"

# .find will return the album with the id=2
album_2 = album_repository.find(2)
p "Album 2: #{album_2.title}, Release Year: #{album_2.release_year}"

# The below will return a list of all artists and albums
# artist_repository.all.each do |artist|
#     p artist
# end


# album_repository.all.each do |album|
#     p album
# end