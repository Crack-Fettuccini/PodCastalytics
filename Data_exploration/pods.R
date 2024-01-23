library(httr)
library(stringr)
library(reticulate)
library(tuneR)
library(R.utils)
use_python("/usr/local/bin/python3")
#for including python local dependency
import_from_path("Vokaturi", path = "./OpenVokaturi-4-0/api")
#to prevent error
setwd("./OpenVokaturi-4-0/examples")
#user agent setup for httr package
UA <- "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36"

#reading lines from RSS feed
thepage = readLines('https://atp.fm/rss')
df_page = data.frame(thepage)

#getting individual audio file links
link_lines=grep('enclosure(.*?)url',thepage)
mypattern = '<enclosure(.*?)url="(.*?)"'
net_size=length(link_lines)
net_size
datalines=c(character, net_size)
x=1
# cleaning data to get only lines with required link
for (i in 1:net_size){
  datalines[i] = grep(mypattern,thepage[link_lines[i]],value=TRUE)
  x=x+1
}

# cleaning data to get only required link
dataliner=c(character,net_size)
for (i in 1:net_size){
  dataliner[i]=str_extract(str_extract(datalines[i],'url="https(.*?).mp3'), 'https(.*?).mp3')  
}



write.csv(data.frame("url","Neutral_bar","Happy_bar","Sad_bar","Anger_bar","Fear_bar","time"),"./pod_lean1.csv")

# initializing vectors to represent average % each emotion in audio files

i=0
# List of all file names
R.utils::copyDirectory("./OpenVokaturi-4-0/",
                       "./.tmpdisk/POD_Auth/")

for (url in dataliner){
  file.remove("./.tmpdisk/POD_Auth/examples/current.mp3")
  file.remove("./.tmpdisk/POD_Auth/examples/hello.wav")
  download.file(url,"./.tmpdisk/POD_Auth/examples/current.mp3")
  py_run_file("./.tmpdisk/POD_Auth/examples/OpenVokaWavCurve.py")
  
  Neutral=mean(py$output$Neutral)
  Happy=mean(py$output$Happy)
  Sad=mean(py$output$Sad)
  Anger=mean(py$output$Anger)
  Fear=mean(py$output$Fear)
  sound_length=mean(py$output$Time)
  
  
  row2=data.frame(url,Neutral,Happy,Sad,Anger,Fear,sound_length)
  write.table(row2, file = "./pod_lean1.csv", sep = ",",
              append = TRUE,quote = FALSE,col.names = FALSE,row.names = FALSE)
}
# download.file("https://traffic.libsyn.com/atpfm/atp508.mp3","./.tmpdisk/POD_Auth/examples/current.mp3")





#https://omny.fm/shows/startalk-radio/playlists/podcast.rss
#https://feeds.megaphone.fm/stuffyoushouldknow
#https://feeds.soundcloud.com/users/soundcloud:users:236923839/sounds.rss
#https://www.omnycontent.com/d/playlist/2c72fd2a-9a3a-4472-9a57-abab0011fabb/8ac37957-6236-4524-a130-abad0082ba1d/d6b867cf-4c83-48f3-86ce-abad0082ba35/podcast.rss
library(httr)
library(stringr)
library(reticulate)
library(tuneR)
library(R.utils)
use_python("/usr/local/bin/python3")
#for including python local dependency
import_from_path("Vokaturi", path = "./OpenVokaturi-4-0/api")
#to prevent error
setwd("./OpenVokaturi-4-0/examples")
#user agent setup for httr package
UA <- "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36"

#reading lines from RSS feed
thepage = readLines('https://feeds.soundcloud.com/users/soundcloud:users:236923839/sounds.rss')
df_page = data.frame(thepage)

#getting individual audio file links
link_lines=grep('enclosure(.*?)url',thepage)
mypattern = '<enclosure(.*?)url="(.*?)"'
net_size=length(link_lines)
net_size
datalines=c(character, net_size)
x=1
# cleaning data to get only lines with required link
for (i in 1:net_size){
  datalines[i] = grep(mypattern,thepage[link_lines[i]],value=TRUE)
  x=x+1
}

