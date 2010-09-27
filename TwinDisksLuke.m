function TwinDisksLuke
SolveOrdinaryDifferentialEquations
% File  TwinDisksLuke.m  created by Autolev 4.1 on Wed Sep 22 23:30:38 2010


%===========================================================================
function VAR = ReadUserInput
global   g Ixx Ixy Iyy Izz k l m r;
global   q1 q2 q3 q4 q5 w;
global   q1p q2p q3p q4p q5p wp w1 w3;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

%-------------------------------+--------------------------+-------------------+-----------------
% Quantity                      | Value                    | Units             | Description
%-------------------------------|--------------------------|-------------------|-----------------
g                               =  9.81;                   % m/s^2               Constant
Ixx                             =  0.0;                    % UNITS               Constant
Ixy                             =  0.0;                    % UNITS               Constant
Iyy                             =  0.0;                    % UNITS               Constant
Izz                             =  0.0;                    % UNITS               Constant
k                               =  0.0;                    % m                   Constant
l                               =  .1;                     % m                   Constant
m                               =  0.1;                    % kg                  Constant
r                               =  0.1;                    % m                   Constant

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
z = zeros(86,1);

% Evaluate constants
z(84) = g*m;

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
global   g Ixx Ixy Iyy Izz k l m r;
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
global   g Ixx Ixy Iyy Izz k l m r;
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
z(7) = r*z(6);
z(3) = cos(q2);
z(11) = z(3)*z(6);
z(13) = 1 - z(11)^2;
z(14) = z(13)^0.5;
z(16) = z(11)/z(14);
z(15) = 1/z(14);
z(17) = r*(z(16)-z(11)*z(15));
z(20) = z(7) + z(17);
z(4) = sin(q2);
z(18) = r*z(4)*z(15);
z(5) = cos(q3);
z(12) = z(3)*z(5);
z(19) = r*z(12)*z(15);
z(8) = r*z(5);
z(21) = z(19) - l - z(8);
z(22) = z(18)^2 + z(20)^2 + z(21)^2;
z(23) = z(22)^0.5;
z(24) = z(20)/z(23);
w1 = w*z(24);
z(25) = z(21)/z(23);
w3 = w*z(25);
q1p = -(sin(q3)*w1-cos(q3)*w3)/cos(q2);
q2p = sin(q3)*w3 + cos(q3)*w1;
q3p = (r*sin(q2)*z(6)*z(11)*(z(15)-1/z(14))+r*sin(q2)*z(12)*(z(5)*z(15)+z(6)*z(11)*z(12)/(z(13)^0.5*z(14)^2))-cos(q2)*z(18)-sin(q2)*z(6)*(z(7)+z(17))-sin(q2)*z(5)*(l+z(8)-z(19))-r*z(4)*(cos(q2)*z(15)-sin(q2)*z(4)*z(6)*z(11)/(z(13)^0.5*z(14)^2)))*q2p/(sin(q3)*z(3)*(l+z(8)-z(19))+r*cos(q3)*z(11)*(-1+z(3)*(z(15)-1/z(14)))+r*cos(q3)*z(3)*z(11)*z(4)^2/(z(13)^0.5*z(14)^2)-cos(q3)*z(3)*(z(7)+z(17))-r*z(12)*(sin(q3)*z(3)*z(15)-sin(q3)-cos(q3)*z(3)*z(11)*z(12)/(z(13)^0.5*z(14)^2)));
z(1) = cos(q1);
z(2) = sin(q1);
z(10) = z(4)*z(5);
z(9) = z(4)*z(6);
q4p = -(z(7)*(z(1)*z(6)+z(2)*z(10))+z(8)*(z(1)*z(5)-z(2)*z(9)))*q3p;
q5p = -(z(8)*(z(1)*z(9)+z(2)*z(5))-z(7)*(z(1)*z(10)-z(2)*z(6)))*q3p;
z(30) = z(9)*z(11);
z(32) = z(30)/z(13)^0.5;
z(36) = z(32)/z(14)^2;
z(41) = r*(z(3)*z(15)-z(4)*z(36));
z(34) = (z(9)*z(14)+z(11)*z(32))/z(14)^2;
z(38) = r*(z(34)-z(9)*z(15)-z(11)*z(36));
z(43) = r*(z(10)*z(15)+z(12)*z(36));
z(46) = 2*z(18)*z(41) - 2*z(20)*z(38) - 2*z(21)*z(43);
z(48) = z(46)/z(22)^0.5;
z(58) = (z(21)*z(48)+2*z(23)*z(43))/z(23)^2;
z(60) = w*z(58);
z(31) = z(11)*z(12);
z(33) = z(31)/z(13)^0.5;
z(37) = z(33)/z(14)^2;
z(42) = r*z(4)*z(37);
z(35) = (z(11)*z(33)+z(12)*z(14))/z(14)^2;
z(39) = r*(z(35)-z(11)*z(37)-z(12)*z(15));
z(40) = z(8) + z(39);
z(44) = r*(z(11)*z(15)-z(12)*z(37));
z(45) = z(7) - z(44);
z(47) = 2*z(18)*z(42) + 2*z(20)*z(40) + 2*z(21)*z(45);
z(49) = z(47)/z(22)^0.5;
z(59) = (z(21)*z(49)-2*z(23)*z(45))/z(23)^2;
z(61) = w*z(59);
z(64) = -0.5*z(60)*q2p - 0.5*z(61)*q3p;
z(50) = (z(20)*z(48)+2*z(23)*z(38))/z(23)^2;
z(52) = w*z(50);
z(51) = (z(20)*z(49)-2*z(23)*z(40))/z(23)^2;
z(53) = w*z(51);
z(62) = -0.5*z(52)*q2p - 0.5*z(53)*q3p;
z(54) = (z(18)*z(48)-2*z(23)*z(41))/z(23)^2;
z(56) = w*z(54);
z(55) = (z(18)*z(49)-2*z(23)*z(42))/z(23)^2;
z(57) = w*z(55);
z(63) = -0.5*z(56)*q2p - 0.5*z(57)*q3p;
z(26) = z(18)/z(23);
z(28) = z(7)*z(25) + z(24)*(k+z(8));
z(29) = z(7)*z(26);
z(72) = z(8)*z(25) - z(7)*z(24) - 0.5*z(7)*z(59) - 0.5*z(51)*(k+z(8));
z(74) = w*z(72);
z(73) = -0.5*z(7)*z(58) - 0.5*z(50)*(k+z(8));
z(75) = w*z(73);
z(27) = z(26)*(k+z(8));
z(81) = w^2*z(24)*z(29) + z(74)*q3p + z(75)*q2p - w^2*z(25)*z(27);
z(69) = z(54)*(k+z(8));
z(71) = w*z(69);
z(68) = -z(7)*z(26) - 0.5*z(55)*(k+z(8));
z(70) = w*z(68);
z(80) = 0.5*z(71)*q2p - w^2*z(25)*z(28) - w^2*z(26)*z(29) - z(70)*q3p;
z(77) = z(7)*z(54);
z(79) = w*z(77);
z(76) = z(8)*z(26) - 0.5*z(7)*z(55);
z(78) = w*z(76);
z(82) = w^2*z(24)*z(28) + w^2*z(26)*z(27) + 0.5*z(79)*q2p - z(78)*q3p;
z(85) = Izz*z(25)*z(64) + z(24)*(Ixx*z(62)+Ixy*z(63)) + z(26)*(Ixy*z(62)+Iyy*z(63)) + m*(z(28)*z(81)-z(27)*z(80)-z(29)*z(82)) - z(84)*(z(4)*z(28)+z(11)*z(27)-z(12)*z(29));
z(83) = -Iyy*z(26)^2 - Izz*z(25)^2 - z(24)*(Ixx*z(24)+2*Ixy*z(26)) - m*(z(27)^2+z(28)^2+z(29)^2);
z(86) = z(85)/z(83);
wp = z(86);

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
global   g Ixx Ixy Iyy Izz k l m r;
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
