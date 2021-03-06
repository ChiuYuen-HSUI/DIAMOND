%
%  Name: DIresults
% 
%  Usage: DIresults
% 
%   Description:
%     -outputs the Damage index
%   inputs:
%	
%
%  Version PJC960521
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This matlab source code was originally     %
% developed as part of "DIAMOND" at          %
% Los Alamos National Laboratory. It may     %
% be copied, modified, and distributed in    %
% any form, provided:                        %
%  a) This notice accompanies the files and  %
%     appears near the top of all source     %
%     code files.                            %
%  b) No payment or commercial services are  %
%     received in exchange for the code.     %
%                                            %
% Original copyright is reserved by the      %
% Regents of the University of California,   %
% in addition to Scott W. Doebling, Phillip  %
% J. Cornwell, Erik G. Straser, and Charles  %
% R. Farrar.                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DImin=[];
if exist('diropt')==0,diropt=1;end;
textin=DItext(xfp,yfp,DI,diropt,2,2,islopt);

%
%  set up figure
%
figDIresults=figure( ...
    'Name','Strain Energy/Damage Index Method Results', ...
    'NumberTitle','off', ...
    'visible','on', ...
    'Resize','on');
set(figDIresults,'Position',[230 88 500 420]);

%====================================
% General buttons parameters
%====================================
top=.95;
left=.80;
btnwd=.19;
btnht=.06;
spacing=.01;

%====================================
% Set up the console frame
%=====================================
frmborder=0.01;
ypos=.05-frmborder;
frmpos=[left-frmborder ypos btnwd+2*frmborder .9+2*frmborder];
   uicontrol(figDIresults, ...
        'Style','Frame', ...
        'units','normalized', ...
        'Position',frmpos, ...
        'Visible','on', ...
        'BackgroundColor',[.5 .5 .5]);

%
% Display all
%
btnnum=1;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht];
  uicontrol(figDIresults, ...
      'style','pushbutton', ...
      'units','normalized', ...
      'position',btnpos, ...
      'string','Display All', ...
      'visible','on', ...
      'Callback', ...
	['textin=DItext(xfp,yfp,DI,diropt,1,DImin,islopt);', ...
	'htextDI=ERAtslid(haxDI,textin,htextDI,hslidDI);']);

%
%  For filter
%
btnnum=3;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht];
  uicontrol(figDIresults, ...
      'style','pushbutton', ...
      'units','normalized', ...
      'position',btnpos, ...
      'string','Filter', ...
      'visible','on', ...
      'Callback', ...
	['DImin=str2num(get(hdimin,''string''));', ...
	'textin=DItext(xfp,yfp,DI,diropt,2,DImin,islopt);', ...
	'htextDI=ERAtslid(haxDI,textin,htextDI,hslidDI);']);

%
%  Damage index value
%
btnnum=4;
ypos=top-(btnnum-1)*(btnht+spacing)+spacing;
btnpos=[left ypos-btnht btnwd*.65 btnht];
  uicontrol(figDIresults, ...
      'style','text', ...
      'units','normalized', ...
      'position',btnpos, ...
      'string','abs(DI) >', ...
      'visible','on');

ypos=top-(btnnum-1)*(btnht+spacing)+spacing;
btnpos=[left+btnwd*.65 ypos-btnht btnwd*.35 btnht];
hdimin= uicontrol(figDIresults, ...
	'style','Edit', ...
	'units','normalized', ...
	'position',btnpos, ...
	'back','w', ...
	'string','2', ...
	'visible','on');



%
% close
%
btnnum=13;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht];
  uicontrol(figDIresults, ...
      'style','pushbutton', ...
      'units','normalized', ...
      'position',btnpos, ...
      'string','Close', ...
      'visible','on', ...
      'Callback','close');


%
% put results into the window
%

% 
% axes
%
haxDI=axes('units','normal', ...
		'position',[.05 .04 .7 .92], ...
	  	'color',[.8 .8 .8], ...
		'XtickLabels',[], ...
		'YtickLabels',[], ...
		'visible','on');


%
% Add the vertical slider
%
hslidDI = uicontrol('Style','slider', ...
	'Units','normal', ...
 	'Position',[.72 .04 .03 .92], ...
	'min',-2, ...
	'max',-1, ...
	'visible','on', ...
     	'UserData',[], ...
	'Value',-1, ...
      	'CallBack',['uu=get(gco,''UserData'');', ...
		 'axes(uu(2));', ...
		 'rval = get(gco,''Value'');', ...
                 'dy = uu(1);', ...
		 'if (rval-round(rval))>eps,', ...       % Test for +step
                 '  rval = ceil(rval);', ...               
                 'elseif (rval-round(rval)) < -eps,', ... % Test for -step
                 '  rval = floor(rval);', ...
                 'end,', ...
                 'miny = 1+(floor(abs(rval))-1)*abs(dy);', ...
                 'maxy = miny+20*abs(dy);', ...
                 'set(gco,''Value'',rval),', ...    % Set the step
                 'axlim = axis;', ...
                 'axis([axlim(1:2) miny maxy]),']);

htextDI=ERAtslid(haxDI,textin,htextDI,hslidDI);
axis('ij');
