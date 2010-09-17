function TwinDisksLuke
SolveOrdinaryDifferentialEquations
% File  TwinDisksLuke.m  created by Autolev 4.1 on Wed Sep 15 22:37:58 2010


%===========================================================================
function VAR = ReadUserInput
global   alpha g Ixx Ixy Iyy Izz k l m ra rb;
global   q1 q2 q3 q4 q5 w;
global   q1p q2p q3p q4p q5p wp w1 w3;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

%-------------------------------+--------------------------+-------------------+-----------------
% Quantity                      | Value                    | Units             | Description
%-------------------------------|--------------------------|-------------------|-----------------
alpha                           =  1.570796326794897;      % rad                 Constant
g                               =  9.81;                   % m/s^2               Constant
Ixx                             =  0.0;                    % UNITS               Constant
Ixy                             =  0.0;                    % UNITS               Constant
Iyy                             =  0.0;                    % UNITS               Constant
Izz                             =  0.0;                    % UNITS               Constant
k                               =  0.0;                    % m                   Constant
l                               =  .1;                     % m                   Constant
m                               =  0.1;                    % kg                  Constant
ra                              =  0.1;                    % m                   Constant
rb                              =  0.1;                    % m                   Constant

q1                              =  0.0;                    % rad                 Initial Value
q2                              =  0.0;                    % rad                 Initial Value
q3                              =  0.0;                    % UNITS               Initial Value
q4                              =  0.0;                    % m                   Initial Value
q5                              =  0.0;                    % m                   Initial Value
w                               =  0.0;                    % rad/s               Initial Value

TINITIAL                        =  0.0;                    % s                   Initial Time
TFINAL                          =  1.0;                    % s                   Final Time
INTEGSTP                        =  0.1;                    % s                   Integration Step
PRINTINT                        =  1;                      % Positive Integer    Print-Integer
ABSERR                          =  1.0E-08;                %                     Absolute Error
RELERR                          =  1.0E-07 ;               %                     Relative Error
%-------------------------------+--------------------------+-------------------+-----------------

% Unit conversions
Pi       = 3.141592653589793;
DEGtoRAD = Pi/180.0;
RADtoDEG = 180.0/Pi;

% Reserve space and initialize matrices
z = zeros(96,1);

% Evaluate constants
z(94) = g*m;
z(7) = cos(alpha);
z(8) = sin(alpha);

% Set the initial values of the states
VAR(1) = q1;
VAR(2) = q2;
VAR(3) = q3;
VAR(4) = q4;
VAR(5) = q5;
VAR(6) = w;



%===========================================================================
% Main driver loop for numerical integration of differential equations
%===========================================================================
function SolveOrdinaryDifferentialEquations
global   alpha g Ixx Ixy Iyy Izz k l m ra rb;
global   q1 q2 q3 q4 q5 w;
global   q1p q2p q3p q4p q5p wp w1 w3;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

VAR = ReadUserInput;
OdeMatlabOptions = odeset( 'RelTol',RELERR, 'AbsTol',ABSERR, 'MaxStep',INTEGSTP );
T = TINITIAL;
PrintCounter = 0;
mdlDerivatives(T,VAR,0);
while 1,
  if( TFINAL>=TINITIAL & T+0.01*INTEGSTP>=TFINAL ) PrintCounter = -1; end
  if( TFINAL<=TINITIAL & T+0.01*INTEGSTP<=TFINAL ) PrintCounter = -1; end
  if( PrintCounter <= 0.01 ),
     mdlOutputs(T,VAR,0);
     if( PrintCounter == -1 ) break; end
     PrintCounter = PRINTINT;
  end
  [TimeOdeArray,VarOdeArray] = ode45( @mdlDerivatives, [T T+INTEGSTP], VAR, OdeMatlabOptions, 0 );
  TimeAtEndOfArray = TimeOdeArray( length(TimeOdeArray) );
  if( abs(TimeAtEndOfArray - (T+INTEGSTP) ) >= abs(0.001*INTEGSTP) ) warning('numerical integration failed'); break;  end
  T = TimeAtEndOfArray;
  VAR = VarOdeArray( length(TimeOdeArray), : );
  PrintCounter = PrintCounter - 1;
