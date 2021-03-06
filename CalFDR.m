%This script will generate a raster of first derivatives of calcium
%transients that are likely a much closer estimation to spiking events than
%the significant transients (red portions of traces) given by the Romano
%Toolbox because they do not include the decay period as part of the
%spiking event.
%
%Best to run TIFF stack through ImageJ Kalman stack filter with default
%settings (0.8 gain) before doing any processing in the Romano Toolbox

%Load the _RASTER file generated by ProcessFluorescenceTraces.m

difDFF = diff(deltaFoF);
numcells = size(deltaFoF,2); 
emptyrow = zeros(1,numcells);
difDFF = [emptyrow;difDFF];
rasterSig = find(raster);
difDFFnoise = difDFF;
difDFFnoise(rasterSig) = NaN;
stdnoise = nanstd(difDFFnoise);
sigthresh = 2.5 .* stdnoise; %2.5 works well for picking up most real activity without too much noise when tiff stack is kalman-filtered

significantTransients = difDFF - sigthresh;

%difDFFminusSTD = difDFF - stdnoise; %comment this out if subtracting a multiple of std of noise
%significantTransients = difDFF; %comment this out if subtracting a multiple of std of noise
significantTransients(significantTransients>0) = 1;
significantTransients(significantTransients<=0) = 0;
rasterNotSig = find(~raster);

significantTransients(rasterNotSig) = 0;
figure
imagesc(significantTransients')

%save('_FDR','significantTransients')  
%insert filename and uncomment above to save
%Re-run ProcessFluorescenceTraces.m, this time choosing the 'Import Data' option for detecting significant transients,
%and select the '_FDR' file just saved. The red portions of the traces should now be restricted to the rising portions
%of the transients. The significance threshold for noise subtraction (line 20) may need to be adjusted for your data.
