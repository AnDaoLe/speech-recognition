clear all;
clc;
close all;

addpath('mfcc');
addpath('voicebox');
addpath('samples');

%%
%%Convert wav files to MFCC for true values

%%convert true value for targets 'one''two''three''four''five'.
freq=readwav('true_one');
% mel=frq2mel(freq);
% mel=mel';
mel=melcepst(freq,11025, [], 1);
%need to create for statement for every cepstrum coefficients
plot (mel)

%end
y=pdf('Normal', mel, 0,1);
plot (mel);
lambda=(max(y)-min(y))/2;
for i=1:length(mel)
    if mel(i)>lambda
        for j=1:(length(mel)-i)
         
         %copy array
         target1(j,:) = mel(i+j);

        end
        break;
    end
end
target1= target1(1:1100,:);
target1=target1';


freq=readwav('true_two');
% mel=frq2mel(freq);
% mel=mel';
mel=melcepst(freq,11025, [], 1);
%need to create for statement for every cepstrum coefficients
plot (mel)

%end
y=pdf('Normal', mel, 0,1);
plot (mel);
lambda=(max(y)-min(y))/2;
for i=1:length(mel)
    if mel(i)>lambda
        for j=1:(length(mel)-i)
         
         %copy array
         target2(j,:) = mel(i+j);

        end
        break;
    end
end
target2= target2(1:1100,:);
target2=target2';


freq=readwav('true_three');
% mel=frq2mel(freq);
% mel=mel';
mel=melcepst(freq,11025, [], 1);
%need to create for statement for every cepstrum coefficients
plot (mel)

%end
y=pdf('Normal', mel, 0,1);
plot (mel);
lambda=(max(y)-min(y))/2;
for i=1:length(mel)
    if mel(i)>lambda
        for j=1:(length(mel)-i)
         
         %copy array
         target3(j,:) = mel(i+j);

        end
        break;
    end
end
target3= target3(1:1100,:);
target3=target3';


freq=readwav('true_four');
% mel=frq2mel(freq);
% mel=mel';
mel=melcepst(freq,11025, [], 1);
%need to create for statement for every cepstrum coefficients
plot (mel)

%end
y=pdf('Normal', mel, 0,1);
plot (mel);
lambda=(max(y)-min(y))/2;
for i=1:length(mel)
    if mel(i)>lambda
        for j=1:(length(mel)-i)
         
         %copy array
         target4(j,:) = mel(i+j);

        end
        break;
    end
end
target4= target4(1:1100,:);
target4=target4';


freq=readwav('true_five');
% mel=frq2mel(freq);
% mel=mel';
mel=melcepst(freq,11025, [], 1);
%need to create for statement for every cepstrum coefficients
plot (mel)

%end
y=pdf('Normal', mel, 0,1);
plot (mel);
lambda=(max(y)-min(y))/2;
for i=1:length(mel)
    if mel(i)>lambda
        for j=1:(length(mel)-i)
         
         %copy array
         target5(j,:) = mel(i+j);

        end
        break;
    end
end
target5= target5(1:1100,:);
target5=target5';
%%

%%Convert wav files to MFCC for true values

%read samples inputs for 'i'
for k=1:3
mel=melcepst(freq,11025, [], 1);
%need to create for statement for every cepstrum coefficients
plot (mel)

    %end
    y=pdf('Normal', mel, 0,1);
    plot (mel);
    lambda=(max(y)-min(y))/2;
    for i=1:length(mel)
        if mel(i)>lambda

                for j=1:(length(mel)-i)

                 %copy array
                 input1(j,k) = mel(i+j);

                end

            break;
        end
    end
end
input1= input1(1:1100,:);
input1=input1';

for k=1:3
freq=readwav(strcat('two', num2str(k)));
% mel=frq2mel(freq);
% mel=mel';
mel=melcepst(freq,11025, [], 1);
%need to create for statement for every cepstrum coefficients
plot (mel)

