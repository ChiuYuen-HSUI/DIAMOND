function anmodbtns
%
%  Function: anmodbtns
% 
%  Usage: anmodbtns
% 
%  Description:
%    Initializes the Analyze Mode Window
%

%
%  Version SWD970911
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

global HANDLES

%====================================
% General buttons parameters
%====================================
top=.95;
left=.84;
btnwd=.15;
btnht=.06;
spacing=.01;

%====================================
% Set up the console frame
%=====================================
frmborder=0.01;
ypos=.05-frmborder;
frmpos=[left-frmborder ypos btnwd+2*frmborder .95+2*frmborder];
HANDLES.hanalmodb(1)=uicontrol(HANDLES.hfigdmnd, ...
        'Style','Frame', ...
        'Position',frmpos, ...
        'BackgroundColor',[.5 .5 .5]);

%
% Set up plot axes
%

HANDLES.hanalmodb(2) = axes('position',[.1 .2 .7 .7],'parent',HANDLES.hfigdmnd);

%
% AUTOMAC Button
%

btnnum=0.5;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht];
HANDLES.hanalmodb(3)=uicontrol(HANDLES.hfigdmnd, ...
      'style','pushbutton', ...
      'position',btnpos, ...
      'string','AUTOMAC',...
      'callback',...
      ['showall(HANDLES.hanalmodb(2));',...
         'automacplot(HANDLES.hanalmodb(2),MODES.modalvector);']);
   
%
% Print Freq Table Button
%

btnnum=1.5;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht];
HANDLES.hanalmodb(12)=uicontrol(HANDLES.hfigdmnd, ...
      'style','pushbutton', ...
      'position',btnpos, ...
      'string','Print Freq / Damp',...
      'callback','prntfreq');
   
   
%  Frame on mode selection controls
HANDLES.hanalmodb(18) = uicontrol(HANDLES.hfigdmnd, ...
'style','frame',...
   'pos',[left-spacing ypos-btnht*4.8 btnwd+2*spacing btnht*3.5],...
   'BackgroundColor','w');
   
btnnum=2.5;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht*0.5];
HANDLES.hanalmodb(19) = uicontrol(HANDLES.hfigdmnd, ...
'style','text',...
   'pos',btnpos,...
   'backgroundcolor','w',...
   'fontweight','bold',...
   'string','Current Mode');
  
%
%  Active mode popup
%
btnnum=3;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht*0.5];
HANDLES.hanalmodb(13) = uicontrol(HANDLES.hfigdmnd, ...
'style','popup',...
   'pos',btnpos,...
   'string','temp',...
   'callback',...
   ['imode = get(HANDLES.hanalmodb(13),''value'');',...
      'set(HANDLES.hanalmodb(4),''string'',num2str(imode))']);


%
% Define Text box for Mode Number
%

btnnum=4.1;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left+0.5*btnwd ypos-btnht btnwd*0.5 btnht];
HANDLES.hanalmodb(4) = uicontrol(HANDLES.hfigdmnd, ...
'style','edit',...
   'pos',btnpos,...
   'callback', ...
   ['imode_t = str2num(get(HANDLES.hanalmodb(4),''string''));',...
      'if isempty(imode_t), disp(''Invalid Mode Number''),',...
      '   set(HANDLES.hanalmodb(4),''string'',num2str(imode)),',...
      'elseif imode_t > MODES.nmodes, disp(''Invalid Mode Number''),',...
      '   set(HANDLES.hanalmodb(4),''string'',num2str(imode)),',...
      'elseif imode_t <= 0, disp(''Invalid Mode Number''),',...
      '   set(HANDLES.hanalmodb(4),''string'',num2str(imode)),',...
      'else,',...
      '   imode = imode_t;',...
      'end,',...
      'set(HANDLES.hanalmodb(4),''string'',num2str(imode)),',...
      'set(HANDLES.hanalmodb(13),''value'',imode),',...
   ]);

btnpos=[left ypos-btnht btnwd*0.5 btnht];
HANDLES.hanalmodb(5)=uicontrol(HANDLES.hfigdmnd, ...
'style','text',...
	'pos',btnpos,...
    	'string','Mode #');

%
%  Define Previous and Next Mode Buttons
%
btnnum=4.6;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd*0.5 btnht*0.5];
HANDLES.hanalmodb(6) = uicontrol(HANDLES.hfigdmnd, ...
'style','push',...
   'pos',btnpos,...
   'string','prev', ...
   'callback',...
   ['imode_t=imode-1;', ...
      'if imode_t < 1, ',...
      '   disp(''Invalid Mode Number''),',...
      ' else,',...
      '    imode = imode_t;',...
      'end,',...
      'set(HANDLES.hanalmodb(4),''string'',num2str(imode)),',...
      'set(HANDLES.hanalmodb(13),''value'',imode),',...
]);