# cleaning data to get only required link
dataliner=c(character,net_size)
for (i in 1:net_size){
  dataliner[i]=str_extract(str_extract(datalines[i],'url="https(.*?).mp3'), 'https(.*?).mp3')  
}



write.csv(data.frame("url","Neutral_bar","Happy_bar","Sad_bar","Anger_bar","Fear_bar","time"),"./pod_lean2.csv")

# initializing vectors to represent average % each emotion in audio files

i=0
# List of all file names
R.utils::copyDirectory("./OpenVokaturi-4-0/",
                       "./.tmpdisk/POD_Auth/")

for (url in dataliner){
  file.remove("./.tmpdisk/POD_Auth/examples/current.mp3")
  file.remove("./.tmpdisk/POD_Auth/examples/hello.wav")
  download.file(url,"./.tmpdisk/POD_Auth/examples/current.mp3")
  py_run_file("./.tmpdisk/POD_Auth/examples/OpenVokaWavCurve.py")
  
  Neutral=mean(py$output$Neutral)
  Happy=mean(py$output$Happy)
  Sad=mean(py$output$Sad)
  Anger=mean(py$output$Anger)
  Fear=mean(py$output$Fear)
  sound_length=mean(py$output$Time)
  
  
  row2=data.frame(url,Neutral,Happy,Sad,Anger,Fear,sound_length)
  write.table(row2, file = "./pod_lean2.csv", sep = ",",
              append = TRUE,quote = FALSE,col.names = FALSE,row.names = FALSE)
}
# download.file("https://traffic.libsyn.com/atpfm/atp508.mp3","./.tmpdisk/POD_Auth/examples/current.mp3")

#https://omny.fm/shows/startalk-radio/playlists/podcast.rss
#https://feeds.megaphone.fm/stuffyoushouldknow
#https://feeds.soundcloud.com/users/soundcloud:users:236923839/sounds.rss
#https://www.omnycontent.com/d/playlist/2c72fd2a-9a3a-4472-9a57-abab0011fabb/8ac37957-6236-4524-a130-abad0082ba1d/d6b867cf-4c83-48f3-86ce-abad0082ba35/podcast.rss
library(httr)
library(stringr)
library(reticulate)
library(tuneR)
library(R.utils)
use_python("/usr/local/bin/python3")
#for including python local dependency
import_from_path("Vokaturi", path = "./OpenVokaturi-4-0/api")
#to prevent error
setwd("./OpenVokaturi-4-0/examples")
#user agent setup for httr package
UA <- "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36"

#reading lines from RSS feed
thepage = readLines('https://omny.fm/shows/startalk-radio/playlists/podcast.rss')
df_page = data.frame(thepage)

#getting individual audio file links
link_lines=grep('enclosure(.*?)url',thepage)
mypattern = '<enclosure(.*?)url="(.*?)"'
net_size=length(link_lines)
net_size
datalines=c(character, net_size)
x=1
# cleaning data to get only lines with required link
for (i in 1:net_size){
  datalines[i] = grep(mypattern,thepage[link_lines[i]],value=TRUE)
  x=x+1
}

# cleaning data to get only required link
dataliner=c(character,net_size)
for (i in 1:net_size){
  dataliner[i]=str_extract(str_extract(datalines[i],'url="https(.*?).mp3'), 'https(.*?).mp3')  
}


write.csv(data.frame("url","Neutral_bar","Happy_bar","Sad_bar","Anger_bar","Fear_bar","time"),"./pod_lean3.csv")

# initializing vectors to represent average % each emotion in audio files

i=0
# List of all file names
R.utils::copyDirectory("./OpenVokaturi-4-0/",
                       "./.tmpdisk/POD_Auth/")

