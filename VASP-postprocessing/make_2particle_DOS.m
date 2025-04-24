function [Ej,joint,delta_C] = make_2particle_DOS(E,dos,midpoint,dos2)
% E is the energy axis
%
% dos is the density of states (can be total or projected)
%
% midpoint is the dividing point for the DOS; make sure you use more points
% than you want to plot for each half, since xcorr will start introducing
% normalization errors outside this energy range 
%
% 4th variable is optional; useful if you want to test cross terms between
% up and down channels in spin-polarized calcs, for example
%
% BY DEFAULT: dos2 defines the UPPER range, i.e. the CONDUCTION band

midpoint = E > midpoint;
[~,in] = max(midpoint); % should extract the first maximum, which is = 1

skip = E(2)-E(1);

upper = dos(in:end);
if exist('dos2','var')
    % IF DOS2 IS PRESENT, IT IS THE CONDUCTION REGION
    upper = dos2(in:end);
end
Eup = E(in:end);

len = length(upper);
range = (in-len):(in-1);
try 
    lower = dos(range);
    Elo = E(range);
catch
    % this will account for if the lower range is less sampled than the
    % upper range
    range_lower = 1:in;
    lower = dos(range_lower);
    Elo = E(range_lower);
    len = length(lower);
    range_upper = (1:len) + in;
    upper = dos(range_upper);
    Eup = E(range_upper);
    if exist('dos2','var')
        % IF DOS2 IS PRESENT, IT IS THE CONDUCTION REGION
        upper = dos2(range_upper);
    end
end

% joint = xcorr(upper,lower,'none'); 
joint = conv(upper,flipud(lower));
Ej = 0:1:(length(joint)-1); 
Ej = skip*Ej;
if length(Ej) ~= length(joint)
    error('length(Ej) should equal length(joint)')
end

lower=flipud(lower);
delta_C = zeros(1,length(joint));
for i = 1:length(joint)
    sum_A = 0;
    sum_B = 0;
    for j = 1:length(upper)
        if i-j+1 > 0 && i-j+1 <= length(lower)
            sum_A = sum_A + (0.0001 * lower(i-j+1))^2;
            sum_B = sum_B + (0.0001 * upper(j))^2;
        end
    end
    delta_C(i) = sqrt(sum_A + sum_B);
end
% 
% 
% % **********************************************************************
% % check the above with various MATLAB functions and personal FFT method
% % **********************************************************************
% 
% % check all combinations of xcorr with upper as first input
% j1 = xcorr(upper,lower,'none');  % correct 
% j2 = xcorr(upper,flipud(lower),'none');  
% j3 = xcorr(flipud(upper),lower,'none'); 
% j4 = xcorr(flipud(upper),flipud(lower),'none'); 
% 
% % check all combinations of xcorr with lower as first input
% j5 = xcorr(lower,upper);
% j6 = xcorr(lower,flipud(upper));
% j7 = xcorr(flipud(lower),upper);
% j8 = xcorr(flipud(lower),flipud(upper)); % correct
% 
% % check all combinations of conv with upper as first input
% w1 = conv(upper,lower); 
% w2 = conv(upper,flipud(lower)); % correct 
% w3 = conv(flipud(upper),lower); 
% w4 = conv(flipud(upper),flipud(lower)); 
% 
% % check all combinations of conv with lower as first input
% w5 = conv(lower,upper);
% w6 = conv(lower,flipud(upper));
% w7 = conv(flipud(lower),upper); % correct
% w8 = conv(flipud(lower),flipud(upper));
% 
% % FFT check: (only valid for certain-length vector - just take the raw data
% % for now - not interpolated)
% newupper=zeros(2^14,1);
% newupper(1:length(upper)) = upper;
% newlower=zeros(2^14,1);
% newlower(end-length(upper)+1:end)=lower;
% newlower=flipud(newlower); 
% fftu=fft(newupper);
% fftl=fft(newlower);
% prod = fftu.*fftl;
% inv = ifft(prod); % correct by construction
% Einv = skip*(0:1:(length(inv)-1));

end