end
mdlTerminate(T,VAR,0);



%===========================================================================
% mdlDerivatives: Calculates and returns the derivatives of the continuous states
%===========================================================================
function sys = mdlDerivatives(T,VAR,u)
global   alpha g Ixx Ixy Iyy Izz k l m ra rb;
global   q1 q2 q3 q4 q5 w;
global   q1p q2p q3p q4p q5p wp w1 w3;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

% Update variables after integration step
q1 = VAR(1);
q2 = VAR(2);
q3 = VAR(3);
q4 = VAR(4);
q5 = VAR(5);
w = VAR(6);
z(6) = sin(q3);
z(9) = ra*z(6);
z(4) = sin(q2);
z(3) = cos(q2);
z(13) = z(3)*z(6);
z(20) = z(7)*z(4) + z(8)*z(13);
z(21) = 1 - z(20)^2;
z(22) = z(21)^0.5;
z(24) = z(20)/z(22);
z(23) = 1/z(22);
z(25) = rb*(z(8)*z(24)-z(13)*z(23));
z(28) = z(9) + z(25);
z(26) = rb*(z(7)*z(24)-z(4)*z(23));
z(5) = cos(q3);
z(14) = z(3)*z(5);
z(27) = rb*z(14)*z(23);
z(10) = ra*z(5);
z(29) = z(27) - l - z(10);
z(30) = z(26)^2 + z(28)^2 + z(29)^2;
z(31) = z(30)^0.5;
z(32) = z(28)/z(31);
w1 = w*z(32);
z(33) = z(29)/z(31);
w3 = w*z(33);
q1p = -(sin(q3)*w1-cos(q3)*w3)/cos(q2);
q2p = sin(q3)*w3 + cos(q3)*w1;
q3p = (cos(q2)*z(26)+rb*z(14)*(sin(q2)*z(5)*z(23)-z(14)*z(20)*(z(7)*cos(q2)-z(8)*sin(q2)*z(6))/(z(21)^0.5*z(22)^2))-sin(q2)*z(6)*(z(9)+z(25))-sin(q2)*z(5)*(l+z(10)-z(27))-rb*z(4)*(cos(q2)*z(23)+z(4)*z(20)*(z(7)*cos(q2)-z(8)*sin(q2)*z(6))/(z(21)^0.5*z(22)^2)-z(7)*(z(22)+z(20)^2/z(21)^0.5)*(z(7)*cos(q2)-z(8)*sin(q2)*z(6))/z(22)^2)-rb*z(13)*(z(13)*z(20)*(z(7)*cos(q2)-z(8)*sin(q2)*z(6))/(z(21)^0.5*z(22)^2)-sin(q2)*z(6)*z(23)-z(8)*(z(22)+z(20)^2/z(21)^0.5)*(z(7)*cos(q2)-z(8)*sin(q2)*z(6))/z(22)^2))*q2p/(sin(q3)*z(3)*(l+z(10)-z(27))+rb*z(8)*cos(q3)*z(3)*z(4)*(z(4)*z(20)/z(21)^0.5-z(7)*(z(22)+z(20)^2/z(21)^0.5))/z(22)^2-cos(q3)*z(3)*(z(9)+z(25))-z(14)*(rb*sin(q3)*z(3)*z(23)-ra*sin(q3)-rb*z(8)*cos(q3)*z(3)*z(14)*z(20)/(z(21)^0.5*z(22)^2))-cos(q3)*z(13)*(ra-rb*z(3)*(z(23)+z(8)*z(13)*z(20)/(z(21)^0.5*z(22)^2)-z(8)^2*(z(22)+z(20)^2/z(21)^0.5)/z(22)^2)));
z(1) = cos(q1);
z(2) = sin(q1);
z(12) = z(4)*z(5);
z(11) = z(4)*z(6);
q4p = -(z(9)*(z(1)*z(6)+z(2)*z(12))+z(10)*(z(1)*z(5)-z(2)*z(11)))*q3p;
q5p = -(z(10)*(z(1)*z(11)+z(2)*z(5))-z(9)*(z(1)*z(12)-z(2)*z(6)))*q3p;
z(34) = z(26)/z(31);
z(35) = z(34)*(k+z(10));
z(36) = z(9)*z(33) + z(32)*(k+z(10));
z(37) = z(9)*z(34);
z(18) = z(7)*z(3) - z(8)*z(11);
z(40) = z(18)*z(20);
z(42) = z(40)/z(21)^0.5;
z(44) = (z(18)*z(22)+z(20)*z(42))/z(22)^2;
z(46) = z(42)/z(22)^2;
z(51) = rb*(z(7)*z(44)-z(3)*z(23)-z(4)*z(46));
z(48) = rb*(z(8)*z(44)+z(11)*z(23)-z(13)*z(46));
z(53) = rb*(z(12)*z(23)-z(14)*z(46));
z(56) = 2*z(26)*z(51) + 2*z(28)*z(48) - 2*z(29)*z(53);
z(58) = z(56)/z(30)^0.5;
z(68) = (z(29)*z(58)+2*z(31)*z(53))/z(31)^2;
z(70) = w*z(68);
z(39) = z(8)*z(14);
z(41) = z(20)*z(39);
z(43) = z(41)/z(21)^0.5;
z(45) = (z(20)*z(43)+z(22)*z(39))/z(22)^2;
z(47) = z(43)/z(22)^2;
z(52) = rb*(z(7)*z(45)-z(4)*z(47));
z(49) = rb*(z(8)*z(45)-z(13)*z(47)-z(14)*z(23));
z(50) = z(10) + z(49);
z(54) = rb*(z(13)*z(23)-z(14)*z(47));
z(55) = z(9) - z(54);
z(57) = 2*z(26)*z(52) + 2*z(28)*z(50) + 2*z(29)*z(55);
z(59) = z(57)/z(30)^0.5;
z(69) = (z(29)*z(59)-2*z(31)*z(55))/z(31)^2;
z(71) = w*z(69);
z(74) = -0.5*z(70)*q2p - 0.5*z(71)*q3p;
z(60) = (z(28)*z(58)-2*z(31)*z(48))/z(31)^2;
z(62) = w*z(60);
z(61) = (z(28)*z(59)-2*z(31)*z(50))/z(31)^2;
z(63) = w*z(61);
z(72) = -0.5*z(62)*q2p - 0.5*z(63)*q3p;
z(64) = (z(26)*z(58)-2*z(31)*z(51))/z(31)^2;
z(66) = w*z(64);
z(65) = (z(26)*z(59)-2*z(31)*z(52))/z(31)^2;
z(67) = w*z(65);
z(73) = 0.5*z(66)*q2p + 0.5*z(67)*q3p;
z(78) = -z(9)*z(34) - 0.5*z(65)*(k+z(10));
z(80) = w*z(78);
z(79) = z(64)*(k+z(10));
z(81) = w*z(79);
z(90) = z(80)*q3p - w^2*z(33)*z(36) - w^2*z(34)*z(37) - 0.5*z(81)*q2p;
z(82) = z(10)*z(33) - z(9)*z(32) - 0.5*z(9)*z(69) - 0.5*z(61)*(k+z(10));
z(84) = w*z(82);
z(83) = -0.5*z(9)*z(68) - 0.5*z(60)*(k+z(10));
z(85) = w*z(83);
z(91) = w^2*z(33)*z(35) + z(84)*q3p + z(85)*q2p - w^2*z(32)*z(37);
z(86) = z(10)*z(34) - 0.5*z(9)*z(65);
z(88) = w*z(86);
z(87) = z(9)*z(64);
z(89) = w*z(87);
z(92) = w^2*z(32)*z(36) + w^2*z(34)*z(35) + z(88)*q3p - 0.5*z(89)*q2p;
z(95) = z(94)*(z(13)*z(35)-z(4)*z(36)-z(14)*z(37)) + Izz*z(33)*z(74) + z(32)*(Ixx*z(72)+Ixy*z(73)) + m*(z(35)*z(90)+z(36)*z(91)+z(37)*z(92)) - z(34)*(Ixy*z(72)+Iyy*z(73));
z(93) = -Iyy*z(34)^2 - Izz*z(33)^2 - z(32)*(Ixx*z(32)-2*Ixy*z(34)) - m*(z(35)^2+z(36)^2+z(37)^2);
z(96) = z(95)/z(93);
wp = z(96);

