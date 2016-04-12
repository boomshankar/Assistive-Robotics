%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GUI_Example.m - RedBot Simple Interface
% This code is modified on 2016-3-7 by BCM
%
% Using this code, you can control LED and buzzer of RedBot and read and plot 
% one of the IR sensor data. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = GUI_Example(varargin)
% GUI_EXAMPLE MATLAB code for GUI_Example.fig
%      GUI_EXAMPLE, by itself, creates a new GUI_EXAMPLE or raises the existing
%      singleton*.
%
%      H = GUI_EXAMPLE returns the handle to a new GUI_EXAMPLE or the handle to
%      the existing singleton*.
%
%      GUI_EXAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_EXAMPLE.M with the given input arguments.
%
%      GUI_EXAMPLE('Property','Value',...) creates a new GUI_EXAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Example_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Example_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Example

% Last Modified by GUIDE v2.5 07-Mar-2016 13:55:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Example_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Example_OutputFcn, ...
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


% --- Executes just before GUI_Example is made visible.
function GUI_Example_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Example (see VARARGIN)

% Choose default command line output for GUI_Example
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Example wait for user response (see UIRESUME)
% uiwait(handles.figure_gui);

% for Arduino
clear all;
global a;
a = arduino('com6', 'uno');

% --- Outputs from this function are returned to the command line.
function varargout = GUI_Example_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in turn_on_button.
function turn_on_button_Callback(hObject, eventdata, handles)
% hObject    handle to turn_on_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
writeDigitalPin(a, 'D13', 1);   %LED
writePWMVoltage(a, 'D9', 3);    %Buzzer

% --- Executes on button press in turn_off_button.
function turn_off_button_Callback(hObject, eventdata, handles)
% hObject    handle to turn_off_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
writeDigitalPin(a, 'D13', 0);   %LED
writePWMVoltage(a, 'D9', 0);    %Buzzer

function edit_text_samples_Callback(hObject, eventdata, handles)
% hObject    handle to edit_text_samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_text_samples as text
%        str2double(get(hObject,'String')) returns contents of edit_text_samples as a double
num = str2double(get(hObject,'String'));
handles.edit1 = num;
% Save the handles structure
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function edit_text_samples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_text_samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in read_button.
function read_button_Callback(hObject, eventdata, handles)
% hObject    handle to read_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
x = 0;
for k=1:1:handles.edit1
    b = readVoltage(a,'A3');
    x = [x,b];
    plot(x,'LineWidth',2); grid on;
    axis([0 handles.edit1 0 5]);
    pause(0.01);
end


% --- Executes on button press in exit_button.
function exit_button_Callback(hObject, eventdata, handles)
% hObject    handle to exit_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure_gui);
