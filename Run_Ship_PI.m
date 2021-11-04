Getdata = 1;
Graph15
%close all

% Run wave using simulink
t = 500;
e = 0.05;
w = 1;

B = [B15 B10 B5];
C = [C15 C10 C5];

%Ship dynamics
Is = ((1/12)*2)+(0.5+0.6^2);
Bs = mean(B);
Cs = abs(mean(C));

% Kg being spinning angular momentum
%used to choose motor/gyro
Wspin = 300;
Ispin = 0.1;
Kg = Wspin*Ispin;


%gyro dynamics
Ig = Ispin/2;
Bg = 1;
Cg = 1;

% Contoller gains proportinal and derivitive
Kp = 30;
Kd = 600;


figure


%Controller on
a = sim('Ship_PI', t);
Time = a.get('tout');
wave = a.get('Waveheight');
roll = a.get('Rollangle');
subplot(2,1,1)
plot(Time,wave,'r')
title('Swell')
xlabel('Time Seconds')
ylabel('Wave height in M')
subplot(2,1,2)
plot(Time,roll)
title('Roll')
ylabel('Roll angle in degrees')
xlabel('Time Seconds')

figure

% Controller without power
Wspin = 1;
Ispin = 1;
Kg = Wspin*Ispin;

Ig = 1;

% Controller off
a = sim('Ship_PI', t);
Timeoff = a.get('tout');
rolloff = a.get('Rollangle');

plot(Time,roll)
hold on
plot(Timeoff,rolloff)
title('Roll reduction')
ylabel('Roll angle in degrees')
xlabel('Time Seconds')
legend('Controlled','Not controlled')

figure
a = sim('Ship_PI', 100);
Timeend = a.get('tout');
waveend = a.get('Waveheight');
plot(Timeend,waveend,'b')
title('Swell')
xlabel('Time Seconds')
ylabel('Wave height in M')