% Update derivative array prior to integration step
VARp(1) = q1p;
VARp(2) = q2p;
VARp(3) = q3p;
VARp(4) = q4p;
VARp(5) = q5p;
VARp(6) = wp;

sys = VARp';



%===========================================================================
% mdlOutputs: Calculates and return the outputs
%===========================================================================
function Output = mdlOutputs(T,VAR,u)
global   alpha g Ixx Ixy Iyy Izz k l m ra rb;
global   q1 q2 q3 q4 q5 w;
global   q1p q2p q3p q4p q5p wp w1 w3;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

% Evaluate output quantities



%===========================================================================
function WriteOutput( fileIdentifier, Output )
numberOfOutputQuantities = length( Output );
if numberOfOutputQuantities > 0,
  for i=1:numberOfOutputQuantities,
    fprintf( fileIdentifier, ' %- 14.6E', Output(i) );
  end
  fprintf( fileIdentifier, '\n' );
end



%===========================================================================
% mdlTerminate: Perform end of simulation tasks and set sys=[]
%===========================================================================
function sys = mdlTerminate(T,VAR,u)
sys = [];



%===========================================================================
% Sfunction: System/Simulink function from standard template
%===========================================================================
function [sys,x0,str,ts] = Sfunction(t,x,u,flag)
switch flag,
  case 0,  [sys,x0,str,ts] = mdlInitializeSizes;    % Initialization of sys, initial state x0, state ordering string str, and sample times ts
  case 1,  sys = mdlDerivatives(t,x,u);             % Calculate the derivatives of continuous states and store them in sys
  case 2,  sys = mdlUpdate(t,x,u);                  % Update discrete states x(n+1) in sys
  case 3,  sys = mdlOutputs(t,x,u);                 % Calculate outputs in sys
  case 4,  sys = mdlGetTimeOfNextVarHit(t,x,u);     % Return next sample time for variable-step in sys
  case 9,  sys = mdlTerminate(t,x,u);               % Perform end of simulation tasks and set sys=[]
  otherwise error(['Unhandled flag = ',num2str(flag)]);
end



%===========================================================================
% mdlInitializeSizes: Return the sizes, initial state VAR, and sample times ts
%===========================================================================
function [sys,VAR,stateOrderingStrings,timeSampling] = mdlInitializeSizes
sizes = simsizes;             % Call simsizes to create a sizes structure
sizes.NumContStates  = 6;     % sys(1) is the number of continuous states
sizes.NumDiscStates  = 0;     % sys(2) is the number of discrete states
sizes.NumOutputs     = 0;     % sys(3) is the number of outputs
sizes.NumInputs      = 0;     % sys(4) is the number of inputs
sizes.DirFeedthrough = 1;     % sys(6) is 1, and allows for the output to be a function of the input
sizes.NumSampleTimes = 1;     % sys(7) is the number of samples times (the number of rows in ts)
sys = simsizes(sizes);        % Convert it to a sizes array
stateOrderingStrings = [];
timeSampling         = [0 0]; % m-by-2 matrix containing the sample times
VAR = ReadUserInput
