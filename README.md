# CalFDR
First-derivative rasterization of fluorescence traces produced with the Romano calcium imaging toolbox

This script will rasterize fluorescence traces generated with the Romano et al. calcium imaging toolbox (https://github.com/zebrain-lab/Toolbox-Romano-et-al) according to the period during which the fluorescence is increasing (positive first derivative of the fluorescence trace). This limits the '1's in the raster to imaging frames during which neurons are most likely active, rather than including the less relevant fluorescence decay period. The method is based on that used in a paper by Carrillo-Reid et al. (https://www.ncbi.nlm.nih.gov/pubmed/18184883)
