%% Description
% Author: Atanu Sarkar
% Starting date: 10/08/2018 08:21 PM
% v1.0
% Implementing 'play command' feature of Wolfram Mathematica in MATLAB

%% configure signal settings
 duration = 6;                          % duration in seconds
 amplitude = 1;                         % amplitude
 f = 420;                               % frequency in Hertz
 phi = 2*pi*0;                          % phase offset, e.g.: 2*pi*0.25 = 1/4 cycle
 %% configure output settings
 fs = 32000;                            % sampling rate
 T = 1/fs;                              % sampling period
 t = 0:T:duration-T;                    % time vector
 %% create the signal
 omega = 2*pi*f;                        % angular frequency in radians
 
%Few Waveforms:
  %signal=amplitude*sin(omega*t + phi);
  %signal=amplitude*cos(omega*t + phi);
  %signal=amplitude*tan(omega*t + phi);
  %signal=amplitude*square(omega*t + phi);
  %triangle??
  %signal=amplitude*sawtooth(omega*t + phi);
  %signal=amplitude*diric(omega*t + phi,3);
  
  %signal=amplitude*pulstran(t,0:1/800:800,'tripuls');
  
%Few Functions related to waves and functions
  %gauspuls(t,fc,bw)
  %pulstran(t,d,'func')
  
 %signal=(cos(t).*exp(t)).*sin(omega*t.*t + phi);
 %signal=amplitude*sin(omega*sin(10*t.*t) + phi);
 %signal=amplitude*sin(omega*t + phi)+amplitude*cos(omega*t + phi)
 %syms n
 %signal = double(symsum((sin((1-1/n*n)*omega*t) + sin((1/4-1/n*n)*omega*t)),n,2,10)); 
 
 %signal=amplitude*tan(omega*t + phi);
 %signal=exp(-t).*sawtooth(omega*-t) ;
 %signal=amplitude*sin(10000*omega.*t + phi) + 0.1*cos(0.1*omega.*t + phi);
 
 
 
 signal=10*sin(omega*t.*t) + -5*sin(3*omega*t) + sin(5*omega*t.*t.*t) + 30*sin(7*omega*t) + sin(9*omega./t);
 
 
 
 
 
 
 %% plot the signal
 
 subplot(2,1,1);
 %  Time-Domain
 plot(t, signal);
 xlabel('Time (seconds) --->');
 ylabel('amplitude --->');
 title('Sound Signal in Time-Domain');
 
 subplot(2,1,2);
 %  Frequency-Domain
 fSignal=fft(signal);                   % taking fourier transform
 fSignal=fftshift(fSignal);             % rearranges by shifting to the center
 ff=(fs/2*linspace(-1,1,duration*fs));  % calculate frequency axis defined by fs
 fSignal=abs(fSignal);                  % taking only the magnitude of the complex signal
 plot(ff, fSignal);              
 xlabel('Frequency (Hz) --->');
 ylabel('magnitude --->');
 title('Sound Signal in Frequency-Domain');
 %% play the signal
  sound(signal, fs);
 %% save signal as stereo wave file
 %  stereo_signal = [x1; x1]';
 %  audiowrite(stereo_signal, fs, 'test.wav');