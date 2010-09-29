function TwinDisksReduced
SolveOrdinaryDifferentialEquations
% File  TwinDisksReduced.m  created by Autolev 4.1 on Mon Sep 27 16:33:21 2010


%===========================================================================
function VAR = ReadUserInput
global   gamma grav m rad;
global   e1 e2 e3 e4 u;
global   l e1p e2p e3p e4p up u1 u2 u3;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

%-------------------------------+--------------------------+-------------------+-----------------
% Quantity                      | Value                    | Units             | Description
%-------------------------------|--------------------------|-------------------|-----------------
gamma                           =  1;                      % UNITS               Constant
grav                            =  0.0;                    % UNITS               Constant
m                               =  2;                      % UNITS               Constant
rad                             =  .1;                     % UNITS               Constant

e1                              =  0.3826834323650898;     % UNITS               Initial Value
e2                              =  0;                      % UNITS               Initial Value
e3                              =  0;                      % UNITS               Initial Value
e4                              =  0.9238795325112867;     % UNITS               Initial Value
u                               =  1;                      % UNITS               Initial Value

TINITIAL                        =  0.0;                    % UNITS               Initial Time
TFINAL                          =  1.0;                    % UNITS               Final Time
INTEGSTP                        =  0.1;                    % UNITS               Integration Step
PRINTINT                        =  1;                      % Positive Integer    Print-Integer
ABSERR                          =  1.0E-08;                %                     Absolute Error
RELERR                          =  1.0E-07 ;               %                     Relative Error
%-------------------------------+--------------------------+-------------------+-----------------

% Unit conversions
Pi       = 3.141592653589793;
DEGtoRAD = Pi/180.0;
RADtoDEG = 180.0/Pi;

% Reserve space and initialize matrices
z = zeros(101,1);

% Evaluate constants
l = 1.414213562373095*gamma*rad;
z(1) = m*rad^2;
z(37) = grav*m;

% Set the initial values of the states
VAR(1) = e1;
VAR(2) = e2;
VAR(3) = e3;
VAR(4) = e4;
VAR(5) = u;



%===========================================================================
function OpenOutputFilesAndWriteHeadings
FileIdentifier = fopen('TwinDisksReduced.1', 'wt');   if( FileIdentifier == -1 ) error('Error: unable to open file TwinDisksReduced.1'); end
fprintf( 1,             '%%      e1             e2             e3             e4              u\n' );
fprintf( 1,             '%%    (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)\n\n' );
fprintf(FileIdentifier, '%% FILE: TwinDisksReduced.1\n%%\n' );
fprintf(FileIdentifier, '%%      e1             e2             e3             e4              u\n' );
fprintf(FileIdentifier, '%%    (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)\n\n' );



%===========================================================================
% Main driver loop for numerical integration of differential equations
%===========================================================================
function SolveOrdinaryDifferentialEquations
global   gamma grav m rad;
global   e1 e2 e3 e4 u;
global   l e1p e2p e3p e4p up u1 u2 u3;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

OpenOutputFilesAndWriteHeadings
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
global   gamma grav m rad;
global   e1 e2 e3 e4 u;
global   l e1p e2p e3p e4p up u1 u2 u3;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

