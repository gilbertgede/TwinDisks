clear all; close all;


for i = .1:.1:20
    tfina = 4*pi/i;
    TwinDisksEig(i,tfina)
    data = load('TwinDisksEig.1');
    time = data(:,1);
    spin = data(:,46);
    speed = data(:,18);
    ind = find(spin > 2*pi,1);
    if (isempty(ind))
        spin = spin(1:end);
        ind = find(spin > 0 & speed < 0,1);
        spin2 = spin(ind:end);
        speed2 = speed(ind:end);
        ind2 = find(spin2 > 0 & speed2 > 0,1);
        speed = speed(1:ind+ind2);
        time = time(1:ind+ind2);
    else
        speed = speed(1:ind);
        time = time(1:ind);
    end
    figure(1), plot3(i*ones(length(speed),1),time/time(end),speed/i), hold on
    xlabel('Initial Speed (rad/s)');
    ylabel('Normalized Time');
    zlabel('Normalized Gen. Speed');
end