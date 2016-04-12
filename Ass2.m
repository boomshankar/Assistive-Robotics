function varargout = Ass2(varargin)
% ASS2 MATLAB code for Ass2.fig
%      ASS2, by itself, creates a new ASS2 or raises the existing
%      singleton*.
%
%      H = ASS2 returns the handle to a new ASS2 or the handle to
%      the existing singleton*.
%
%      ASS2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASS2.M with the given input arguments.
%
%      ASS2('Property','Value',...) creates a new ASS2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Ass2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Ass2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Ass2

% Last Modified by GUIDE v2.5 25-Mar-2016 18:20:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Ass2_OpeningFcn, ...
                   'gui_OutputFcn',  @Ass2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
 %   gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Ass2 is made visible.
function Ass2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Ass2 (see VARARGIN)

% Choose default command line output for Ass2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Ass2 wait for user response (see UIRESUME)
%uiwait(handles.figure1);

clear all;
clc;
%for Arduino
global a;
%int volt = 2;
a = arduino('com5', 'uno');



% --- Outputs from this function are returned to the command line.
function varargout = Ass2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

global V;
V = 0;

% --- Executes on button press in increase_button.
function increase_button_Callback(hObject, eventdata, handles)
% hObject    handle to increase_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
global V;
if V<5
    V = V + 1;
else
    writePWMVoltage(a, 'D9', V);  %buzzer
end
writeDigitalPin(a,'D13',1);   %LED
writeDigitalPin(a, 'D2', 1);  % write High to L_CTRL_1
writeDigitalPin(a, 'D7', 1); % write High to R_CTRL_1
writePWMVoltage(a, 'D5', V); % write 100 to PWM_L
writePWMVoltage(a, 'D6', V); % write 100 to PWM_L  
% axes(handles.axes2);
% x = readVoltage(a,'A3');
% y = 1;
% stairs(x,y);

% x = [V,0];
% 
% 
% axes(handles.axes3);
% b = readVoltage(a,'A3');
% x = [0,b];
% plot(x,'LineWidth', 5); grid on;

 
 
% --- Executes on button press in decrease_button.
function decrease_button_Callback(hObject, eventdata, handles)
% hObject    handle to decrease_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
global V;
if V>0
    V = V -1;
else
    writePWMVoltage(a, 'D9', 0);  %buzzer
end
writeDigitalPin(a,'D13',0);   %LED
writeDigitalPin(a, 'D2', 1);  % write High to L_CTRL_1
writeDigitalPin(a, 'D7', 1); % write High to R_CTRL_1
writePWMVoltage(a, 'D5', V); % write 100 to PWM_L
writePWMVoltage(a, 'D6', V); % write 100 to PWM_L  


% --- Executes on button press in right_button.
function right_button_Callback(hObject, eventdata, handles)
% hObject    handle to right_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
global V;
if V<5
    V = V + 1;
else
    writePWMVoltage(a, 'D9', 3);  %buzzer
end
writeDigitalPin(a,'D13',1);   %LED
writeDigitalPin(a, 'D2', 1);  % write High to L_CTRL_1
writeDigitalPin(a, 'D7', 1); % write High to R_CTRL_1
writePWMVoltage(a, 'D5', V); % write 100 to PWM_L
%writePWMVoltage(a, 'D6', V); % write 100 to PWM_L  

function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to left_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
global V;
if V<5
    V = V + 1;
else
    writePWMVoltage(a, 'D9', 3);  %buzzer
end
writeDigitalPin(a,'D13',1);   %LED
writeDigitalPin(a, 'D2', 1);  % write High to L_CTRL_1
writeDigitalPin(a, 'D7', 1); % write High to R_CTRL_1
%writePWMVoltage(a, 'D5', V); % write 100 to PWM_L
writePWMVoltage(a, 'D6', V); % write 100 to PWM_L  

% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla reset
global a;
writeDigitalPin(a, 'D2', 0); % write Low to L_CTRL_1
writeDigitalPin(a, 'D4', 0); % write Low to L_CTRL_1
writeDigitalPin(a, 'D7', 0); % write Low to R_CTRL_1
writeDigitalPin(a, 'D8', 0); % write Low to R_CTRL_2   


% --- Executes on button press in auto_nav_button.
function auto_nav_button_Callback(hObject, eventdata, handles)
% hObject    handle to auto_nav_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in manual_button.
function manual_button_Callback(hObject, eventdata, handles)
% hObject    handle to manual_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
