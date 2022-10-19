#1 require the file
require "album_repository"

RSpec.describe AlbumRepository do
    def reset_albums_table
        seed_sql = File.read('spec/seeds_albums.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test'})
        connection.exec(seed_sql)
    end

    before (:each) do
        reset_albums_table
    end

    it "returns the list of albums" do
        repo = AlbumRepository.new
        albums = repo.all
        expect(albums.length).to eq 2
        # expect(albums.first.id).to eq '1'
        expect(albums.first.title).to eq 'Spice'
        expect(albums.first.release_year).to eq '1996'
        expect(albums.first.artist_id).to eq '1'
    end

    it "returns the single album Spice" do
        repo = AlbumRepository.new
        album = repo.find(1)
        
        expect(album.title).to eq 'Spice'
        expect(album.release_year).to eq '1996'
        expect(album.artist_id).to eq '1'
    end

    it "returns the single album Madman Across the Water" do
        repo = AlbumRepository.new
        album = repo.find(2)
        
        expect(album.title).to eq 'Madman Across the Water'
        expect(album.release_year).to eq '1971'
        expect(album.artist_id).to eq '2'
    end

end




   

    