btnpos=[left+0.5*btnwd ypos-btnht btnwd*0.5 btnht*0.5];
HANDLES.hanalmodb(7) = uicontrol(HANDLES.hfigdmnd, ...
'style','push',...
   'pos',btnpos,...
   'string','next', ...
   'callback', ...
   ['imode_t=imode+1;', ...
      'if imode_t > MODES.nmodes, ',...
      '   disp(''Invalid Mode Number''),',...
      ' else,',...
      '    imode = imode_t;',...
      'end,',...
      'set(HANDLES.hanalmodb(4),''string'',num2str(imode)),',...
      'set(HANDLES.hanalmodb(13),''value'',imode),',...
]);
  
  
   
   
%  Frame on mode normalization controls
HANDLES.hanalmodb(20) = uicontrol(HANDLES.hfigdmnd, ...
'style','frame',...
   'pos',[left-spacing top-(btnht+spacing)*9.6 btnwd+2*spacing btnht*5.0],...
   'BackgroundColor','w');
   
btnnum=6.5;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht];
HANDLES.hanalmodb(21) = uicontrol(HANDLES.hfigdmnd, ...
'style','text',...
   'pos',btnpos,...
   'backgroundcolor','w',...
   'fontweight','bold',...
   'string','Mode Normalization');

%
% Mass Normalization Button
%

btnnum=7.5;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht];
HANDLES.hanalmodb(10)=uicontrol(HANDLES.hfigdmnd, ...
      'style','pushbutton', ...
      'position',btnpos, ...
      'string','Normalize',...
      'callback',[...
         'disp(''Normalizing Real Modes...''),',...
         'normmodes,',...
         'disp(''Done Normalizing Real Modes''),']);
   
%
% Menu of Mass Normalization Methods
%

btnnum=8.5;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht];
HANDLES.hanalmodb(11)=uicontrol(HANDLES.hfigdmnd, ...
      'style','popup', ...
      'position',btnpos, ...
      'string','Drive Point|Unit Mass',...
      'value',1,...
      'callback',...
      ['switch get(HANDLES.hanalmodb(11),''value''),',...
         'case 1, MODES.imnmeth = ''Drive Point'';',...
         '   set(HANDLES.hanalmodb([9 25]),''visible'',''on''),',...
         'case 2, MODES.imnmeth = ''Unit Mass'';',...
         '   set(HANDLES.hanalmodb([9 25]),''visible'',''off''),',...
         'end,']);


%
% Driving point pair
%

btnnum=9.0;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht*0.5];
HANDLES.hanalmodb(25)=uicontrol(HANDLES.hfigdmnd, ...
      'style','text', ...
      'position',btnpos, ...
      'string','Drive Pt Pair');
btnnum=9.5;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht*0.5];
HANDLES.hanalmodb(9)=uicontrol(HANDLES.hfigdmnd, ...
      'style','edit', ...
      'position',btnpos, ...
      'string','[1 1]', ...
      'callback','MODES.dppair=str2num(get(HANDLES.hanalmodb(9),''string''));');

   
%
% MPC Button
%
btnnum=11;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht];
HANDLES.hanalmodb(8)=uicontrol(HANDLES.hfigdmnd, ...
      'style','pushbutton', ...
      'position',btnpos, ...
      'string','Plot MPC (Polar)',...
      'callback',['mpcplot(HANDLES.hanalmodb(2),MODES.residue{imode}.'',MODES.Freq{imode});']);
   
%
% List Magnitudes and phases
%
btnnum=12;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht];
HANDLES.hanalmodb(14)=uicontrol(HANDLES.hfigdmnd, ...
      'style','pushbutton', ...
      'position',btnpos, ...
      'string','Print Mag / Phs',...
      'callback',...
      ['disp([''Magnitudes and Phases for Mode #'',num2str(imode),'' ('',num2str(MODES.Freq{imode}),'' Hz)'']),',...
      'disp(magphstx(MODES.respDOF,MODES.residue{imode},MODES.Freq{imode}));']);


%
%  
%  Delete Mode Button
%
btnnum=13;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht];
HANDLES.hanalmodb(17) = uicontrol(HANDLES.hfigdmnd, ...
	'style','push', ...
	'string','Delete Current Mode', ...
	'position',btnpos, ...
   'callback',['deletemode(imode),',...
      'if MODES.nmodes == 0, hideallbtns, set(HANDLES.hmmenu{6}(1),''enable'',''off''), set(HANDLES.hviewm(1),''visible'',''off''),',...
      'else,',...
      'if imode > 1, imode = imode -1; else imode = 1; end,',...
      'set(HANDLES.hanalmodb(13),''string'',buildfreqpopup),',...
      'set(HANDLES.hanalmodb(4),''string'',num2str(imode)),',...
      'set(HANDLES.hanalmodb(13),''value'',imode),',...
      'end,']);

set(HANDLES.hanalmodb,'visible','off')

return