for (url in dataliner){
  file.remove("./.tmpdisk/POD_Auth/examples/current.mp3")
  file.remove("./.tmpdisk/POD_Auth/examples/hello.wav")
  download.file(url,"./.tmpdisk/POD_Auth/examples/current.mp3")
  py_run_file("./.tmpdisk/POD_Auth/examples/OpenVokaWavCurve.py")
  
  Neutral=mean(py$output$Neutral)
  Happy=mean(py$output$Happy)
  Sad=mean(py$output$Sad)
  Anger=mean(py$output$Anger)
  Fear=mean(py$output$Fear)
  sound_length=mean(py$output$Time)
  
  
  row2=data.frame(url,Neutral,Happy,Sad,Anger,Fear,sound_length)
  write.table(row2, file = "./pod_lean3.csv", sep = ",",
              append = TRUE,quote = FALSE,col.names = FALSE,row.names = FALSE)
}
# download.file("https://traffic.libsyn.com/atpfm/atp508.mp3","./.tmpdisk/POD_Auth/examples/current.mp3")

#https://omny.fm/shows/startalk-radio/playlists/podcast.rss
#https://feeds.megaphone.fm/stuffyoushouldknow
#https://feeds.soundcloud.com/users/soundcloud:users:236923839/sounds.rss
#https://www.omnycontent.com/d/playlist/2c72fd2a-9a3a-4472-9a57-abab0011fabb/8ac37957-6236-4524-a130-abad0082ba1d/d6b867cf-4c83-48f3-86ce-abad0082ba35/podcast.rss
library(httr)
library(stringr)
library(reticulate)
library(tuneR)
library(R.utils)
use_python("/usr/local/bin/python3")
#for including python local dependency
import_from_path("Vokaturi", path = "./OpenVokaturi-4-0/api")
#to prevent error
setwd("./OpenVokaturi-4-0/examples")
#user agent setup for httr package
UA <- "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36"

#reading lines from RSS feed
thepage = readLines('https://feeds.megaphone.fm/stuffyoushouldknow')
df_page = data.frame(thepage)

#getting individual audio file links
link_lines=grep('enclosure(.*?)url',thepage)
mypattern = '<enclosure(.*?)url="(.*?)"'
net_size=length(link_lines)
net_size
datalines=c(character, net_size)
x=1
# cleaning data to get only lines with required link
for (i in 1:net_size){
  datalines[i] = grep(mypattern,thepage[link_lines[i]],value=TRUE)
  x=x+1
}

# cleaning data to get only required link
dataliner=c(character,net_size)
for (i in 1:net_size){
  dataliner[i]=str_extract(str_extract(datalines[i],'url="https(.*?).mp3'), 'https(.*?).mp3')  
}



write.csv(data.frame("url","Neutral_bar","Happy_bar","Sad_bar","Anger_bar","Fear_bar","time"),"./pod_lean4.csv")

# initializing vectors to represent average % each emotion in audio files

i=0
# List of all file names
R.utils::copyDirectory("./OpenVokaturi-4-0/",
                       "./.tmpdisk/POD_Auth/")

for (url in dataliner){
  file.remove("./.tmpdisk/POD_Auth/examples/current.mp3")
  file.remove("./.tmpdisk/POD_Auth/examples/hello.wav")
  download.file(url,"./.tmpdisk/POD_Auth/examples/current.mp3")
  py_run_file("./.tmpdisk/POD_Auth/examples/OpenVokaWavCurve.py")
  
  Neutral=mean(py$output$Neutral)
  Happy=mean(py$output$Happy)
  Sad=mean(py$output$Sad)
  Anger=mean(py$output$Anger)
  Fear=mean(py$output$Fear)
  sound_length=mean(py$output$Time)
  
  
  row2=data.frame(url,Neutral,Happy,Sad,Anger,Fear,sound_length)
  write.table(row2, file = "./pod_lean4.csv", sep = ",",
              append = TRUE,quote = FALSE,col.names = FALSE,row.names = FALSE)
}
# download.file("https://traffic.libsyn.com/atpfm/atp508.mp3","./.tmpdisk/POD_Auth/examples/current.mp3")

