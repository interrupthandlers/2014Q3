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

% Last Modified by GUIDE v2.5 13-Mar-2014 19:17:39

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

g = [1 0 0 0 1 0 1 1 1];    % Given by g(x) = 1 + X^4 + X^6 + X^7 + X^8
handles.n = 15;             % Given in the exercise
handles.k = 7;              % Given in the exercise

handles.genPoly = g;
handles.decoder = MeggitDecoderImpl(handles.genPoly,handles.n,handles.k);

guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = MeggitDecoder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in encodeCallback.
function encodeCallback_Callback(hObject, eventdata, handles)


% hObject    handle to encodeCallback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

g = handles.genPoly; %Generator polynomium
messageString = get(handles.messageVectorTxb, 'String'); %Message is read from the GUI
handles.messageVector = messageString(:)'-'0'; %Converted to binary from string

handles.encodedVector = EncodeCyclicSystematic(g,handles.messageVector); %Encoded vector is calculated

encodedVectorString = num2str(handles.encodedVector); %Encoded vector is converted to string
encodedVectorString(isspace(encodedVectorString)) = '';

%handles.encodedVector = bin2str(handles.encodedVector)
set(handles.encodedVectorTxb,'String',encodedVectorString) %Encoded vector string is set in the GUI

set(handles.transmitCallback,'Enable','on');

guidata(hObject, handles); %Updates the GUI


% --- Executes on button press in transmitCallback.
function transmitCallback_Callback(hObject, eventdata, handles)
% hObject    handle to transmitCallback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

errorString = get(handles.errorPatternTxb, 'String'); %Error pattern is read from the GUI
handles.errorPattern = errorString(:)'-'0'; %Converted to binary from string

handles.receivedVector = mod(handles.encodedVector + handles.errorPattern,2);

receivedVectorString = num2str(handles.receivedVector); %Received vector is converted to string
receivedVectorString(isspace(receivedVectorString)) = '';

set(handles.receivedVectorTxb,'String',receivedVectorString) %Received vector string is set in the GUI
set(handles.startDecondingCallback,'Enable','on');

guidata(hObject, handles); %Updates the GUI

% --- Executes on button press in resetCallback.
function resetCallback_Callback(hObject, eventdata, handles)
% hObject    handle to resetCallback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.messageVectorTxb, 'String', '1010101'); %Clearing GUI fields
set(handles.encodedVectorTxb, 'String', '');
set(handles.errorPatternTxb, 'String', '000000000000000');
set(handles.receivedVectorTxb, 'String', '');
set(handles.encodedVectorTxb, 'String', '');
set(handles.bufferRegisterTxb, 'String', '');
set(handles.syndromeRegisterTxb, 'String', '');
set(handles.statusTxb,'String','');
set(handles.correctedErrorsTxb,'String','');
set(handles.iterationsTxb,'String','');

set(handles.transmitCallback,'Enable','off');
set(handles.startDecondingCallback,'Enable','off');
set(handles.singleStepCallback,'Enable','off');
set(handles.stepToEndCallback,'Enable','off');

set(handles.statusTxb,'BackgroundColor','white');

handles.messageVector = 0; %Clearing background variables
handles.encodedVector = 0;
handles.errorPattern = 0;
handles.receivedVector = 0;

% --- Executes on button press in singleStepCallback.
function singleStepCallback_Callback(hObject, eventdata, handles)
% hObject    handle to singleStepCallback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.decoder.decodeSingleStep();

updateGui(handles);

% --- Executes on button press in stepToEndCallback.
function stepToEndCallback_Callback(hObject, eventdata, handles)
% hObject    handle to stepToEndCallback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.decoder.decodeFullStep();

updateGui(handles);


% --- Executes on button press in startDecondingCallback.
function startDecondingCallback_Callback(hObject, eventdata, handles)
% hObject    handle to startDecondingCallback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.decoder.setReceived(handles.receivedVector); %Load the received vector into the decoder
updateGui(handles);
set(handles.singleStepCallback,'Enable','on');
set(handles.stepToEndCallback,'Enable','on');


function updateGui(handles)
buffer = num2str(handles.decoder.buffer); %Get buffer value and convert it to a string
buffer(isspace(buffer)) = ''; %Remove the spaces in the string

set(handles.bufferRegisterTxb,'String',buffer);

syndrome = num2str(handles.decoder.s); %Get syndrome vector and convert it to a string
syndrome(isspace(syndrome)) = ''; %Remove the spaces in the string

set(handles.syndromeRegisterTxb,'String',syndrome);

decodeIteration = num2str(handles.decoder.decodeIteration); %Get errors value and convert it to a string
set(handles.iterationsTxb,'String',decodeIteration);

correctedErrors = num2str(handles.decoder.correctedErrors); %Get errors value and convert it to a string
set(handles.correctedErrorsTxb,'String',correctedErrors);

[tag desc] = handles.decoder.getStatus();
set(handles.statusTxb,'String',desc);

switch tag
    case 2
       set(handles.statusTxb,'BackgroundColor','green');
    case 3
       set(handles.statusTxb,'BackgroundColor','red');
    otherwise
       set(handles.statusTxb,'BackgroundColor','white');        
end

if handles.decoder.IsDecodingComplete()
    set(handles.singleStepCallback,'Enable','off');
    set(handles.stepToEndCallback,'Enable','off');
    
    if handles.decoder.WasDecodingSuccesful()
        set(handles.decodedVectorTxb,'String',buffer(1,9:end)); %message is extracted. Message is end of codeword, as the encoder is systematic.
    end
end
