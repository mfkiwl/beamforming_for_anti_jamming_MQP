function [yURA, w] = beamformerMVDR(ura, x, noise, doas, t, carrierFreq, propagation_path, show_plots, loc_rx)
% beamformerMVDR takes in URA and DoA and outputs signal and weights
% figure;
% plot(abs(x))

mvdrbeamformer = phased.MVDRBeamformer('SensorArray',ura,...
    'Direction',doas,'OperatingFrequency',carrierFreq,...
    'TrainingInputPort',true,'WeightsOutputPort',true);
% rxSignal = x + noise; 
% [yURA, w]= mvdrbeamformer(rxSignal, noise);

[yURA, w]= mvdrbeamformer(x,noise);


if (show_plots & loc_rx == [-46;-2;0])
    fig= figure;
    set(fig, 'Color', 'w');
    plot(t,abs(yURA));
    axis tight;
    % title('Output of MVDR Beamformer','FontSize',18);
    % subtitle(s)
    xlabel('Time (s)','FontSize',16,'Color', 'w');
    ylabel('Magnitude (V)', 'FontSize',16,'Color', 'w');
    xlim([0 0.3])
    ylim([0 0.2])
    set(gca,'fontsize', 16,'FontName', 'Times New Roman')
    ax = gca;
    ax.XColor = 'k';
    ax.YColor = 'k';
end
if (show_plots & loc_rx == [-2;18;0])
    fig = figure;
    set(fig, 'Color', 'w');
    p = pattern(ura, carrierFreq, -90:90, 0 ,'Weights', w,'Type','powerdb',...
        'PropagationSpeed',physconst('LightSpeed'),'Normalize',false,...
        'CoordinateSystem','rectangular');
    % p = pattern(ura, carrierFreq, -90:90, 0 ,'Weights', w,'Type','powerdb',...
    %     'PropagationSpeed',physconst('LightSpeed'),...
    %     'CoordinateSystem','polar');
    angles = -90:1:90;
    plot(angles, p,'LineWidth',1.5)
    xlim([-90 90])
    xticks(-90:45:90)
    % title('Beam Pattern','FontSize',18);
    xlabel('Azimuth Angle (degrees)', 'FontSize',16,'FontWeight','bold')
    ylabel('Power (dB)', 'FontSize',16,'FontWeight','bold')
    set(gca,'fontsize', 16,'FontName', 'Times New Roman')
    ax = gca;
    ax.XColor = 'k';
    ax.YColor = 'k';
    grid on

    % figure;
    % polarpattern(p);
    % % thetalim([-90 90])
    % title('MVDR Beam Pattern');
end

end
