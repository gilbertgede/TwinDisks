clear all; close all;

for ii = 1:1:20
    tfina = 3*pi/ii;
    TwinDisksConstraintForces(ii,tfina)
    data = load('TwinDisksConstraintForces.1');
    data = load('TwinDisksConstraintForces.1');
    figure(1),plot(ii,min(data(:,26)),'.',ii,min(data(:,29)),'.'), hold on
    figure(1),plot(ii,max(data(:,26)),'.',ii,max(data(:,29)),'.'), hold on
    figure(2),plot(ii,min(data(:,24)),'.',ii,min(data(:,27)),'.'), hold on
    figure(2),plot(ii,max(data(:,24)),'.',ii,max(data(:,27)),'.'), hold on
    figure(3),plot(ii,min(data(:,25)),'.',ii,min(data(:,28)),'.'), hold on
    figure(3),plot(ii,max(data(:,25)),'.',ii,max(data(:,28)),'.'), hold on
    
end

figure(1), plot([1 20],[0 0]), hold on