function varargout = calc(varargin)
% CALC MATLAB code for calc.fig
%      CALC, by itself, creates a new CALC or raises the existing
%      singleton*.
%
%      H = CALC returns the handle to a new CALC or the handle to
%      the existing singleton*.
%
%      CALC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALC.M with the given input arguments.
%
%      CALC('Property','Value',...) creates a new CALC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before calc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to calc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help calc

% Last Modified by GUIDE v2.5 15-Jun-2019 19:09:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @calc_OpeningFcn, ...
                   'gui_OutputFcn',  @calc_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before calc is made visible.
function calc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to calc (see VARARGIN)

% Choose default command line output for calc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes calc wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global i l n dr f
set(handles.text5,'String','0');
i=0;
l=0;
dr=0;
n=0;
f=0;
%%%%%handwriting%%%%%
load('convnet2.mat');
global net;
net = convnet2;
%variable
global order ;
order = [];
%第一層x中心; 第二層y中心; 第三層順序; 第四層x寬; 第五層y寬;
global draw_enable;
draw_enable = 0;
global xway yway;
    xway = [];
    yway = [];
%軸
axes(handles.axes3);
axis([0 5 0 3.5]);
%modeswitch
global modeswitch;
modeswitch = 0;
set(handles.axes3,'Visible','off');
%%%%%handwriting%%%%%

% --- Outputs from this function are returned to the command line.
function varargout = calc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
textString = get(handles.text5,'String');
if(strcmp(textString,'0')==1)&&(i==0)
   set(handles.text5,'String','0') ;
elseif(strcmp(textString,'0')==0)&&(i==1)
   set(handles.text5,'String','0') ; 
else
textString =strcat(textString,'0');
set(handles.text5,'String',textString)
end
i=0;

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i f
textString = get(handles.text5,'String');
if(strcmp(textString,'0')==1)&&(i==0)
    textString =strcat(textString,'.');
    set(handles.text5,'String',textString)
    f=1;
elseif (strcmp(textString,'')==0)&&(f==0)
    if(textString(end)~='+')&&(textString(end)~='-')&&(textString(end)~='*')&&(textString(end)~='/')
    textString =strcat(textString,'.');
    set(handles.text5,'String',textString)
    f=1;
    end
end
i=0;

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i n l
textString = get(handles.text5,'String');
if(strcmp(textString,'0')==1)&&(i==0)
   set(handles.text5,'String','0');
elseif n==1
   set(handles.text5,'String','NaN');
   set(handles.text9,'String','NaN');
else
    switch l
        case 1
        textString = strrep(textString,'ln','log');
        case 2
        textString = strrep(textString,'log','log10');
        case 3
        textString = strrep(textString,')!',')');
        textString = strrep(textString,'(','factorial(');
    end
d =eval(textString);
    if d<1e-15&&d>0
        d=0;
    elseif d<-1e16
        d='-∞';    
    elseif d>1e16
        d='∞';
    end
set(handles.text5,'String',d)
switch l
        case 1
        textString = strrep(textString,'log','ln');
        case 2
        textString = strrep(textString,'log10','log');
        case 3
        textString = strrep(textString,'factorial(','');
        textString = strrep(textString,')','!');
end
textString2 = get(handles.text5,'String');
textString3 =strcat(textString,'=',textString2);
set(handles.text9,'String',textString3)
end
l=0;
i=1;
n=0;

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

textString = get(handles.text5,'String');

if(strcmp(textString,'0')==1)
   set(handles.text5,'String',')') ;
else
textString =strcat(textString,')');
set(handles.text5,'String',textString)
end

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textString = get(handles.text5,'String');

if(strcmp(textString,'0')==1)
   set(handles.text5,'String','(') ;
else
textString =strcat(textString,'(');
set(handles.text5,'String',textString)
end

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
textString = get(handles.text5,'String');
if(strcmp(textString,'0')==1)&&(i==0)
   set(handles.text5,'String','2') ;
elseif(strcmp(textString,'0')==0)&&(i==1)
   set(handles.text5,'String','2') ; 
else
textString =strcat(textString,'2');
set(handles.text5,'String',textString)
end
i=0;

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
textString = get(handles.text5,'String');
if(strcmp(textString,'0')==1)&&(i==0)
   set(handles.text5,'String','3') ;
elseif(strcmp(textString,'0')==0)&&(i==1)
   set(handles.text5,'String','3') ; 