#https://omny.fm/shows/startalk-radio/playlists/podcast.rss
#https://feeds.megaphone.fm/stuffyoushouldknow
#https://feeds.soundcloud.com/users/soundcloud:users:236923839/sounds.rss
#https://www.omnycontent.com/d/playlist/2c72fd2a-9a3a-4472-9a57-abab0011fabb/8ac37957-6236-4524-a130-abad0082ba1d/d6b867cf-4c83-48f3-86ce-abad0082ba35/podcast.rss
library(httr)
library(stringr)
library(reticulate)
library(tuneR)
library(R.utils)
use_python("/usr/local/bin/python3")
#for including python local dependency
import_from_path("Vokaturi", path = "./OpenVokaturi-4-0/api")
#to prevent error
setwd("./OpenVokaturi-4-0/examples")
#user agent setup for httr package
UA <- "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36"

#reading lines from RSS feed
thepage = readLines('https://www.omnycontent.com/d/playlist/2c72fd2a-9a3a-4472-9a57-abab0011fabb/8ac37957-6236-4524-a130-abad0082ba1d/d6b867cf-4c83-48f3-86ce-abad0082ba35/podcast.rss')
df_page = data.frame(thepage)

#getting individual audio file links
link_lines=grep('enclosure(.*?)url',thepage)
mypattern = '<enclosure(.*?)url="(.*?)"'
net_size=length(link_lines)
net_size
datalines=c(character, net_size)
x=1
# cleaning data to get only lines with required link
for (i in 1:net_size){
  datalines[i] = grep(mypattern,thepage[link_lines[i]],value=TRUE)
  x=x+1
}

# cleaning data to get only required link
dataliner=c(character,net_size)
for (i in 1:net_size){
  dataliner[i]=str_extract(str_extract(datalines[i],'url="https(.*?).mp3'), 'https(.*?).mp3')  
}



write.csv(data.frame("url","Neutral_bar","Happy_bar","Sad_bar","Anger_bar","Fear_bar","time"),"./pod_lean5.csv")

# initializing vectors to represent average % each emotion in audio files

i=0
# List of all file names
R.utils::copyDirectory("./OpenVokaturi-4-0/",
                       "./.tmpdisk/POD_Auth/")

for (url in dataliner){
  file.remove("./.tmpdisk/POD_Auth/examples/current.mp3")
  file.remove("./.tmpdisk/POD_Auth/examples/hello.wav")
  download.file(url,"./.tmpdisk/POD_Auth/examples/current.mp3")
  py_run_file("./.tmpdisk/POD_Auth/examples/OpenVokaWavCurve.py")
  
  Neutral=mean(py$output$Neutral)
  Happy=mean(py$output$Happy)
  Sad=mean(py$output$Sad)
  Anger=mean(py$output$Anger)
  Fear=mean(py$output$Fear)
  sound_length=mean(py$output$Time)
  
  
  row2=data.frame(url,Neutral,Happy,Sad,Anger,Fear,sound_length)
  write.table(row2, file = "./pod_lean5.csv", sep = ",",
              append = TRUE,quote = FALSE,col.names = FALSE,row.names = FALSE)
}
# download.file("https://traffic.libsyn.com/atpfm/atp508.mp3","./.tmpdisk/POD_Auth/examples/current.mp3")

#https://omny.fm/shows/startalk-radio/playlists/podcast.rss
#https://feeds.megaphone.fm/stuffyoushouldknow
#https://feeds.soundcloud.com/users/soundcloud:users:236923839/sounds.rss
#https://www.omnycontent.com/d/playlist/2c72fd2a-9a3a-4472-9a57-abab0011fabb/8ac37957-6236-4524-a130-abad0082ba1d/d6b867cf-4c83-48f3-86ce-abad0082ba35/podcast.rss
