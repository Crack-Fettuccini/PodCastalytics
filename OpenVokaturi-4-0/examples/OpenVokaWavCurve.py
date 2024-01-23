import sys
import pandas
import scipy.io.wavfile
import subprocess
import os
import librosa

sys.path.append("../api")
import Vokaturi

# print ("Loading library...")
import platform
import struct
if platform.system() == "Darwin":
    assert struct.calcsize ("P") == 8
    Vokaturi.load("../lib/open/macos/OpenVokaturi-4-0-mac.dylib")
elif platform.system() == "Windows" or platform.system() == "CYGWIN_NT-10.0-19044":
    if struct.calcsize ("P") == 4:
        # print("32-bit Python")
        Vokaturi.load("../lib/open/win/OpenVokaturi-4-0-win32.dll")
    else:
        assert struct.calcsize ("P") == 8
        Vokaturi.load("../lib/open/win/OpenVokaturi-4-0-win64.dll")
elif platform.system() == "Linux":
    assert struct.calcsize ("P") == 8
    Vokaturi.load("../lib/open/linux/OpenVokaturi-4-0-linux.so")
# print ("Analyzed by: %s" % Vokaturi.versionAndLicense())
sys.path.append(os.path.dirname(os.path.realpath(__file__)))
subprocess.call(['ffmpeg', '-i', './current.mp3',
                 './hello.wav'])
# print ("Reading sound file...")
file_name = "./hello.wav"
(sample_rate, samples) = scipy.io.wavfile.read(file_name)
# print ("   sample rate %.3f Hz" % sample_rate)

# print ("Allocating Vokaturi sample array...")
buffer_length = len(samples)
# print ("   %d samples, %d channels" % (buffer_length, samples.ndim))
c_buffer = Vokaturi.float64array(sample_rate)
# print ("Creating VokaturiVoice...")
voice = Vokaturi.Voice (sample_rate, buffer_length, 0)

numberOfSeconds = int (buffer_length / sample_rate)
# print ("    Start(s)    End(s)    Neutral     Happy       Sad       Angry       Fear")
outer=[]
for isecond in range(0, numberOfSeconds):
    startSample = round(isecond*sample_rate)
    endSample = round((isecond+1)*sample_rate)
    if samples.ndim == 1:  # mono
        c_buffer[:] = samples[startSample:endSample] / 32768.0
    else:  # stereo
        c_buffer[:] = 0.5*(samples[startSample:endSample,0]+0.0+samples[startSample:endSample,1]) / 32768.0

    voice.fill_float64array(sample_rate, c_buffer)

    quality = Vokaturi.Quality()
    emotionProbabilities = Vokaturi.EmotionProbabilities()
    voice.extract(quality, emotionProbabilities)

    if quality.valid:
        # print("%10.3f" % isecond, "%10.3f" % (isecond + 1),
        #       "%10.3f" % emotionProbabilities.neutrality,
        #       "%10.3f" % emotionProbabilities.happiness,
        #       "%10.3f" % emotionProbabilities.sadness,
        #       "%10.3f" % emotionProbabilities.anger,
        #       "%10.3f" % emotionProbabilities.fear)
        inner = [isecond, isecond+1,
                 round(emotionProbabilities.neutrality, 3),
                 round(emotionProbabilities.happiness, 3),
                 round(emotionProbabilities.sadness, 3),
                 round(emotionProbabilities.anger, 3),
                 round(emotionProbabilities.fear, 3),
                 librosa.get_duration(filename='./hello.wav')]
        outer.append(inner)
output = pandas.DataFrame(outer)
output.columns = ['Start_sec', 'End_sec', 'Neutral', 'Happy', 'Sad', 'Anger', 'Fear', 'Time']
print(output)
voice.destroy()
