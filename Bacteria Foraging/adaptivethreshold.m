function bw2=adaptivethreshold(im,ws,C,m) 
%   threshold mean-C or median-C to the image im.
%  ws is the local window size.
%  m is 0 or 1, m=0 mean(default)m=1 median.

if (nargin<3)
    error('You must provide the image im, the window size ws, and C.');
elseif (nargin==3)
    m=0;
elseif (m~=0 && m~=1)
    error('m must be 0 or 1.');
end
im=mat2gray(im);

if m==0
    im2=imfilter(im,fspecial('average',ws),'replicate');
else
    im2=medfilt2(im,[ws ws]);
end
im3=im2-im-C;
bw=im2bw(im3,0);
bw1=imcomplement(bw);
bw2=bwmorph(bw1,'thick');