% Update variables after integration step
e1 = VAR(1);
e2 = VAR(2);
e3 = VAR(3);
e4 = VAR(4);
u = VAR(5);
z(8) = 2*e1*e3 - 2*e2*e4;
z(10) = 1 - 2*e1^2 - 2*e2^2;
z(11) = 1 - z(10)^2;
z(12) = z(11)^0.5;
z(14) = 1/z(12);
z(16) = rad*z(14);
z(9) = 2*e1*e4 + 2*e2*e3;
z(17) = 1 - z(9)^2;
z(18) = z(17)^0.5;
z(20) = 1/z(18);
z(22) = rad*z(20);
z(23) = z(16) - z(22);
z(24) = z(8)*z(23) - l;
z(19) = z(9)/z(18);
z(21) = rad*z(19);
z(25) = z(21) + z(9)*z(23);
u2 = z(25)*u;
z(13) = z(10)/z(12);
z(15) = rad*z(13);
z(26) = z(10)*z(23) - z(15);
u3 = z(26)*u;
z(56) = z(1)*u3;
z(55) = z(1)*u2;
z(65) = 0.5*u2*z(56) - 0.25*u3*z(55);
z(68) = 0.25*u2*z(56) - 0.5*u3*z(55);
u1 = z(24)*u;
z(54) = z(1)*u1;
z(64) = 0.25*u3*z(54) - 0.5*u1*z(56);
z(63) = 0.25*u1*z(55) - 0.25*u2*z(54);
z(66) = 0.5*u1*z(55) - 0.25*u2*z(54);
z(29) = e1*z(25) + e4*z(26) - e2*z(24);
z(30) = e1*z(24) + e2*z(25) + e3*z(26);
z(27) = e2*z(26) + e4*z(24) - e3*z(25);
z(28) = e3*z(24) + e4*z(25) - e1*z(26);
z(39) = (e1*z(29)+e2*z(30)+e3*z(27)-e4*z(28))*u;
z(40) = (e1*z(27)+e2*z(28))*u;
z(41) = z(10)*z(40)/z(11)^0.5;
z(42) = rad*z(41)/z(12)^2;
z(43) = (e1*z(30)-e2*z(29)-e3*z(28)-e4*z(27))*u;
z(44) = z(9)*z(43)/z(17)^0.5;
z(45) = rad*z(44)/z(18)^2;
z(46) = z(23)*z(39) - z(8)*(2*z(42)-z(45));
z(47) = u*z(46);
z(58) = z(1)*z(47);
z(48) = (z(9)*z(44)+z(18)*z(43))/z(18)^2;
z(49) = -rad*z(48) - z(23)*z(43) - z(9)*(2*z(42)-z(45));
z(50) = u*z(49);
z(60) = z(1)*z(50);
z(51) = (z(10)*z(41)+z(12)*z(40))/z(12)^2;
z(52) = 2*rad*z(51) - 2*z(23)*z(40) - z(10)*(2*z(42)-z(45));
z(53) = u*z(52);
z(62) = z(1)*z(53);
z(32) = z(15)*z(24);
z(75) = z(15)*z(46) - 2*rad*z(24)*z(51);
z(76) = u*z(75);
z(31) = z(15)*z(25);
z(69) = z(31)*u;
z(89) = z(76) - u3*z(69);
z(5) = 2*e1*e2 + 2*e3*e4;
z(6) = 1 - 2*e1^2 - 2*e3^2;
z(7) = 2*e2*e3 - 2*e1*e4;
z(33) = z(16)*(z(5)*z(24)+z(6)*z(25)+z(7)*z(26));
z(77) = (e3*z(30)-e1*z(28)-e2*z(27)-e4*z(29))*u;
z(78) = (e1*z(27)+e3*z(29))*u;
z(79) = (e1*z(30)+e2*z(29)+e3*z(28)-e4*z(27))*u;
z(80) = -2*(z(5)*z(24)+z(6)*z(25)+z(7)*z(26))*z(42) - z(16)*(z(24)*z(77)+2*z(25)*z(78)-z(5)*z(46)-z(6)*z(49)-z(7)*z(52)-z(26)*z(79));
z(81) = u*z(80);
z(2) = 1 - 2*e2^2 - 2*e3^2;
z(3) = 2*e1*e2 - 2*e3*e4;
z(4) = 2*e1*e3 + 2*e2*e4;
z(34) = z(16)*(z(2)*z(24)+z(3)*z(25)+z(4)*z(26));
z(83) = (e1*z(28)+e2*z(27)+e3*z(30)-e4*z(29))*u;
z(82) = (e2*z(28)+e3*z(29))*u;
z(84) = (e2*z(30)-e1*z(29)-e3*z(27)-e4*z(28))*u;
z(85) = z(16)*(z(2)*z(46)+z(3)*z(49)+z(4)*z(52)+z(25)*z(83)-2*z(24)*z(82)-z(26)*z(84)) - 2*(z(2)*z(24)+z(3)*z(25)+z(4)*z(26))*z(42);
z(86) = u*z(85);
z(73) = z(15)*z(49) - 2*rad*z(25)*z(51);
z(74) = u*z(73);
z(70) = z(32)*u;
z(87) = -z(74) - u3*z(70);
z(88) = u1*z(70) + u2*z(69);
z(35) = z(32) - l*z(26);
z(92) = z(75) - l*z(52);
z(93) = u*z(92);
z(36) = l*z(25);
z(91) = z(36)*u;
z(97) = z(93) - u1*z(91) - u3*z(69);
z(94) = l*u*z(49);
z(90) = z(35)*u;
z(96) = z(94) + u1*z(90) + u2*z(69);
z(95) = u2*z(91) - z(74) - u3*z(90);
z(67) = 0.25*u1*z(56) - 0.25*u3*z(54);
z(99) = z(24)*z(65) + z(24)*z(68) + z(25)*z(64) + z(26)*z(63) + z(26)*z(66) + 0.5*z(24)*z(58) + 0.75*z(25)*z(60) + 0.75*z(26)*z(62) + m*(z(32)*z(89)+2*z(33)*z(81)+2*z(34)*z(86)+z(2)*z(33)*z(87)+z(3)*z(32)*z(81)+z(3)*z(33)*z(89)+z(4)*z(33)*z(88)+2*z(5)*z(31)*z(86)-z(31)*z(87)-z(5)*z(34)*z(87)-z(6)*z(32)*z(86)-z(6)*z(34)*z(89)-z(7)*z(34)*z(88)) + m*(z(35)*z(97)+z(36)*z(96)+z(2)*z(33)*z(95)+z(3)*z(33)*z(97)+z(3)*z(35)*z(81)+z(4)*z(33)*z(96)+z(4)*z(36)*z(81)-z(31)*z(95)-2*z(2)*z(31)*z(81)-z(5)*z(34)*z(95)-z(6)*z(34)*z(97)-z(6)*z(35)*z(86)-z(7)*z(34)*z(96)-z(7)*z(36)*z(86)) - z(25)*z(67);
z(38) = z(37)*(2*z(8)*z(31)-z(9)*z(32)-z(9)*z(35)-z(10)*z(36));
z(100) = z(99) - z(38);
z(57) = z(1)*z(24);
z(59) = z(1)*z(25);
z(61) = z(1)*z(26);
z(98) = 0.5*z(24)*z(57) + 0.75*z(25)*z(59) + 0.75*z(26)*z(61) + m*(z(32)^2+2*z(31)^2+2*z(33)^2+2*z(34)^2+2*z(3)*z(32)*z(33)+4*z(5)*z(31)*z(34)-2*z(6)*z(32)*z(34)) + m*(z(35)^2+z(36)^2+2*z(3)*z(33)*z(35)+2*z(4)*z(33)*z(36)-4*z(2)*z(31)*z(33)-2*z(6)*z(34)*z(35)-2*z(7)*z(34)*z(36));
z(101) = z(100)/z(98);
up = -z(101);
e1p = 0.5*z(27)*u;
e2p = 0.5*z(28)*u;
e3p = 0.5*z(29)*u;
e4p = -0.5*z(30)*u;

