library(reticulate)
use_python("/usr/local/bin/python3")

sys<-import ("sys")
scipy.io.wavfile<-import ("scipy.io.wavfile")

print(sys$path)
Vokaturi<-import_from_path("Vokaturi", path = "/Users/admin/Desktop/OpenVokaturi-4-0/api")

print ("Loading library...")
platform<-import ("platform")
struct<-import ("struct")
Vokaturi$load("../lib/open/macos/OpenVokaturi-4-0-mac.dylib")


print ("Reading sound file...")
file_name = "hello.wav"
sample_rate= scipy.io.wavfile$read(file_name)[1]
samples = scipy.io.wavfile$read(file_name)[2]
print (paste("   sample rate %.3f Hz", sample_rate))

print ("Allocating Vokaturi sample array...")
buffer_length = length(samples)
print (paste("   ",buffer_length," samples, ",samples$ndim," channels"))
c_buffer = Vokaturi$float64array(sample_rate)
print ("Creating VokaturiVoice...")
voice = Vokaturi$Voice (sample_rate, buffer_length, 0)

numberOfSeconds = int (buffer_length / sample_rate)
print ("    Start(s)    End(s)    Neutral     Happy       Sad       Angry       Fear")

for (isecond in range(0, numberOfSeconds)){
  startSample = round(isecond*sample_rate)
  endSample = round((isecond+1)*sample_rate)
  if (samples$ndim == 1){  # mono
    c_buffer = samples[startSample:endSample] / 32768.0
  }else{  # stereo
  c_buffer = 0.5*(samples[startSample:endSample,0]+0.0+samples[startSample:endSample,1]) / 32768.0
  }
  voice.fill_float64array(sample_rate, c_buffer)

  quality = Vokaturi$Quality()
  emotionProbabilities = Vokaturi.EmotionProbabilities()
  voice.extract(quality, emotionProbabilities)

  if (quality$valid){
  print (round(isecond,3), round(isecond + 1,3),
			   round(emotionProbabilities$neutrality,3),
         round(emotionProbabilities$happiness,3),
         round(emotionProbabilities$sadness,3),
         round(emotionProbabilities$anger,3),
         round(emotionProbabilities$fear,3))
  }
}
voice$destroy()
