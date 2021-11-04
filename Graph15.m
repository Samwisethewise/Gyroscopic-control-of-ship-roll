clear  %clear workspace
close all
%%---------------------roll at 15 degrees---------------------
Roll_15_data;
TFmax = islocalmax(roll15);
TFmin = islocalmin(roll15);
subplot(3,1,1);
plot(time15,roll15,time15(TFmax),roll15(TFmax),'r*',time15(TFmin),roll15(TFmin),'r*')
title('Roll decay at 15 deg')
ylabel('Roll angle in degrees')
xlabel('Time Seconds')
r15max = roll15(TFmax);
t15max = time15(TFmax);
r15min = roll15(TFmin);
t15min = time15(TFmin);
%hold on
%%---------------------roll at 10 degrees---------------------
Roll_10_data;
TFmax = islocalmax(roll10);
subplot(3,1,2);
plot(time10,roll10,time10(TFmax),roll10(TFmax),'r*',time10(TFmin),roll10(TFmin),'r*')
title('Roll decay at 10 deg')
ylabel('Roll angle in degrees')
xlabel('Time Seconds')
r10max = roll10(TFmax);
t10max = time10(TFmax);
r10min = roll10(TFmin);
t10min = time10(TFmin);
%hold on
%%---------------------roll at 5 degrees---------------------
Roll_5_data;
TFmax = islocalmax(roll5);
subplot(3,1,3);
plot(time5,roll5,time5(TFmax),roll5(TFmax),'r*',time5(TFmin),roll5(TFmin),'r*')
title('Roll decay at 5 deg')
ylabel('Roll angle in degrees')
xlabel('Time Seconds')
r5max = roll5(TFmax);
t5max = time5(TFmax);
r5min = roll5(TFmin);
t5min = time5(TFmin);
%hold on

%%----------------------plot roll decay------------------------
figure
plot(t15max,r15max)
hold on
plot(t10max,r10max)
hold on
plot(t5max,r5max)
hold on
title('Roll decay slope')
legend('15 degrees','10 degrees','5 degrees')
ylabel('Roll angle in degrees')
xlabel('Time Seconds')

%%---------------------mean phi---------------------------------
for i=1:length(r15min)
phim15(i) = (abs(r15max(i))+ abs(r15min(i)))/2;
end

for i=1:length(t10min)
phim10(i) = (abs(r10max(i))+ abs(r10min(i)))/2;
end

for i=1:length(r5min)
phim5(i) = (abs(r5max(i))+ abs(r5min(i)))/2;
end

%%---------------------log-------------------------------------

for i=1:length(t15min)
        philog15(i) = (1/(t15min(i))- t15max(i))*log((abs(r15max(i))/abs(r15min(i))));%(abs(r15max(i))+ abs(t15max(i)))/2;
end

for i=1:7
        philog10(i) = (1/(t10min(i))- t10max(i))*log((abs(r10max(i))/abs(r10min(i))));%(abs(r15max(i))+ abs(t15max(i)))/2;
end

for i=1:length(r5min)
        philog5(i) = (1/(t5min(i))- t5max(i))*log((abs(r5max(i))/abs(r5min(i))));%(abs(r15max(i))+ abs(t15max(i)))/2;
end

%------------------calculate dampening coeficent------------------------
B15 = mean(gradient(phim15,philog15));
B10 = mean(gradient(phim10,philog10));
B5 = mean(gradient(phim5,philog5));

%------------------------plot dampening slope---------------------------
figure
subplot(3,1,1);
plot (phim15,philog15,'*')
title('equivelent dampening coeficient 15 degrees log')
Legend1 = compose('Equivalent B is %f', B15);
legend(Legend1)
subplot(3,1,2);
plot (phim10,philog10,'*')
title('equivelent dampening coeficient 10 degrees log')
Legend1 = compose('Equivalent B is %f', B10);
legend(Legend1)
subplot(3,1,3);
plot (phim5,philog5,'*')
title('equivelent dampening coeficient 5 degrees log')
Legend1 = compose('Equivalent B is %f', B5);
legend(Legend1)
%%---------------------lin-------------------------------------


for i=1:length(t15min)
        philin15(i) = ((r15max(i))- r15min(i))/((t15max(i))- t15min(i));
end

for i=1:length(t10min)
        philin10(i) = ((r10max(i))- r10min(i))/((t10max(i))- t10min(i));
end

for i=1:length(t5min)
        philin5(i) = ((r5max(i))- r5min(i))/((t5max(i))- t5min(i));
end

%----------------------calculate restoring force--------------------
C15 = mean(gradient(phim15,philin15));
C10 = mean(gradient(phim10,philin10));
C5 = mean(gradient(phim5,philin5));

%---------------------------plot restoring force---------------------
figure
subplot(3,1,1);
plot (phim15,philin15,'*')
title('Roll restoring coeficient 15 degrees lin')
Legend1 = compose('Equivalent C is %f', C15);
legend(Legend1)
subplot(3,1,2);
plot (phim10,philin10,'*')
title('Roll restoring coeficient 10 degrees lin')
Legend2 = compose('Equivalent C is %f', C10);
legend(Legend2)
subplot(3,1,3);
plot (phim5,philin5,'*')
title('Roll restoring coeficient 5 degrees lin')
Legend3 = compose('Equivalent C is %f', C5);
legend(Legend3)




