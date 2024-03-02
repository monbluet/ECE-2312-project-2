% Sampling rate (use the same as in your speech recording)
Fs = 44100; 

% Time duration equal to your speech file
speechDuration = 5; 

% Frequency of the sine tone
f = 5000; % 5000 Hz
t = 0:1/Fs:speechDuration; % time vector
sineTone = sin(2*pi*f*t);
sound(sineTone, Fs);
filename = 'td-sinetone.wav'; 
audiowrite(filename, sineTone, Fs);
figure;
spectrogram(sineTone, 256, [], [], Fs, 'yaxis');
title('Spectrogram of Sine Tone');
xlabel('Time (s)');
ylabel('Frequency (Hz)');




% Time duration equal to your speech file
speechDuration = 5; 
% Frequency range for chirp signal
f_start = 0; % Start frequency of chirp
f_end = 8000; % End frequency of chirp
t_chirp = 0:1/Fs:speechDuration; % time vector for chirp
chirpSignal = chirp(t_chirp, f_start, speechDuration, f_end);
sound(chirpSignal, Fs);

filename_chirp = 'td-chirp.wav'; 
audiowrite(filename_chirp, chirpSignal, Fs);

figure;
spectrogram(chirpSignal, 256, [], [], Fs, 'yaxis');
title('Spectrogram of Chirp Signal');
xlabel('Time (s)');
ylabel('Frequency (Hz)');

t_cetk = 0:1/Fs:speechDuration; % time vector for CETK-like pattern
cetkPattern = sin(2*pi*linspace(0, 8000, length(t_cetk)).*t_cetk);
sound(cetkPattern, Fs);
filename_cetk = 'td-cetk.wav';  
audiowrite(filename_cetk, cetkPattern, Fs);

figure;
spectrogram(cetkPattern, 256, [], [], Fs, 'yaxis');
title('Spectrogram of CETK-like Sine Tone Pattern');
xlabel('Time (s)');
ylabel('Frequency (Hz)');






teamNumber = 'td';

% Load the speech file
speechFilename = 'stereo_audio_1.wav'; 
[speech, Fs_speech] = audioread(speechFilename);

% Generate a chirp signal with a frequency range from 0 Hz to 5000 Hz
t_chirp = 0:1/Fs_speech:length(speech)/Fs_speech; % Time vector for chirp
frequencies_chirp = linspace(0, 5000, length(t_chirp));
chirpSignal = sin(2*pi*frequencies_chirp.*t_chirp);

% Make both signals the same length
minLength = min(length(speech), length(chirpSignal));
speech = speech(1:minLength);
chirpSignal = chirpSignal(1:minLength);

% Add the chirp signal to the speech signal
resultingSignal = speech + chirpSignal;

% Play the resulting signal
sound(resultingSignal, Fs_speech);
% Normalize the resulting signal
resultingSignal = resultingSignal / max(abs(resultingSignal));

% Save the resulting signal to a WAV file
filename_result = [teamNumber '-speechchirp.wav'];
audiowrite(filename_result, resultingSignal, Fs_speech);

% Plot the spectrogram of the resulting signal
figure;
spectrogram(resultingSignal, 256, [], [], Fs_speech, 'yaxis');
title('Spectrogram of Resulting Signal');
xlabel('Time (s)');
ylabel('Frequency (Hz)');









% Design a lowpass filter with a cut-off frequency of 4000 Hz
cutoffFrequency = 4000;
filterOrder = 100;
lowpassFilter = designfilt('lowpassfir', 'FilterOrder', filterOrder, 'CutoffFrequency', cutoffFrequency, 'SampleRate', Fs_speech);

% Apply the filter to the combined signal
filteredSignal = filter(lowpassFilter, resultingSignal);

% Play the resulting filtered signal
sound(filteredSignal, Fs_speech);

% Save the resulting filtered signal to a WAV file
filename_filtered = [teamNumber '-filteredspeechsine.wav'];
audiowrite(filename_filtered, filteredSignal, Fs_speech);

% Plot the spectrogram of the resulting filtered signal
figure;
spectrogram(filteredSignal, 256, [], [], Fs_speech, 'yaxis');
title('Spectrogram of Filtered Speech and Sine Tone Signal');
xlabel('Time (s)');
ylabel('Frequency (Hz)');





% Load the speech file
[speech, Fs_speech] = audioread(speechFilename);

% Generate a chirp signal with a frequency range from 0 Hz to 5000 Hz
t_chirp = 0:1/Fs_speech:length(speech)/Fs_speech; % Time vector for chirp
frequencies_chirp = linspace(0, 5000, length(t_chirp));
chirpSignal = sin(2*pi*frequencies_chirp.*t_chirp);

% Make both signals the same length
minLength = min(length(speech), length(chirpSignal));
speech = speech(1:minLength);
chirpSignal = chirpSignal(1:minLength);

% Combine the speech and chirp signals for stereo audio
stereoSignal = [speech, chirpSignal];

% Play the resulting stereo signal
sound(stereoSignal, Fs_speech);

% Save the resulting stereo signal to a WAV file
filename_stereo = [teamNumber '-stereospeechsine.wav'];
audiowrite(filename_stereo, stereoSignal, Fs_speech);

% Plot the spectrograms for each audio channel
figure;

% Left channel (speech)
subplot(2, 1, 1);
spectrogram(speech, 256, [], [], Fs_speech, 'yaxis');
title('Left Channel Spectrogram (Speech)');
xlabel('Time (s)');
ylabel('Frequency (Hz)');

% Right channel (speech with sine tone)
subplot(2, 1, 2);
spectrogram(chirpSignal, 256, [], [], Fs_speech, 'yaxis');
title('Right Channel Spectrogram (Speech with Sine Tone)');
xlabel('Time (s)');
ylabel('Frequency (Hz)');



