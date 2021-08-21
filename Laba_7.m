clc;
clear all;
close all;
fid = fopen('Learning_data3.txt', 'r');
learn = fscanf(fid, '%g %g %g %g %g %g %g %g', [8 inf]);
fclose(fid);

V = [1 10;1 10; 1 10; 1 10; 1 10; 1 10; 1 10; 1 10];
net = newsom(V,[2 2]); 
net.trainParam.epochs = 1000; 
net = train(net, learn);
W = sim(net,learn); 
clusters = vec2ind(W);

fid = fopen('PCA_data3.txt', 'r');
X = fscanf(fid, '%g %g ', [2 inf]);
fclose(fid);
figure;
gscatter(X(1,:), X(2,:), clusters(1,:))

number1 = 1; number2 = 1; number3 = 1; number4 = 1;
C1 = zeros(2); C2 = zeros(2); C3 = zeros(2); C4 = zeros(2);
clust1 = zeros(8); clust2 = zeros(8); clust3 = zeros(8); clust4 = zeros(8);
for i = 1:length(clusters)
    if(clusters(i) == 1)
        C1(number1,:) = X(:,i);
        clust1(number1,:) = learn(:,i);
        number1 = number1 + 1;
    end
    if(clusters(i) == 2)
        C2(number2,:) = X(:,i);
        clust2(number2,:) = learn(:,i);
        number2 = number2 + 1;
    end
    if(clusters(i) == 3)
        C3(number3,:) = X(:,i);
        clust3(number3,:) = learn(:,i);
        number3 = number3 + 1;
    end
    if(clusters(i) == 4)
        C4(number4,:) = X(:,i);
        clust4(number4,:) = learn(:,i);
        number4 = number4 + 1;
    end
end
number1 = number1 - 1; number2 = number2 - 1; number3 = number3 - 1; number4 = number4 - 1;

mean_pca(1,:) = mean(C1);
mean_pca(2,:) = mean(C2);
mean_pca(3,:) = mean(C3);
mean_pca(4,:) = mean(C4);

figure
gscatter(X(1,:),X(2,:),clusters);
hold on
plot(mean_pca(:,1),mean_pca(:,2),'*');
hold off

M(1,:) = mean(clust1);
M(2,:) = mean(clust2);
M(3,:) = mean(clust3);
M(4,:) = mean(clust4);

figure
plot(M(1, :),'r');
hold on
plot(M(2, :),'g');
plot(M(3, :),'b');
plot(M(4, :),'black');
title('Средние значения признаков');
figure
for i=1:4
    subplot(2, 2, i);
    plot(M(i, :));
    axis([1 8 1 10]);
    title(['Cluster №:',num2str(i)]);
end