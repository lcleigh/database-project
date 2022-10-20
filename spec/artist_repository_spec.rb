require "artist_repository"

RSpec.describe ArtistRepository do

    def reset_artists_table
        seed_sql = File.read('spec/seeds_artists.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
        connection.exec(seed_sql)
    end

    before (:each) do
        reset_artists_table
    end

    it "returns the lit of artists" do
        repo = ArtistRepository.new
        artists = repo.all
        expect(artists.length).to eq 3
        expect(artists.first.id).to eq '1'
        expect(artists.first.name).to eq 'Pixies'
    end

    it "returns the Pixies as single artist" do
        repo = ArtistRepository.new
        artist = repo.find(1)
        expect(artist.name).to eq 'Pixies'
        expect(artist.genre).to eq 'Rock'
    end

    it "returns Tylor Swift as single artist" do
        repo = ArtistRepository.new
        artist = repo.find(3)
        expect(artist.name).to eq 'Taylor Swift'
        expect(artist.genre).to eq 'Pop'
    end

    it "creates a new artist" do
        repo = ArtistRepository.new

        new_artist = Artist.new
        new_artist.name = "Britney Spears"
        new_artist.genre = "Pop"

        repo.create(new_artist)

        artists = repo.all
        expect(artists.last.name).to eq "Britney Spears"
        expect(artists.last.genre).to eq "Pop"

    end

    it "deletes an artist" do
        repo = ArtistRepository.new

        id_to_delete = 1

        repo.delete(id_to_delete)

        all_artists = repo.all
        expect(all_artists.length).to eq 2
        expect(all_artists.first.id).to eq '2'
    end

    it "deletes the first two artists" do
        repo = ArtistRepository.new

        repo.delete(1)
        repo.delete(2)

        all_artists = repo.all
        expect(all_artists.length).to eq 1
        expect(all_artists.first.id).to eq '3'
    end

    it "updates an artist with new values" do
        repo = ArtistRepository.new

        artist = repo.find(1)

        artist.name = "Gloria Gaynor"
        artist.genre = "Disco"

        repo.update(artist)

        updated_artist = repo.find(1)

        expect(updated_artist.name).to eq "Gloria Gaynor"
        expect(updated_artist.genre).to eq "Disco"
    end

    it "updates an artist with a new name only" do
        repo = ArtistRepository.new

        artist = repo.find(1)

        artist.name = "Gloria Gaynor"
        

        repo.update(artist)

        updated_artist = repo.find(1)
        
        expect(updated_artist.name).to eq "Gloria Gaynor"
        expect(updated_artist.genre).to eq "Rock"
    end

end