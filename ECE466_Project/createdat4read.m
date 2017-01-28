%%creates a dat file
clear all;
clc;
close all;

addpath('mfcc');
addpath('voicebox');
addpath('samples');

[d,fs,nb]=readwav('one1.wav');
fid=fopen('one1.dat', 'wb');
fwrite(fid, d, 'float32');
fclose(fid);

% read back data
fid = fopen('one1.dat','rb');

% done, Enjoy

