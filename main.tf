terraform {
  required_providers {
    spotify = {
      version = "~> 0.2.0"
      source  = "conradludgate/spotify"
    }
  }
}

variable "spotify_api_key" {
  type = string
}

provider "spotify" {
  api_key = var.spotify_api_key
}

resource "spotify_playlist" "playlist" {
  name        = "Terraform Summer Playlist"
  description = "This playlist was created by Terraform"
  public      = true

  tracks = flatten([
    data.spotify_search_track.by_artist.tracks[*].id,
    data.spotify_search_track.by_artist2.tracks[*].id,
    data.spotify_search_track.by_artist3.tracks[*].id,
    data.spotify_search_track.by_artist4.tracks[*].id,
  ])
}

data "spotify_search_track" "by_artist" {
  artist = "TUBE"
  limit = 10
}

data "spotify_search_track" "by_artist2" {
  artist = "サザンオールスターズ"
  limit = 10
}

data "spotify_search_track" "by_artist3" {
  artist = "Ado"
  limit = 10
}

data "spotify_search_track" "by_artist4" {
  artist = "YOASOBI"
  limit = 10
}

output "tracks" {
  value = [
           data.spotify_search_track.by_artist.tracks,
           data.spotify_search_track.by_artist2.tracks,
           data.spotify_search_track.by_artist3.tracks,
           data.spotify_search_track.by_artist4.tracks,
          ]
}