else
textString =strcat(textString,'3');
set(handles.text5,'String',textString)
end
i=0;

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global f
textString = get(handles.text5,'String');
if(textString(end)~='+')&&(textString(end)~='-')&&(textString(end)~='*')&&(textString(end)~='/')&&(textString(end)~='.')
textString =strcat(textString,'+');
end
set(handles.text5,'String',textString)
f=0;

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
textString = get(handles.text5,'String');
if(strcmp(textString,'0')==1)&&(i==0)
   set(handles.text5,'String','1') ;
elseif(strcmp(textString,'0')==0)&&(i==1)
   set(handles.text5,'String','1') ; 
else
textString =strcat(textString,'1');
set(handles.text5,'String',textString)
end
i=0;

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textString = get(handles.text5,'String');
if(strcmp(textString,'0')==1)
   set(handles.text5,'String','0') ;
elseif(strncmp(textString, '-', 1)==1)
    textString = strrep(textString,'-','');
    set(handles.text5,'String',textString);
elseif(strncmp(textString, '-', 1)==0)
    textString = strcat('-',textString);
    set(handles.text5,'String',textString);
else
a = strread(textString, '%f');
a=a * (-1);
set(handles.text5,'String',a)
end

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
textString = get(handles.text5,'String');
if(strcmp(textString,'0')==1)&&(i==0)
   set(handles.text5,'String','5') ;
elseif(strcmp(textString,'0')==0)&&(i==1)
   set(handles.text5,'String','5') ; 
else
textString =strcat(textString,'5');
set(handles.text5,'String',textString)
end
i=0;

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
textString = get(handles.text5,'String');
if(strcmp(textString,'0')==1)&&(i==0)
   set(handles.text5,'String','6') ;
elseif(strcmp(textString,'0')==0)&&(i==1)
   set(handles.text5,'String','6') ;    
else
textString =strcat(textString,'6');
set(handles.text5,'String',textString)
end
i=0;

% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global f
textString = get(handles.text5,'String');
if(textString(end)~='+')&&(textString(end)~='-')&&(textString(end)~='*')&&(textString(end)~='/')&&(textString(end)~='.')
textString =strcat(textString,'-');
end
set(handles.text5,'String',textString)
f=0;

% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
textString = get(handles.text5,'String');
if(strcmp(textString,'0')==1)&&(i==0)
   set(handles.text5,'String','4') ;
elseif(strcmp(textString,'0')==0)&&(i==1)
   set(handles.text5,'String','4') ; 
else
textString =strcat(textString,'4');
set(handles.text5,'String',textString)
end
i=0;

% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i l
textString = get(handles.text5,'String');
textString =strcat('(',textString,')!');
set(handles.text5,'String',textString);
i=1;
l=3;

% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
textString = get(handles.text5,'String');
if(strcmp(textString,'0')==1)&&(i==0)
   set(handles.text5,'String','8') ;
elseif(strcmp(textString,'0')==0)&&(i==1)
   set(handles.text5,'String','8') ;     
else
textString =strcat(textString,'8');
set(handles.text5,'String',textString);
end
i=0;

% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
textString = get(handles.text5,'String');
if(strcmp(textString,'0')==1)&&(i==0)
   set(handles.text5,'String','9') ;
elseif(strcmp(textString,'0')==0)&&(i==1)
   set(handles.text5,'String','9') ; 
else
textString =strcat(textString,'9');
set(handles.text5,'String',textString)
end
i=0;

% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global f
textString = get(handles.text5,'String');
if(textString(end)~='+')&&(textString(end)~='-')&&(textString(end)~='*')&&(textString(end)~='/')&&(textString(end)~='.')
textString =strcat(textString,'*');
end
set(handles.text5,'String',textString)
f=0;

% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
textString = get(handles.text5,'String');
if(strcmp(textString,'0')==1)&&(i==0)
   set(handles.text5,'String','7') ;
elseif(strcmp(textString,'0')==0)&&(i==1)
   set(handles.text5,'String','7') ; 
else
textString =strcat(textString,'7');
set(handles.text5,'String',textString)
end
i=0;

% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
textString = get(handles.text5,'String');
if(strcmp(textString,'0')==1)&&(i==0)
   set(handles.text5,'String','pi') ;
elseif(strcmp(textString,'0')==0)&&(i==1)
   set(handles.text5,'String','pi') ; 
else
textString =strcat(textString,'pi');
set(handles.text5,'String',textString)
end
i=0;

% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global f
set(handles.text5,'String','');
f=0;

% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textString=get(handles.text5,'String');
textString=textString(1:end-1);
set(handles.text5,'String',textString);

% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global f
textString = get(handles.text5,'String');
if(textString(end)~='+')&&(textString(end)~='-')&&(textString(end)~='*')&&(textString(end)~='/')&&(textString(end)~='.')
textString =strcat(textString,'/');
end
set(handles.text5,'String',textString)
f=0;

% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global f
set(handles.text5,'String','') ;
set(handles.text9,'String','') ;
f=0;

% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dr i
textString = get(handles.text5,'String');
switch dr
    case 0
textString =strcat('sin(',textString,')');
set(handles.text5,'String',textString);
    case 1
textString =strcat('sind(',textString,')');
set(handles.text5,'String',textString)
end
i=0;

% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dr i
textString = get(handles.text5,'String');
switch dr
    case 0
textString =strcat('cos(',textString,')');
set(handles.text5,'String',textString);
    case 1
textString =strcat('cosd(',textString,')');
set(handles.text5,'String',textString)
end
i=0;


% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dr i
textString = get(handles.text5,'String');
switch dr
    case 0
textString =strcat('tan(',textString,')');
set(handles.text5,'String',textString);
    case 1
textString =strcat('tand(',textString,')');
set(handles.text5,'String',textString)
end
i=0;


% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
textString=get(handles.text5,'String');
textString =strcat('exp(',textString,')');
set(handles.text5,'String',textString);
i=0;

% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
textString=get(handles.text5,'String');
textString =strcat('sqrt(',textString,')');
set(handles.text5,'String',textString);
i=0;


% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dr i n
textString = get(handles.text5,'String');
a = str2double(textString);
switch dr
    case 0
textString2 =strcat('asin(',textString,')');
if a>1||a<-1
    n=1;
end
set(handles.text5,'String',textString2);
    case 1
textString2 =strcat('asind(',textString,')');
if a>1||a<-1
    n=1;
end
set(handles.text5,'String',textString2)
end
i=0;

% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dr i n
textString = get(handles.text5,'String');
a = str2double(textString);
switch dr
    case 0
textString2 =strcat('acos(',textString,')');
if a>1||a<-1
    n=1;
end
set(handles.text5,'String',textString2);
    case 1
textString2 =strcat('acosd(',textString,')');
if a>1||a<-1
    n=1;
end
set(handles.text5,'String',textString2)
end
i=0;

% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dr i
textString = get(handles.text5,'String');
switch dr
    case 0
textString =strcat('atan(',textString,')');
set(handles.text5,'String',textString);
    case 1
textString =strcat('atand(',textString,')');
set(handles.text5,'String',textString)
end
i=0;

% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i l
textString=get(handles.text5,'String');
textString1 =strcat('ln(',textString,')');
set(handles.text5,'String',textString1);
i=0;
l=1;

% --- Executes on button press in pushbutton40.
function pushbutton40_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
textString=get(handles.text5,'String');
textString =strcat(textString,'^2');
set(handles.text5,'String',textString);
i=0;

% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  i
textString = get(handles.text5,'String');
textString =strcat('sinh(',textString,')');
set(handles.text5,'String',textString);
i=0;

% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  i
textString = get(handles.text5,'String');
textString =strcat('cosh(',textString,')');
set(handles.text5,'String',textString);
i=0;

% --- Executes on button press in pushbutton43.
function pushbutton43_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  i
textString = get(handles.text5,'String');
textString =strcat('tanh(',textString,')');
set(handles.text5,'String',textString);
i=0;

% --- Executes on button press in pushbutton44.
function pushbutton44_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i l
textString=get(handles.text5,'String');
textString1 =strcat('log(',textString,')');
set(handles.text5,'String',textString1);
i=0;
l=2;

% --- Executes on button press in pushbutton45.
function pushbutton45_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
textString=get(handles.text5,'String');
textString =strcat(textString,'^');
set(handles.text5,'String',textString);
i=0;

% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dr
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
dr = 1;
elseif button_state == get(hObject,'Min')
dr = 0;
end
% Hint: get(hObject,'Value') returns toggle state of togglebutton4


% --- Executes on mouse press over axes background.
function axes3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global draw_enable;
global x y;
global xway yway ;

draw_enable = 1;

if draw_enable == 1
    p = get(gca,'currentpoint');
    x(1) = p(1);
    y(1) = p(3);
    xway(end+1) = p(1);
    yway(end+1) = p(3);
