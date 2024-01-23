#install.packages("httr")
#install.packages("reticulate")

library(httr)
library(reticulate)

#access_id
getCredentials <- function(file_path) {
  credentials <- read.table(file_path, sep = "=", stringsAsFactors = FALSE, strip.white = TRUE)
  credentials_list <- as.list(setNames(credentials$V2, credentials$V1))
  return(credentials_list)
}

file_path <- "../API_Keys.txt"
credentials <- getCredentials(file_path)

# Access clientID and secret
clientID <- credentials$clientID
secret <- credentials$secret

response = POST(
  'https://accounts.spotify.com/api/token',
  accept_json(),
  authenticate(clientID, secret),
  body = list(grant_type = 'client_credentials'),
  encode = 'form',
  verbose()
)

mytoken = content(response)$access_token
HeaderValue = paste0('Bearer ', mytoken)

artistID = "06HL4z0CvFAxyc27GXpf02"
URI = paste0('https://api.spotify.com/v1/artists/', artistID)
response2 = GET(url = URI, add_headers(Authorization = HeaderValue))
Artist = content(response2)
Artist
#Artist$followers$total
#Artist$popularity

URI = paste0('https://api.spotify.com/v1/artists/', artistID,'/albums')
response2 = GET(url = URI, add_headers(Authorization = HeaderValue))
Albums = content(response2)

Albums$items[[1]]$id
Albums$items[[1]]$name
Albums$items[[1]]$release_date
Albums$items[[1]]$total_tracks

albumID = "1NAmidJlEaVgA3MpcPFYGq"
track_URI = paste0('https://api.spotify.com/v1/albums/', albumID,'/tracks')
track_response = GET(url = track_URI, add_headers(Authorization = HeaderValue))
tracks = content(track_response)

ntracks = length(tracks$items)
tracks_list<-data.frame(
  name=character(ntracks),
  id=character(ntracks),
  artist=character(ntracks),
  disc_number=numeric(ntracks),
  track_number=numeric(ntracks),
  duration_ms=numeric(ntracks),
  stringsAsFactors=FALSE
)

for(i in 1:ntracks){
  tracks_list[i,]$id <- tracks$items[[i]]$id
  tracks_list[i,]$name <- tracks$items[[i]]$name
  tracks_list[i,]$artist <- tracks$items[[i]]$artists[[1]]$name
  tracks_list[i,]$disc_number <- tracks$items[[i]]$disc_number
  tracks_list[i,]$track_number <- tracks$items[[i]]$track_number
  tracks_list[i,]$duration_ms <- tracks$items[[i]]$duration_ms
}

# Get Additional Track Details
for(i in 1:nrow(tracks_list)){
  Sys.sleep(0.10)
  track_URI2 = paste0('https://api.spotify.com/v1/audio-features/',   
                      tracks_list$id[i])
  track_response2 = GET(url = track_URI2, 
                        add_headers(Authorization = HeaderValue))
  tracks2 = content(track_response2)
  
  tracks_list$key[i] <- tracks2$key
  tracks_list$mode[i] <- tracks2$mode
  tracks_list$time_signature[i] <- tracks2$time_signature
  tracks_list$acousticness[i] <- tracks2$acousticness
  tracks_list$danceability[i] <- tracks2$danceability
  tracks_list$energy[i] <- tracks2$energy
  tracks_list$instrumentalness[i] <- tracks2$instrumentalness
  tracks_list$liveliness[i] <- tracks2$liveness
  tracks_list$loudness[i] <- tracks2$loudness
  tracks_list$speechiness[i] <- tracks2$speechiness
  tracks_list$valence[i] <- tracks2$valence
  tracks_list$tempo[i] <- tracks2$tempo
}
#tracks_list
#nrow(tracks_list)

showID = "76h8fh9KK3boiMrQ340lV4"
market='US'
URI = paste0('https://api.spotify.com/v1/shows/', showID,"?&market=",market)
response2 = GET(url = URI, add_headers(Authorization = HeaderValue))
Show = content(response2)
counter=Show$total_episodes

#Show
id=character(counter)

offset=0
Show$episodes$items[[1]]$id
while(offset<Show$total_episodes){
  URI = paste0('https://api.spotify.com/v1/shows/', showID,'/episodes',
               "?&market=",market,
               "&offset=",offset)
  response2 = GET(url = URI, add_headers(Authorization = HeaderValue))
  episodes = content(response2)
  #print(length(episodes$items))
  for(i in 1:length(episodes$items)){
    id[i+offset] = episodes$items[[i]]$id
  }
  offset=offset+20
}
id[1]
URIs = paste0('https://api.spotify.com/v1/episodes/',id[1],"?&market=",market)
response3 = GET(url = URIs, add_headers(Authorization = HeaderValue))
tracks2 = content(response3)

URIs = paste0('https://api.spotify.com/v1/audio-features/',id[1],"?&market=",market)
response4 = GET(url = URIs, add_headers(Authorization = HeaderValue))
tracks3 = content(response4)