% Update derivative array prior to integration step
VARp(1) = e1p;
VARp(2) = e2p;
VARp(3) = e3p;
VARp(4) = e4p;
VARp(5) = up;

sys = VARp';



%===========================================================================
% mdlOutputs: Calculates and return the outputs
%===========================================================================
function Output = mdlOutputs(T,VAR,u)
global   gamma grav m rad;
global   e1 e2 e3 e4 u;
global   l e1p e2p e3p e4p up u1 u2 u3;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

% Evaluate output quantities
Output(1)=e1;  Output(2)=e2;  Output(3)=e3;  Output(4)=e4;  Output(5)=u;
FileIdentifier = fopen('all');
WriteOutput( 1,                 Output(1:5) );
WriteOutput( FileIdentifier(1), Output(1:5) );



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
FileIdentifier = fopen('all');
fclose( FileIdentifier(1) );
fprintf( 1, '\n Output is in the file TwinDisksReduced.1\n' );
fprintf( 1, '\n To load and plot columns 1 and 2 with a solid line and columns 1 and 3 with a dashed line, enter:\n' );
fprintf( 1, '    someName = load( ''TwinDisksReduced.1'' );\n' );
fprintf( 1, '    plot( someName(:,1), someName(:,2), ''-'', someName(:,1), someName(:,3), ''--'' )\n\n' );
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
sizes.NumContStates  = 5;     % sys(1) is the number of continuous states
sizes.NumDiscStates  = 0;     % sys(2) is the number of discrete states
sizes.NumOutputs     = 5;     % sys(3) is the number of outputs
sizes.NumInputs      = 0;     % sys(4) is the number of inputs
sizes.DirFeedthrough = 1;     % sys(6) is 1, and allows for the output to be a function of the input
sizes.NumSampleTimes = 1;     % sys(7) is the number of samples times (the number of rows in ts)
sys = simsizes(sizes);        % Convert it to a sizes array
stateOrderingStrings = [];
timeSampling         = [0 0]; % m-by-2 matrix containing the sample times
OpenOutputFilesAndWriteHeadings
VAR = ReadUserInput