end


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global draw_enable;
global x;
global y;
global h1;
global xway;
global yway;
p = get(gca,'currentpoint');
if draw_enable == 1
    x(2) = p(1);
    y(2) = p(3);
    xway(end+1) = p(1);
    yway(end+1) = p(3);
    h1 = line(x,y,'LineWidth',5,'Color','white','Marker','.');
    x(1) = p(1);
    y(1) = p(3);
end


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global draw_enable ;
global xway yway order;
if  draw_enable == 1
    x0 = min(xway); x1 = max(xway);
    y0 = min(yway); y1 = max(yway);
    order(1,end+1) = (x0 + x1)/2;
    order(2,end) = (y0 + y1)/2;
    order(3,end) = order(1,end);
    order(4,end) = x0; order(5,end) = x1;
    order(6,end) = y0; order(7,end) = y1;
    xway = [];
    yway = [];
end
draw_enable = 0;


% --- Executes on button press in pushbutton47.
function pushbutton47_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global net;
global order ;
global i;
%整理數據way1
n = size(order);
n = n(2);
contr = 0;
for ii = 1:n
    k = n - contr;
    for j = ii + 1:k
        if abs(order(3,ii) - order(3,j)) < (order(5,ii)-order(4,ii))/1.5 || abs(order(3,ii) - order(3,j)) < (order(7,ii)-order(6 ,ii))/1.5 
            %X
            arrx = order([4 5],ii);
            arrx([3 4]) = order([4 5],j);
            order(4,ii) = min(arrx);
            order(5,ii) = max(arrx);
            order(1,ii) = (order(4,ii) + order(5,ii))/2;
            %X
            %Y
            arry = order([6 7],ii);
            arry([3 4]) = order([6 7],j);
            order(6,ii) = min(arry);
            order(7,ii) = max(arry);
            order(2,ii) = (order(6,ii) + order(7,ii))/2;
            %Y
            order(:,j) = [];
            contr = contr + 1;
            break;
        end
    end
end

n = size(order);
n = n(2);
%整理數據way1

% figure(2);
%order
for ii = 1:n
    order(4,ii) = order(5,ii) - order(4,ii);
    order(5,ii) = order(7,ii) - order(6,ii);
    arr2 = order([4 5],ii);
    xsta = order(1,ii) - max(arr2)/2 - 0.2;
    xend = xsta + max(arr2) + 0.4;
    ysta = order(2,ii) - max(arr2)/2 - 0.2;
    yend = ysta + max(arr2) + 0.4;
    fignew = figure('Visible','off'); 
    newAxes = copyobj(handles.axes3,fignew);
    set(newAxes,'Position',[4.14285714285709 15.9999999999999 44.9999999999999 10.0526315789473]);
    axis([xsta,xend,ysta,yend]);
    set(newAxes,'PlotBoxAspectRatio',[1,1,1]);

    set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')');
    F = getframe(newAxes);
    Image = frame2im(F);
    Image = Image(:,:,2);
    Image = imresize(Image, [28 28]);
    %imshow(Image);
    delete(fignew); 
    predictedLabel = net.classify(Image);
    %subplot(1, n, ii);
    %imshow(Image);
    %title(['Predicted: ' char(predictedLabel)]);
    numberconfig(i,handles.text5,predictedLabel);
end
i = 0;
axes(handles.axes3);
cla;
order = [];


% --- Executes on button press in pushbutton48.
function pushbutton48_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global order;
axes(handles.axes3);
cla;
order = [];


% --- Executes on button press in pushbutton50.
function pushbutton50_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global modeswitch;
if modeswitch == 0
    set(handles.pushbutton14,'Visible','off');
    set(handles.pushbutton11,'Visible','off');
    set(handles.pushbutton12,'Visible','off');
    set(handles.pushbutton19,'Visible','off');
    set(handles.pushbutton16,'Visible','off');
    set(handles.pushbutton17,'Visible','off');
    set(handles.pushbutton24,'Visible','off');
    set(handles.pushbutton21,'Visible','off');
    set(handles.pushbutton22,'Visible','off');
    set(handles.axes3,'Visible','on');
    modeswitch = 1;
else
    set(handles.pushbutton14,'Visible','on');
    set(handles.pushbutton11,'Visible','on');
    set(handles.pushbutton12,'Visible','on');
    set(handles.pushbutton19,'Visible','on');
    set(handles.pushbutton16,'Visible','on');
    set(handles.pushbutton17,'Visible','on');
    set(handles.pushbutton24,'Visible','on');
    set(handles.pushbutton21,'Visible','on');
    set(handles.pushbutton22,'Visible','on'); 
    set(handles.axes3,'Visible','off');
   modeswitch = 0;
end