%end
  
    y=pdf('Normal', mel, 0,1);
    plot (mel);
    lambda=(max(y)-min(y))/2;
        for i=1:length(mel)
            if mel(i)>lambda

                    for j=1:(length(mel)-i)

                     %copy array
                     input2(j,k) = mel(i+j);

                    end

                break;
            end
        end
end
input2= input2(1:1100,:);
input2=input2';


for k=1:3
freq=readwav(strcat('three', num2str(k)));
% mel=frq2mel(freq);
% mel=mel';
mel=melcepst(freq,11025, [], 1);
%need to create for statement for every cepstrum coefficients
plot (mel)

%end
  
    y=pdf('Normal', mel, 0,1);
    plot (mel);
    lambda=(max(y)-min(y))/2;
        for i=1:length(mel)
            if mel(i)>lambda

                    for j=1:(length(mel)-i)

                     %copy array
                     input3(j,k) = mel(i+j);

                    end

                break;
            end
        end
end
input3= input3(1:1100,:);
input3=input3';


for k=1:3
freq=readwav(strcat('four', num2str(k)));
% mel=frq2mel(freq);
% mel=mel';
mel=melcepst(freq,11025, [], 1);
%need to create for statement for every cepstrum coefficients
plot (mel);

%end
  
    y=pdf('Normal', mel, 0,1)
    plot (mel);
    lambda=(max(y)-min(y))/2;
        for i=1:length(mel)
            if mel(i)>lambda

                    for j=1:(length(mel)-i)

                     %copy array
                     input4(j,k) = mel(i+j);

                    end

                break;
            end
        end
end
input4= input4(1:1100,:);
input4=input4';


for k=1:3
freq=readwav(strcat('five', num2str(k)));
% mel=frq2mel(freq);
% mel=mel';
mel=melcepst(freq,11025, [], 1);
%need to create for statement for every cepstrum coefficients
plot (mel)

%end
  
    y=pdf('Normal', mel, 0,1);
    plot (mel);
    lambda=(max(y)-min(y))/2;
        for i=1:length(mel)
            if mel(i)>lambda

                    for j=1:(length(mel)-i)

                     %copy array
                     input5(j,k) = mel(i+j);

                    end

                break;
            end
        end
end
input5= input5(1:1100,:);
input5=input5';
%combine input samples for one


%combin input samples for two


%combine inputs
net_input=[input1; input2; input3; input4; input5];
net_target=[target1; target2; target3; target4; target5];
%%

%%
%convert wav to MFCC for samples
freq=readwav('sample1');

mel=melcepst(freq,11025, [], 1);
%need to create for statement for every cepstrum coefficients
plot (mel)

%end
y=pdf('Normal', mel, 0,1);
plot (mel);
lambda=(max(y)-min(y))/2;
for i=1:length(mel)
    if mel(i)>lambda
        for j=1:(length(mel)-i)
         
         %copy array
         sample1(j,:) = mel(i+j);

        end
        break;
    end
end
sample1= sample1(1:1100,:);
sample1 = sample1';
%end
freq_2=readwav('sample2');
mel=melcepst(freq,11025, [], 1);
%need to create for statement for every cepstrum coefficients
plot (mel)

%end
y=pdf('Normal', mel, 0,1);
plot (mel);
lambda=(max(y)-min(y))/2;
for i=1:length(mel)
    if mel(i)>lambda
        for j=1:(length(mel)-i)
         
         %copy array
         sample2(j,:) = mel(i+j);

        end
        break;
    end
end
sample2= sample2(1:1100,:);
sample2 = sample2';
%end
% Trains neural nets
net = patternnet(10);
net.trainParam.epochs=30;
 net.trainParam.goal=1e-6 ;
 net.divideParam.trainRatio=.7;
 net.divideParam.valRatio=.15;
 net.divideParam.testRatio=.15;

[net,pr]=train(net,net_input,net_target);
output=net(net_input);
testIndices = vec2ind(net_target);
%figure, plotconfusion;
%figure(2),plotroc;
%[c,cm]=confusion;
%fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
%fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);

perf = perform(net,output,net_target)
plot(sample1');
hold on
plot(input1(1:3,:)');
disp('done');
%if cm(1) > cm(2)
%
%end