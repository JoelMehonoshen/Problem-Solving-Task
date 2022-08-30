Data0 = importdata('sample2022.txt');
figure
tiledlayout(1,2)
nexttile
n = 40;
[frequency,edges] = histcounts(Data0,n);
binsize = edges(2)- edges(1);
histogram(Data0,edges)
title('Data0 - Bins ='+string(n))
ylabel('Bin Frequency')
xlabel('Bin values')
nexttile

frequency = frequency/500;

cumulativeFreq = zeros(1,n+1);
for i = 1:n
    for j = 1:i
        cumulativeFreq(i+1) = cumulativeFreq(i)+frequency(j);
    end
end

seed = 115;
rng(seed)
u = rand(1,500);
DataNew = zeros(1,500);

for j=1:500
        for i = 2:n + 1
        if u(j) <= cumulativeFreq(i) 
        x1 = (i*binsize)+edges(1);
        x2 = (i*binsize)+edges(1)+binsize;
        y1 = cumulativeFreq(i-1);
        y2 = cumulativeFreq(i);
         DataNew(j) = (u(j)-y1)*(x2-x1/y2-y1)+x1;
        break
        end
    end
end

histogram(DataNew,edges)

title('DataNew - Bins ='+string(n))
ylabel('Bin Frequency')
xlabel('Bin values')

frequencyNew = histcounts(DataNew,n);
frequencyNew = frequencyNew/500;


DKL = 0;
for i=1:n
    DKL = DKL + frequencyNew(i)*log(frequencyNew(i)/frequency(i));
end
DKL