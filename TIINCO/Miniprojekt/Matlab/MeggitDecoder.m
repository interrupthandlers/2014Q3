function varargout = MeggitDecoder(varargin)
% MEGGITDECODER MATLAB code for MeggitDecoder.fig
%      MEGGITDECODER, by itself, creates a new MEGGITDECODER or raises the existing
%      singleton*.
%
%      H = MEGGITDECODER returns the handle to a new MEGGITDECODER or the handle to
%      the existing singleton*.
%
%      MEGGITDECODER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MEGGITDECODER.M with the given input arguments.
%
%      MEGGITDECODER('Property','Value',...) creates a new MEGGITDECODER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MeggitDecoder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MeggitDecoder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MeggitDecoder

% Last Modified by GUIDE v2.5 07-Mar-2014 13:19:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MeggitDecoder_OpeningFcn, ...
                   'gui_OutputFcn',  @MeggitDecoder_OutputFcn, ...
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


% --- Executes just before MeggitDecoder is made visible.
function MeggitDecoder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MeggitDecoder (see VARARGIN)

% Choose default command line output for MeggitDecoder
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MeggitDecoder wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MeggitDecoder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function messageVector_Callback(hObject, eventdata, handles)
% hObject    handle to messageVector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of messageVector as text
%        str2double(get(hObject,'String')) returns contents of messageVector as a double


% --- Executes during object creation, after setting all properties.
function messageVector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to messageVector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function encodedVector_Callback(hObject, eventdata, handles)
% hObject    handle to encodedVector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of encodedVector as text
%        str2double(get(hObject,'String')) returns contents of encodedVector as a double


% --- Executes during object creation, after setting all properties.
function encodedVector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to encodedVector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function errorVector_Callback(hObject, eventdata, handles)
% hObject    handle to errorVector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of errorVector as text
%        str2double(get(hObject,'String')) returns contents of errorVector as a double


% --- Executes during object creation, after setting all properties.
function errorVector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to errorVector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function receivedVector_Callback(hObject, eventdata, handles)
% hObject    handle to receivedVector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of receivedVector as text
%        str2double(get(hObject,'String')) returns contents of receivedVector as a double


% --- Executes during object creation, after setting all properties.
function receivedVector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to receivedVector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function decodedVector_Callback(hObject, eventdata, handles)
% hObject    handle to decodedVector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of decodedVector as text
%        str2double(get(hObject,'String')) returns contents of decodedVector as a double


% --- Executes during object creation, after setting all properties.
function decodedVector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to decodedVector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in encodeCallback.
function encodeCallback_Callback(hObject, eventdata, handles)
% hObject    handle to encodeCallback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in transmitCallback.
function transmitCallback_Callback(hObject, eventdata, handles)
% hObject    handle to transmitCallback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in resetCallback.
function resetCallback_Callback(hObject, eventdata, handles)
% hObject    handle to resetCallback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in singleStepCallback.
function singleStepCallback_Callback(hObject, eventdata, handles)
% hObject    handle to singleStepCallback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in stepToEndCallback.
function stepToEndCallback_Callback(hObject, eventdata, handles)
% hObject    handle to stepToEndCallback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function bufferRegister_Callback(hObject, eventdata, handles)
% hObject    handle to bufferRegister (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bufferRegister as text
%        str2double(get(hObject,'String')) returns contents of bufferRegister as a double


% --- Executes during object creation, after setting all properties.
function bufferRegister_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bufferRegister (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
