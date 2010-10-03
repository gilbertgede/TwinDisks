function TwinDisksConstraintForcesExtra(uu,tfina)
SolveOrdinaryDifferentialEquations(uu,tfina)
% File  TwinDisksConstraintForcesExtra.m  created by Autolev 4.1 on Fri Oct 01 16:58:08 2010


%===========================================================================
function VAR = ReadUserInput(uu,tfina)
global   gamma m rad;
global   cahat1 cahat2 cahat3 cbhat1 cbhat2 cbhat3 e1 e2 e3 e4 posa1 posa2 posa3 posb1 posb2 posb3 q1 q2 q3 u;
global   InertIn InertOut l aforce1 aforce2 aforce3 bforce1 bforce2 bforce3 ke pe u1 u2 u3 u4 u5 u6 cahat1p cahat2p cahat3p cbhat1p cbhat2p cbhat3p e1p e2p e3p e4p posa1p posa2p posa3p posb1p posb2p posb3p q1p q2p q3p up TI11 TI22 TI33;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

%-------------------------------+--------------------------+-------------------+-----------------
% Quantity                      | Value                    | Units             | Description
%-------------------------------|--------------------------|-------------------|-----------------
gamma                           =  1;                      % UNITS               Constant
m                               =  2;                      % UNITS               Constant
rad                             =  .1;                     % UNITS               Constant

cahat1                          =  0;                      % UNITS               Initial Value
cahat2                          =  0;                      % UNITS               Initial Value
cahat3                          =  0;                      % UNITS               Initial Value
cbhat1                          = -0.1414213562373095;     % UNITS               Initial Value
cbhat2                          =  0.1414213562373095;     % UNITS               Initial Value
cbhat3                          =  0;                      % UNITS               Initial Value
e1                              =  0.3826834323650898;     % UNITS               Initial Value
e2                              =  0;                      % UNITS               Initial Value
e3                              =  0;                      % UNITS               Initial Value
e4                              =  0.9238795325112867;     % UNITS               Initial Value
posa1                           =  0;                      % UNITS               Initial Value
posa2                           =  0.07071067811865475;    % UNITS               Initial Value
posa3                           =  0.07071067811865477;    % UNITS               Initial Value
posb1                           = -0.1414213562373095;     % UNITS               Initial Value
posb2                           =  0.07071067811865475;    % UNITS               Initial Value
posb3                           =  0.07071067811865477;    % UNITS               Initial Value
q1                              =  0.0;                    % UNITS               Initial Value
q2                              =  0.0;                    % UNITS               Initial Value
q3                              =  0.0;                    % UNITS               Initial Value
u                               =  uu*5.041/3;                % UNITS               Initial Value

TINITIAL                        =  0.0;                    % UNITS               Initial Time
TFINAL                          =  tfina;                  % UNITS               Final Time
INTEGSTP                        =  0.01;                   % UNITS               Integration Step
PRINTINT                        =  1;                      % Positive Integer    Print-Integer
ABSERR                          =  1.0E-08;                %                     Absolute Error
RELERR                          =  1.0E-07 ;               %                     Relative Error
%-------------------------------+--------------------------+-------------------+-----------------

% Unit conversions
Pi       = 3.141592653589793;
DEGtoRAD = Pi/180.0;
RADtoDEG = 180.0/Pi;

% Reserve space and initialize matrices
z = zeros(317,1);

% Evaluate constants
InertIn = 0.25*m*rad^2;
cahat3p = 0;
cbhat3p = 0;
l = 1.414213562373095*gamma*rad;
InertOut = 0.5*m*rad^2;
z(23) = l^2;
TI11 = 2*InertIn + 0.5*m*l^2;
TI22 = InertIn + InertOut + 0.5*m*l^2;
TI33 = InertIn + InertOut + 0.5*m*l^2;

% Set the initial values of the states
VAR(1) = cahat1;
VAR(2) = cahat2;
VAR(3) = cahat3;
VAR(4) = cbhat1;
VAR(5) = cbhat2;
VAR(6) = cbhat3;
VAR(7) = e1;
VAR(8) = e2;
VAR(9) = e3;
VAR(10) = e4;
VAR(11) = posa1;
VAR(12) = posa2;
VAR(13) = posa3;
VAR(14) = posb1;
VAR(15) = posb2;
VAR(16) = posb3;
VAR(17) = q1;
VAR(18) = q2;
VAR(19) = q3;
VAR(20) = u;



%===========================================================================
function OpenOutputFilesAndWriteHeadings
FileIdentifier = fopen('TwinDisksConstraintForcesExtra.1', 'wt');   if( FileIdentifier == -1 ) error('Error: unable to open file TwinDisksConstraintForcesExtra.1'); end
fprintf( 1,             '%%           t                      ke                      pe                     ke+pe                    e1                      e2                      e3                      e4                       u                    cahat1                  cahat2                  cahat3                  cbhat1                  cbhat2                  cbhat3                    u1                      u2                      u3                      u4                      u5                      u6                      q1                      q2                      q3                    aforce1                 aforce2                 aforce3                 bforce1                 bforce2                 bforce3         dot(unitvec(p_ahat_bhat\n' );
fprintf( 1,             '%%        (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)\n\n' );
fprintf(FileIdentifier, '%% FILE: TwinDisksConstraintForcesExtra.1\n%%\n' );
fprintf(FileIdentifier, '%%           t                      ke                      pe                     ke+pe                    e1                      e2                      e3                      e4                       u                    cahat1                  cahat2                  cahat3                  cbhat1                  cbhat2                  cbhat3                    u1                      u2                      u3                      u4                      u5                      u6                      q1                      q2                      q3                    aforce1                 aforce2                 aforce3                 bforce1                 bforce2                 bforce3         dot(unitvec(p_ahat_bhat\n' );
fprintf(FileIdentifier, '%%        (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)                 (UNITS)\n\n' );



%===========================================================================
% Main driver loop for numerical integration of differential equations
%===========================================================================
function SolveOrdinaryDifferentialEquations(uu,tfina)
global   gamma m rad;
global   cahat1 cahat2 cahat3 cbhat1 cbhat2 cbhat3 e1 e2 e3 e4 posa1 posa2 posa3 posb1 posb2 posb3 q1 q2 q3 u;
global   InertIn InertOut l aforce1 aforce2 aforce3 bforce1 bforce2 bforce3 ke pe u1 u2 u3 u4 u5 u6 cahat1p cahat2p cahat3p cbhat1p cbhat2p cbhat3p e1p e2p e3p e4p posa1p posa2p posa3p posb1p posb2p posb3p q1p q2p q3p up TI11 TI22 TI33;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

OpenOutputFilesAndWriteHeadings
VAR = ReadUserInput(uu,tfina);
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
global   gamma m rad;
global   cahat1 cahat2 cahat3 cbhat1 cbhat2 cbhat3 e1 e2 e3 e4 posa1 posa2 posa3 posb1 posb2 posb3 q1 q2 q3 u;
global   InertIn InertOut l aforce1 aforce2 aforce3 bforce1 bforce2 bforce3 ke pe u1 u2 u3 u4 u5 u6 cahat1p cahat2p cahat3p cbhat1p cbhat2p cbhat3p e1p e2p e3p e4p posa1p posa2p posa3p posb1p posb2p posb3p q1p q2p q3p up TI11 TI22 TI33;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

% Update variables after integration step
cahat1 = VAR(1);
cahat2 = VAR(2);
cahat3 = VAR(3);
cbhat1 = VAR(4);
cbhat2 = VAR(5);
cbhat3 = VAR(6);
e1 = VAR(7);
e2 = VAR(8);
e3 = VAR(9);
e4 = VAR(10);
posa1 = VAR(11);
posa2 = VAR(12);
posa3 = VAR(13);
posb1 = VAR(14);
posb2 = VAR(15);
posb3 = VAR(16);
q1 = VAR(17);
q2 = VAR(18);
q3 = VAR(19);
u = VAR(20);
z(7) = 2*e1*e3 - 2*e2*e4;
z(9) = 1 - 2*e1^2 - 2*e2^2;
z(10) = 1 - z(9)^2;
z(11) = z(10)^0.5;
z(13) = 1/z(11);
z(15) = rad*z(13);
z(8) = 2*e1*e4 + 2*e2*e3;
z(16) = 1 - z(8)^2;
z(17) = z(16)^0.5;
z(19) = 1/z(17);
z(21) = rad*z(19);
z(22) = z(15) - z(21);
z(12) = z(9)/z(11);
z(14) = rad*z(12);
z(18) = z(8)/z(17);
z(20) = rad*z(18);
z(24) = z(23) + z(14)^2 + z(20)^2 + z(22)^2 + 2*z(8)*z(20)*z(22) - 2*l*z(7)*z(22) - 2*z(9)*z(14)*z(22);
z(25) = z(24)^0.5;
z(27) = z(22)/z(25);
z(28) = l/z(25);
z(30) = z(7)*z(27) - z(28);
z(29) = z(20)/z(25);
z(31) = z(29) + z(8)*z(27);
z(65) = z(31)*u;
z(26) = z(14)/z(25);
z(32) = z(9)*z(27) - z(26);
z(66) = z(32)*u;
z(284) = InertOut*z(66);
z(283) = InertIn*z(65);
z(293) = z(65)*z(284) - z(66)*z(283);
z(295) = InertIn*z(66);
z(294) = InertOut*z(65);
z(302) = z(65)*z(295) - z(66)*z(294);
z(36) = e1*z(30) + e2*z(31) + e3*z(32);
z(35) = e1*z(31) + e4*z(32) - e2*z(30);
z(34) = e3*z(30) + e4*z(31) - e1*z(32);
z(33) = e2*z(32) + e4*z(30) - e3*z(31);
z(52) = (e1*z(36)-e2*z(35)-e3*z(34)-e4*z(33))*u;
z(53) = z(8)*z(52)/z(16)^0.5;
z(54) = (z(8)*z(53)+z(17)*z(52))/z(17)^2;
z(49) = (e1*z(33)+e2*z(34))*u;
z(50) = z(9)*z(49)/z(10)^0.5;
z(51) = (z(9)*z(50)+z(11)*z(49))/z(11)^2;
z(55) = rad*z(50)/z(11)^2;
z(56) = rad*z(53)/z(17)^2;
z(57) = (e1*z(35)+e2*z(36)+e3*z(33)-e4*z(34))*u;
z(58) = 4*z(14)*z(22)*z(49) + 4*rad*z(9)*z(22)*z(51) + 2*l*z(7)*(2*z(55)-z(56)) + 2*z(9)*z(14)*(2*z(55)-z(56)) - 4*rad*z(14)*z(51) - 2*l*z(22)*z(57) - 2*rad*z(20)*z(54) - 2*z(20)*z(22)*z(52) - 2*rad*z(8)*z(22)*z(54) - 2*z(22)*(2*z(55)-z(56)) - 2*z(8)*z(20)*(2*z(55)-z(56));
z(59) = (2*rad*z(25)*z(54)+z(20)*z(58)/z(24)^0.5)/z(25)^2;
z(60) = (z(22)*z(58)/z(24)^0.5+2*z(25)*(2*z(55)-z(56)))/z(25)^2;
z(61) = -0.5*z(59) - z(27)*z(52) - 0.5*z(8)*z(60);
z(89) = u*z(61);
z(288) = InertIn*z(89);
z(64) = z(30)*u;
z(282) = InertIn*z(64);
z(292) = z(66)*z(282) - z(64)*z(284);
z(297) = InertOut*z(89);
z(70) = (4*rad*z(25)*z(51)+z(14)*z(58)/z(24)^0.5)/z(25)^2;
z(71) = 0.5*z(70) - 2*z(27)*z(49) - 0.5*z(9)*z(60);
z(90) = u*z(71);
z(290) = InertOut*z(90);
z(291) = z(64)*z(283) - z(65)*z(282);
z(299) = InertIn*z(90);
z(300) = z(64)*z(294) - z(65)*z(282);
z(67) = l*z(58)/(z(24)^0.5*z(25)^2);
z(68) = 0.5*z(67) + z(27)*z(57) - 0.5*z(7)*z(60);
z(88) = u*z(68);
z(286) = InertIn*z(88);
z(38) = z(14)*z(30);
z(69) = z(14)*z(68) - 2*rad*z(30)*z(51);
z(304) = u*z(69);
z(37) = z(14)*z(31);
z(44) = z(37)*u;
z(307) = z(304) - z(44)*z(66);
z(4) = 2*e1*e2 + 2*e3*e4;
z(5) = 1 - 2*e1^2 - 2*e3^2;
z(6) = 2*e2*e3 - 2*e1*e4;
z(39) = z(15)*(z(4)*z(30)+z(5)*z(31)+z(6)*z(32));
z(75) = (e3*z(36)-e1*z(34)-e2*z(33)-e4*z(35))*u;
z(76) = (e1*z(33)+e3*z(35))*u;
z(77) = (e1*z(36)+e2*z(35)+e3*z(34)-e4*z(33))*u;
z(78) = -2*(z(4)*z(30)+z(5)*z(31)+z(6)*z(32))*z(55) - z(15)*(z(30)*z(75)+2*z(31)*z(76)-z(4)*z(68)-z(5)*z(61)-z(6)*z(71)-z(32)*z(77));
z(79) = u*z(78);
z(1) = 1 - 2*e2^2 - 2*e3^2;
z(2) = 2*e1*e2 - 2*e3*e4;
z(3) = 2*e1*e3 + 2*e2*e4;
z(40) = z(15)*(z(1)*z(30)+z(2)*z(31)+z(3)*z(32));
z(81) = (e1*z(34)+e2*z(33)+e3*z(36)-e4*z(35))*u;
z(80) = (e2*z(34)+e3*z(35))*u;
z(82) = (e2*z(36)-e1*z(35)-e3*z(33)-e4*z(34))*u;
z(83) = z(15)*(z(1)*z(68)+z(2)*z(61)+z(3)*z(71)+z(31)*z(81)-2*z(30)*z(80)-z(32)*z(82)) - 2*(z(1)*z(30)+z(2)*z(31)+z(3)*z(32))*z(55);
z(84) = u*z(83);
z(62) = z(14)*z(61) - 2*rad*z(31)*z(51);
z(63) = u*z(62);
z(303) = z(38)*u;
z(305) = -z(63) - z(66)*z(303);
z(306) = z(44)*z(65) + z(64)*z(303);
z(41) = z(38) - l*z(32);
z(309) = z(69) - l*z(71);
z(310) = u*z(309);
z(42) = l*z(31);
z(46) = z(42)*u;
z(313) = z(310) - z(44)*z(66) - z(46)*z(64);
z(74) = l*u*z(61);
z(308) = z(41)*u;
z(312) = z(74) + z(44)*z(65) + z(64)*z(308);
z(311) = z(46)*z(65) - z(63) - z(66)*z(308);
z(301) = z(64)*z(295) - z(66)*z(282);
z(315) = z(30)*z(293) + z(30)*z(302) + z(31)*z(288) + z(31)*z(292) + z(31)*z(297) + z(32)*z(290) + z(32)*z(291) + z(32)*z(299) + z(32)*z(300) + 2*z(30)*z(286) + m*(z(38)*z(307)+2*z(39)*z(79)+2*z(40)*z(84)+z(1)*z(39)*z(305)+z(2)*z(38)*z(79)+z(2)*z(39)*z(307)+z(3)*z(39)*z(306)+2*z(4)*z(37)*z(84)-z(37)*z(305)-z(4)*z(40)*z(305)-z(5)*z(38)*z(84)-z(5)*z(40)*z(307)-z(6)*z(40)*z(306)) + m*(z(41)*z(313)+z(42)*z(312)+z(1)*z(39)*z(311)+z(2)*z(39)*z(313)+z(2)*z(41)*z(79)+z(3)*z(39)*z(312)+z(3)*z(42)*z(79)-z(37)*z(311)-2*z(1)*z(37)*z(79)-z(4)*z(40)*z(311)-z(5)*z(40)*z(313)-z(5)*z(41)*z(84)-z(6)*z(40)*z(312)-z(6)*z(42)*z(84)) - z(31)*z(301);
z(281) = m*(2*z(7)*z(37)-z(8)*z(38)-z(8)*z(41)-z(9)*z(42));
z(316) = z(315) - 9.810000000000001*z(281);
z(287) = InertIn*z(31);
z(296) = InertOut*z(31);
z(289) = InertOut*z(32);
z(298) = InertIn*z(32);
z(285) = InertIn*z(30);
z(314) = z(31)*z(287) + z(31)*z(296) + z(32)*z(289) + z(32)*z(298) + 2*z(30)*z(285) + m*(z(38)^2+2*z(37)^2+2*z(39)^2+2*z(40)^2+2*z(2)*z(38)*z(39)+4*z(4)*z(37)*z(40)-2*z(5)*z(38)*z(40)) + m*(z(41)^2+z(42)^2+2*z(2)*z(39)*z(41)+2*z(3)*z(39)*z(42)-4*z(1)*z(37)*z(39)-2*z(5)*z(40)*z(41)-2*z(6)*z(40)*z(42));
z(317) = z(316)/z(314);
up = -z(317);
e1p = 0.5*z(33)*u;
e2p = 0.5*z(34)*u;
e3p = 0.5*z(35)*u;
e4p = -0.5*z(36)*u;
posa1p = -(z(1)*z(37)-z(39)-z(2)*z(38))*u;
posa2p = -(z(40)+z(4)*z(37)-z(5)*z(38))*u;
posa3p = -(z(7)*z(37)-z(8)*z(38))*u;
posb1p = -(z(1)*z(37)-z(39)-z(2)*z(41)-z(3)*z(42))*u;
posb2p = -(z(40)+z(4)*z(37)-z(5)*z(41)-z(6)*z(42))*u;
posb3p = -(z(7)*z(37)-z(8)*z(41)-z(9)*z(42))*u;
u3 = z(32)*u;
cahat1p = z(39)*u + z(2)*(z(38)-z(14)*z(30))*u + z(6)*z(15)*(u3-z(32)*u) - z(4)*z(15)*z(30)*u - z(5)*z(15)*z(31)*u - z(1)*(z(37)-z(14)*z(31))*u;
cahat2p = z(1)*z(15)*z(30)*u + z(2)*z(15)*z(31)*u + z(5)*(z(38)-z(14)*z(30))*u - z(40)*u - z(3)*z(15)*(u3-z(32)*u) - z(4)*(z(37)-z(14)*z(31))*u;
cbhat1p = (z(39)+z(2)*z(41)+z(3)*z(42)+z(3)*z(20)*z(30)-z(1)*z(37)-z(1)*z(20)*z(32)-z(4)*z(21)*z(30)-z(6)*z(21)*z(32))*u;
cbhat2p = -(z(40)+z(4)*z(37)+z(4)*z(20)*z(32)-z(5)*z(41)-z(6)*z(42)-z(1)*z(21)*z(30)-z(3)*z(21)*z(32)-z(6)*z(20)*z(30))*u;
u1 = z(30)*u;
q1p = u1;
u2 = z(31)*u;
q2p = u2;
q3p = u3;

% Update derivative array prior to integration step
VARp(1) = cahat1p;
VARp(2) = cahat2p;
VARp(3) = cahat3p;
VARp(4) = cbhat1p;
VARp(5) = cbhat2p;
VARp(6) = cbhat3p;
VARp(7) = e1p;
VARp(8) = e2p;
VARp(9) = e3p;
VARp(10) = e4p;
VARp(11) = posa1p;
VARp(12) = posa2p;
VARp(13) = posa3p;
VARp(14) = posb1p;
VARp(15) = posb2p;
VARp(16) = posb3p;
VARp(17) = q1p;
VARp(18) = q2p;
VARp(19) = q3p;
VARp(20) = up;

sys = VARp';



%===========================================================================
% mdlOutputs: Calculates and return the outputs
%===========================================================================
function Output = mdlOutputs(T,VAR,u)
global   gamma m rad;
global   cahat1 cahat2 cahat3 cbhat1 cbhat2 cbhat3 e1 e2 e3 e4 posa1 posa2 posa3 posb1 posb2 posb3 q1 q2 q3 u;
global   InertIn InertOut l aforce1 aforce2 aforce3 bforce1 bforce2 bforce3 ke pe u1 u2 u3 u4 u5 u6 cahat1p cahat2p cahat3p cbhat1p cbhat2p cbhat3p e1p e2p e3p e4p posa1p posa2p posa3p posb1p posb2p posb3p q1p q2p q3p up TI11 TI22 TI33;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

% Evaluate output quantities
ke = 0.5*(InertIn*z(31)^2+InertIn*z(32)^2+InertOut*z(31)^2+InertOut*z(32)^2+2*InertIn*z(30)^2+m*(z(38)^2+2*z(37)^2+2*z(39)^2+2*z(40)^2+2*z(2)*z(38)*z(39)+4*z(4)*z(37)*z(40)-2*z(5)*z(38)*z(40))+m*(z(41)^2+z(42)^2+2*z(2)*z(39)*z(41)+2*z(3)*z(39)*z(42)-4*z(1)*z(37)*z(39)-2*z(5)*z(40)*z(41)-2*z(6)*z(40)*z(42)))*u^2;
pe = 9.810000000000001*m*(posa3+posb3);
u4 = -(z(1)*z(37)-z(39)-z(2)*z(38))*u;
u5 = -(z(40)+z(4)*z(37)-z(5)*z(38))*u;
u6 = -(z(7)*z(37)-z(8)*z(38))*u;
z(93) = -2*z(7)*z(8)*z(28)*z(29) - 2*z(8)*z(9)*z(26)*z(29) - z(7)^2*z(29)^2 - z(8)^2*z(26)^2 - z(8)^2*z(28)^2 - z(9)^2*z(29)^2 - (z(7)*z(26)-z(9)*z(28))^2;
z(110) = z(8)*z(20)*z(26) + z(9)*z(29)*(z(20)-z(8)*z(21)) - z(21)*z(26)*z(8)^2 - 0.5*l*(z(7)*z(26)-z(9)*z(28)) - z(7)*z(21)*(z(7)*z(26)-z(9)*z(28));
z(96) = z(14)*(z(1)*z(6)-z(3)*z(4));
z(103) = z(9)*z(21)*z(28) + 0.5*l*z(1)*z(5)*z(27) - 0.5*l*z(26) - z(7)*z(21)*z(26) - 0.5*l*z(2)*z(4)*z(27);
z(97) = z(8)*z(21)*z(26) + z(9)*z(21)*z(29) + z(1)*z(5)*z(20)*z(27) - z(20)*z(26) - z(2)*z(4)*z(20)*z(27);
z(102) = 0.5*z(2)*(l*z(4)+2*z(6)*z(14)) - 0.5*z(5)*(l*z(1)+2*z(3)*z(14));
z(158) = z(96)*z(103) - z(97)*z(102);
z(109) = z(20)*z(28) + 0.5*z(6)*z(27)*(l*z(1)-2*z(2)*z(20)) - z(8)*z(21)*z(28) - 0.5*z(29)*(l+2*z(7)*z(21)) - 0.5*z(3)*z(27)*(l*z(4)-2*z(5)*z(20));
z(104) = 0.5*l*z(8)*z(28) + z(7)*z(8)*z(21)*z(28) + z(8)*z(9)*z(21)*z(26) + 0.5*z(29)*(l*z(7)+2*z(21)*z(7)^2+2*z(21)*z(9)^2);
z(98) = z(8)*z(20)*z(28) + z(7)*z(29)*(z(20)-z(8)*z(21)) + z(9)*z(21)*(z(7)*z(26)-z(9)*z(28)) - z(21)*z(28)*z(8)^2;
z(155) = z(96)*z(104) - z(98)*z(102);
z(108) = l*(z(1)*z(6)-z(3)*z(4));
z(151) = z(97)*z(104) - z(98)*z(103);
z(159) = z(110)*z(158) - z(109)*z(155) - 0.5*z(108)*z(151);
z(105) = l*(z(1)*z(5)-z(2)*z(4));
z(99) = z(20)*(z(1)*z(5)-z(2)*z(4));
z(153) = 0.5*z(98)*z(105) - z(99)*z(104);
z(111) = 0.5*z(6)*(l*z(1)-2*z(2)*z(20)) - 0.5*z(3)*(l*z(4)-2*z(5)*z(20));
z(152) = 0.5*z(97)*z(105) - z(99)*z(103);
z(154) = z(109)*z(153) + z(111)*z(151) - z(110)*z(152);
z(107) = 0.5*l*(z(7)*z(26)-z(9)*z(28)) - z(8)*z(9)*z(15)*z(29) - z(15)*z(26)*z(8)^2 - z(7)*z(15)*(z(7)*z(26)-z(9)*z(28));
z(95) = z(9)*z(15)*(z(7)*z(26)-z(9)*z(28)) - z(7)*z(8)*z(15)*z(29) - z(15)*z(28)*z(8)^2 - z(14)*(z(7)*z(26)-z(9)*z(28));
z(101) = z(7)*z(8)*z(15)*z(28) + z(8)*z(9)*z(15)*z(26) - z(8)*z(14)*z(26) - 0.5*l*z(8)*z(28) - 0.5*z(29)*(l*z(7)+2*z(9)*z(14)-2*z(15)*z(7)^2-2*z(15)*z(9)^2);
z(160) = z(95)*z(103) - z(97)*z(101);
z(161) = 0.5*z(95)*z(105) - z(99)*z(101);
z(162) = z(107)*z(152) + z(111)*z(160) - z(109)*z(161);
z(163) = z(95)*z(102) - z(96)*z(101);
z(165) = z(107)*z(158) + z(109)*z(163) + 0.5*z(108)*z(160);
z(92) = z(7)*z(28) + z(9)*z(26) - z(27) - z(8)*z(29);
z(135) = z(92)*z(93);
z(156) = 0.5*z(96)*z(105) - z(99)*z(102);
z(157) = z(111)*z(155) - z(110)*z(156) - 0.5*z(108)*z(153);
z(164) = z(107)*z(156) + z(111)*z(163) + 0.5*z(108)*z(161);
z(166) = z(93)*z(159) - z(93)*z(154) - z(93)*z(162) - z(93)*z(165) - z(135)*z(157) - z(135)*z(164);
z(43) = z(38) - 0.5*l*z(32);
z(45) = z(43)*u;
z(87) = 0.5*z(74) + z(44)*z(65) + z(45)*z(64);
z(85) = 0.5*z(46)*z(65) - z(63) - z(45)*z(66);
z(72) = z(69) - 0.5*l*z(71);
z(73) = u*z(72);
z(86) = z(73) - z(44)*z(66) - 0.5*z(46)*z(64);
z(112) = m*(19.62*z(7)*z(28)+19.62*z(9)*z(26)+z(26)*(2*z(87)+z(42)*up)+2*z(1)*z(28)*(z(79)+z(39)*up)+2*z(3)*z(26)*(z(79)+z(39)*up)+2*z(5)*z(29)*(z(84)+z(40)*up)+2*z(28)*(z(85)-z(37)*up)-19.62*z(27)-19.62*z(8)*z(29)-2*z(29)*(z(86)+z(43)*up)-2*z(2)*z(29)*(z(79)+z(39)*up)-2*z(4)*z(28)*(z(84)+z(40)*up)-2*z(6)*z(26)*(z(84)+z(40)*up)-2*z(8)*z(27)*(z(86)+z(43)*up)-2*z(7)*z(27)*(z(85)-z(37)*up)-z(9)*z(27)*(2*z(87)+z(42)*up));
z(91) = 2*z(7)*z(27)*z(28) + 2*z(9)*z(26)*z(27) - z(26)^2 - z(27)^2 - z(28)^2 - z(29)^2 - 2*z(8)*z(27)*z(29);
z(186) = z(91) + z(92)^2;
z(187) = z(95)*z(104) - z(98)*z(101);
z(188) = z(107)*z(153) + z(111)*z(187) - z(110)*z(161);
z(189) = -z(91) - z(92)^2;
z(190) = z(107)*z(155) + z(110)*z(163) + 0.5*z(108)*z(187);
z(191) = z(186)*z(188) - z(189)*z(190);
z(113) = m*(z(7)*z(29)*(2*z(87)+z(42)*up)+z(8)*z(28)*(2*z(87)+z(42)*up)+2*z(3)*z(7)*z(29)*(z(79)+z(39)*up)+2*z(3)*z(8)*z(28)*(z(79)+z(39)*up)+2*z(4)*z(8)*z(26)*(z(84)+z(40)*up)+2*z(4)*z(9)*z(29)*(z(84)+z(40)*up)+2*(z(7)*z(26)-z(9)*z(28))*(z(86)+z(43)*up)+2*z(2)*(z(7)*z(26)-z(9)*z(28))*(z(79)+z(39)*up)-2*z(1)*z(8)*z(26)*(z(79)+z(39)*up)-2*z(1)*z(9)*z(29)*(z(79)+z(39)*up)-2*z(6)*z(7)*z(29)*(z(84)+z(40)*up)-2*z(6)*z(8)*z(28)*(z(84)+z(40)*up)-2*z(8)*z(26)*(z(85)-z(37)*up)-2*z(9)*z(29)*(z(85)-z(37)*up)-2*z(5)*(z(7)*z(26)-z(9)*z(28))*(z(84)+z(40)*up));
z(118) = z(91)*z(93);
z(122) = z(96) - z(99);
z(234) = -z(98)*z(111) - z(110)*z(122) - 0.5*z(98)*z(108);
z(237) = z(95)*z(111) + z(107)*z(122) + 0.5*z(95)*z(108);
z(119) = -z(97) - z(92)*z(96);
z(124) = z(92)*z(98);
z(235) = z(98)*z(109) + z(110)*z(119) - 0.5*z(108)*z(124);
z(126) = z(97) + z(92)*z(99);
z(233) = z(98)*z(109) + z(111)*z(124) - z(110)*z(126);
z(130) = z(92)*z(95);
z(236) = z(107)*z(126) - z(95)*z(109) - z(111)*z(130);
z(238) = z(95)*z(109) + z(107)*z(119) - 0.5*z(108)*z(130);
z(239) = z(118)*z(234) + z(118)*z(237) + z(135)*z(235) - z(135)*z(233) - z(135)*z(236) - z(135)*z(238);
z(116) = (TI11*u1*z(32)-TI33*u3*z(30))*u + TI22*(z(89)+z(31)*up);
z(199) = z(118)*z(157) + z(118)*z(164) + z(135)*z(159) - z(135)*z(154) - z(135)*z(162) - z(135)*z(165);
z(114) = m*(19.62+2*z(8)*(z(86)+z(43)*up)+z(9)*(2*z(87)+z(42)*up)+2*z(7)*(z(85)-z(37)*up));
z(207) = z(102) - 0.5*z(105);
z(208) = -z(104)*z(111) - z(110)*z(207) - 0.5*z(104)*z(108);
z(213) = z(101)*z(111) + z(107)*z(207) + 0.5*z(101)*z(108);
z(209) = -z(103) - z(92)*z(102);
z(204) = z(92)*z(104);
z(210) = z(104)*z(109) + z(110)*z(209) - 0.5*z(108)*z(204);
z(205) = z(103) + 0.5*z(92)*z(105);
z(206) = z(104)*z(109) + z(111)*z(204) - z(110)*z(205);
z(211) = z(92)*z(101);
z(212) = z(107)*z(205) - z(101)*z(109) - z(111)*z(211);
z(214) = z(101)*z(109) + z(107)*z(209) - 0.5*z(108)*z(211);
z(215) = z(118)*z(208) + z(118)*z(213) + z(135)*z(210) - z(135)*z(206) - z(135)*z(212) - z(135)*z(214);
z(115) = TI11*(z(88)+z(30)*up) - (TI22*u2*z(32)-TI33*u3*z(31))*u;
z(255) = z(98)*z(102) - z(104)*z(122) - 0.5*z(98)*z(105);
z(258) = z(101)*z(122) + 0.5*z(95)*z(105) - z(95)*z(102);
z(256) = z(98)*z(103) + z(102)*z(124) + z(104)*z(119);
z(254) = z(98)*z(103) + 0.5*z(105)*z(124) - z(104)*z(126);
z(257) = z(101)*z(126) - z(95)*z(103) - 0.5*z(105)*z(130);
z(259) = z(95)*z(103) + z(101)*z(119) + z(102)*z(130);
z(260) = z(118)*z(255) + z(118)*z(258) + z(135)*z(256) - z(135)*z(254) - z(135)*z(257) - z(135)*z(259);
z(117) = TI33*(z(90)+z(32)*up) - (TI11*u1*z(31)-TI22*u2*z(30))*u;
z(121) = z(103)*z(111) - 0.5*z(105)*z(109);
z(128) = z(102)*z(109) + 0.5*z(103)*z(108);
z(120) = z(104)*z(111) - 0.5*z(105)*z(110);
z(123) = z(103)*z(110) - z(104)*z(109);
z(125) = z(102)*z(111) + 0.25*z(105)*z(108);
z(127) = z(102)*z(110) + 0.5*z(104)*z(108);
z(129) = z(98)*z(121) + z(98)*z(128) + z(119)*z(120) + z(122)*z(123) + z(124)*z(125) - z(126)*z(127);
z(106) = 0.5*l*z(3)*z(4)*z(27) + 0.5*z(29)*(l-2*z(7)*z(15)) - z(8)*z(15)*z(28) - 0.5*l*z(1)*z(6)*z(27);
z(100) = 0.5*l*z(26) + z(9)*z(15)*z(28) + 0.5*z(2)*z(27)*(l*z(4)+2*z(6)*z(14)) - z(14)*z(28) - z(7)*z(15)*z(26) - 0.5*z(5)*z(27)*(l*z(1)+2*z(3)*z(14));
z(143) = -z(102)*z(106) - 0.5*z(100)*z(108);
z(94) = z(8)*z(15)*z(26) + z(1)*z(6)*z(14)*z(27) - z(3)*z(4)*z(14)*z(27) - z(29)*(z(14)-z(9)*z(15));
z(142) = z(94) + z(92)*z(96);
z(137) = z(94) + z(92)*z(99);
z(138) = z(100)*z(111) - 0.5*z(105)*z(106);
z(139) = z(100)*z(110) - z(104)*z(106);
z(144) = z(98)*z(143) + z(120)*z(142) + z(127)*z(137) - z(98)*z(138) - z(122)*z(139) - z(124)*z(125);
z(146) = z(100)*z(107) - z(101)*z(106);
z(133) = -z(102)*z(107) - 0.5*z(101)*z(108);
z(131) = z(101)*z(111) - 0.5*z(105)*z(107);
z(148) = z(95)*z(138) + z(122)*z(146) + z(125)*z(130) + z(133)*z(137) - z(95)*z(143) - z(131)*z(142);
z(140) = z(100)*z(109) - z(103)*z(106);
z(136) = z(92)*(z(94)-z(97));
z(145) = z(98)*z(140) + z(119)*z(139) + z(123)*z(142) + z(124)*z(128) + z(124)*z(143) + z(127)*z(136);
z(132) = z(101)*z(109) - z(103)*z(107);
z(134) = z(95)*z(121) + z(95)*z(128) + z(119)*z(131) + z(125)*z(130) + z(126)*z(133) - z(122)*z(132);
z(141) = z(98)*z(140) + z(123)*z(137) + z(124)*z(138) - z(120)*z(136) - z(121)*z(124) - z(126)*z(139);
z(147) = z(121)*z(130) + z(126)*z(146) + z(131)*z(136) + z(132)*z(137) - z(95)*z(140) - z(130)*z(138);
z(149) = z(95)*z(140) + z(119)*z(146) + z(128)*z(130) + z(130)*z(143) - z(132)*z(142) - z(133)*z(136);
z(150) = z(118)*z(129) + z(118)*z(144) + z(118)*z(148) + z(135)*z(145) - z(118)*z(134) - z(135)*z(141) - z(135)*z(147) - z(135)*z(149);
z(275) = (z(166)*z(112)+z(191)*z(113)+z(239)*z(116)-z(199)*z(114)-z(215)*z(115)-z(260)*z(117))/z(150);
aforce1 = z(275);
z(168) = z(94)*z(103) - z(97)*z(100);
z(169) = 0.5*z(94)*z(105) - z(99)*z(100);
z(170) = z(106)*z(152) + z(111)*z(168) - z(109)*z(169);
z(171) = z(94)*z(102) - z(96)*z(100);
z(173) = z(106)*z(158) + z(109)*z(171) + 0.5*z(108)*z(168);
z(167) = z(111)*z(158) - z(109)*z(156) - 0.5*z(108)*z(152);
z(172) = z(106)*z(156) + z(111)*z(171) + 0.5*z(108)*z(169);
z(174) = -z(93)*z(170) - z(93)*z(173) - z(135)*z(167) - z(135)*z(172);
z(175) = z(94)*z(104) - z(98)*z(100);
z(176) = z(106)*z(153) + z(111)*z(175) - z(110)*z(169);
z(182) = z(106)*z(155) + z(110)*z(171) + 0.5*z(108)*z(175);
z(192) = z(154)*z(189) + z(176)*z(186) - z(159)*z(189) - z(182)*z(189);
z(240) = z(111)*z(119) - z(109)*z(122) - 0.5*z(108)*z(126);
z(242) = z(106)*z(122) + z(111)*z(142) + 0.5*z(108)*z(137);
z(241) = z(106)*z(126) - z(109)*z(137) - z(111)*z(136);
z(243) = z(106)*z(119) + z(109)*z(142) - 0.5*z(108)*z(136);
z(244) = z(118)*z(240) + z(118)*z(242) - z(135)*z(241) - z(135)*z(243);
z(200) = z(118)*z(167) + z(118)*z(172) - z(135)*z(170) - z(135)*z(173);
z(216) = z(111)*z(209) - z(109)*z(207) - 0.5*z(108)*z(205);
z(220) = z(100) + z(92)*z(102);
z(218) = z(100) + 0.5*z(92)*z(105);
z(221) = z(106)*z(207) + z(111)*z(220) + 0.5*z(108)*z(218);
z(217) = z(92)*(z(100)-z(103));
z(219) = z(106)*z(205) - z(109)*z(218) - z(111)*z(217);
z(222) = z(106)*z(209) + z(109)*z(220) - 0.5*z(108)*z(217);
z(223) = z(118)*z(216) + z(118)*z(221) - z(135)*z(219) - z(135)*z(222);
z(261) = z(102)*z(126) + 0.5*z(105)*z(119) - z(103)*z(122);
z(263) = z(100)*z(122) + 0.5*z(105)*z(142) - z(102)*z(137);
z(262) = z(100)*z(126) - z(103)*z(137) - 0.5*z(105)*z(136);
z(264) = z(100)*z(119) + z(102)*z(136) + z(103)*z(142);
z(265) = z(118)*z(261) + z(118)*z(263) - z(135)*z(262) - z(135)*z(264);
z(276) = (z(174)*z(112)+z(192)*z(113)+z(244)*z(116)-z(200)*z(114)-z(223)*z(115)-z(265)*z(117))/z(150);
aforce2 = -z(276);
z(177) = z(106)*z(151) + z(110)*z(168) - z(109)*z(175);
z(178) = z(94)*z(101) - z(95)*z(100);
z(180) = z(106)*z(160) + z(109)*z(178) - z(107)*z(168);
z(179) = z(106)*z(161) + z(111)*z(178) - z(107)*z(169);
z(181) = z(135)*z(176) - z(93)*z(177) - z(93)*z(180) - z(135)*z(154) - z(135)*z(162) - z(135)*z(179);
z(247) = z(95)*z(106) + z(111)*z(130) - z(107)*z(137);
z(245) = z(98)*z(106) + z(111)*z(124) - z(110)*z(137);
z(246) = z(106)*z(124) - z(109)*z(124) - z(110)*z(136);
z(248) = z(107)*z(136) + z(109)*z(130) - z(106)*z(130);
z(249) = z(118)*z(233) + z(118)*z(236) + z(118)*z(247) - z(118)*z(245) - z(135)*z(246) - z(135)*z(248);
z(193) = z(107)*z(151) + z(110)*z(160) - z(109)*z(187);
z(194) = z(106)*z(187) + z(110)*z(178) - z(107)*z(175);
z(195) = z(189)*(z(193)+z(194));
z(201) = z(118)*z(154) + z(118)*z(162) + z(118)*z(179) - z(118)*z(176) - z(135)*z(177) - z(135)*z(180);
z(226) = z(101)*z(106) + z(111)*z(211) - z(107)*z(218);
z(224) = z(104)*z(106) + z(111)*z(204) - z(110)*z(218);
z(225) = z(106)*z(204) - z(109)*z(204) - z(110)*z(217);
z(227) = z(107)*z(217) + z(109)*z(211) - z(106)*z(211);
z(228) = z(118)*z(206) + z(118)*z(212) + z(118)*z(226) - z(118)*z(224) - z(135)*z(225) - z(135)*z(227);
z(268) = z(95)*z(100) + 0.5*z(105)*z(130) - z(101)*z(137);
z(266) = z(98)*z(100) + 0.5*z(105)*z(124) - z(104)*z(137);
z(267) = z(100)*z(124) - z(103)*z(124) - z(104)*z(136);
z(269) = z(101)*z(136) + z(103)*z(130) - z(100)*z(130);
z(270) = z(118)*z(254) + z(118)*z(257) + z(118)*z(268) - z(118)*z(266) - z(135)*z(267) - z(135)*z(269);
z(277) = (z(181)*z(112)+z(249)*z(116)-z(195)*z(113)-z(201)*z(114)-z(228)*z(115)-z(270)*z(117))/z(150);
aforce3 = z(277);
z(183) = z(106)*z(163) - z(107)*z(171) - 0.5*z(108)*z(178);
z(184) = z(93)*z(179) - z(93)*z(176) - z(93)*z(182) - z(93)*z(183) - z(135)*z(157) - z(135)*z(164);
z(250) = z(110)*z(142) + 0.5*z(108)*z(124) - z(98)*z(106);
z(251) = z(95)*z(106) - z(107)*z(142) - 0.5*z(108)*z(130);
z(252) = z(118)*z(234) + z(118)*z(237) + z(135)*z(247) - z(135)*z(245) - z(135)*z(250) - z(135)*z(251);
z(196) = z(189)*(z(188)+z(190));
z(202) = z(118)*z(157) + z(118)*z(164) + z(135)*z(179) - z(135)*z(176) - z(135)*z(182) - z(135)*z(183);
z(229) = z(110)*z(220) + 0.5*z(108)*z(204) - z(104)*z(106);
z(230) = z(101)*z(106) - z(107)*z(220) - 0.5*z(108)*z(211);
z(231) = z(118)*z(208) + z(118)*z(213) + z(135)*z(226) - z(135)*z(224) - z(135)*z(229) - z(135)*z(230);
z(271) = z(104)*z(142) - z(98)*z(100) - z(102)*z(124);
z(272) = z(95)*z(100) + z(102)*z(130) - z(101)*z(142);
z(273) = z(118)*z(255) + z(118)*z(258) + z(135)*z(268) - z(135)*z(266) - z(135)*z(271) - z(135)*z(272);
z(278) = (z(184)*z(112)+z(252)*z(116)-z(196)*z(113)-z(202)*z(114)-z(231)*z(115)-z(273)*z(117))/z(150);
bforce1 = -z(278);
z(197) = z(179)*z(186) + z(183)*z(189) - z(162)*z(189) - z(165)*z(189);
z(279) = (z(174)*z(112)+z(197)*z(113)+z(244)*z(116)-z(200)*z(114)-z(223)*z(115)-z(265)*z(117))/z(150);
bforce2 = z(279);
z(185) = z(135)*z(165) - z(93)*z(177) - z(93)*z(180) - z(135)*z(159) - z(135)*z(182) - z(135)*z(183);
z(198) = z(186)*z(194) - z(189)*z(193);
z(253) = z(118)*z(235) + z(118)*z(250) + z(118)*z(251) - z(118)*z(238) - z(135)*z(246) - z(135)*z(248);
z(203) = z(118)*z(159) + z(118)*z(182) + z(118)*z(183) - z(118)*z(165) - z(135)*z(177) - z(135)*z(180);
z(232) = z(118)*z(210) + z(118)*z(229) + z(118)*z(230) - z(118)*z(214) - z(135)*z(225) - z(135)*z(227);
z(274) = z(118)*z(256) + z(118)*z(271) + z(118)*z(272) - z(118)*z(259) - z(135)*z(267) - z(135)*z(269);
z(280) = (z(185)*z(112)+z(198)*z(113)+z(253)*z(116)-z(203)*z(114)-z(232)*z(115)-z(274)*z(117))/z(150);
bforce3 = -z(280);

Output(1)=T;  Output(2)=ke;  Output(3)=pe;  Output(4)=ke+pe;  Output(5)=e1;  Output(6)=e2;  Output(7)=e3;  Output(8)=e4;  Output(9)=u;  Output(10)=cahat1;  Output(11)=cahat2;  Output(12)=cahat3;  Output(13)=cbhat1;  Output(14)=cbhat2;  Output(15)=cbhat3;  Output(16)=u1;  Output(17)=u2;  Output(18)=u3;  Output(19)=u4;  Output(20)=u5;  Output(21)=u6;  Output(22)=q1;  Output(23)=q2;  Output(24)=q3;  Output(25)=aforce1;  Output(26)=aforce2;  Output(27)=aforce3;  Output(28)=bforce1;  Output(29)=bforce2;  Output(30)=bforce3;  Output(31)=(-(z(87)+0.5*z(42)*up)*z(26)-(z(79)+z(39)*up)*z(26)*z(3)-(-z(84)-z(40)*up)*z(26)*z(6)+(z(85)-z(37)*up)*z(27)*z(7)+(z(86)+z(43)*up)*z(27)*z(8)+(z(87)+0.5*z(42)*up)*z(27)*z(9)-(z(85)-z(37)*up)*z(28)-(z(79)+z(39)*up)*z(28)*z(1)-(-z(84)-z(40)*up)*z(28)*z(4)+(z(86)+z(43)*up)*z(29)+1.0*(z(79)+z(39)*up)*z(29)*z(2)+1.0*(-z(84)-z(40)*up)*z(29)*z(5));
FileIdentifier = fopen('all');
WriteOutput( 1,                 Output(1:31) );
WriteOutput( FileIdentifier(1), Output(1:31) );



%===========================================================================
function WriteOutput( fileIdentifier, Output )
numberOfOutputQuantities = length( Output );
if numberOfOutputQuantities > 0,
  for i=1:numberOfOutputQuantities,
    fprintf( fileIdentifier, ' %- 23.15E', Output(i) );
  end
  fprintf( fileIdentifier, '\n' );
end



%===========================================================================
% mdlTerminate: Perform end of simulation tasks and set sys=[]
%===========================================================================
function sys = mdlTerminate(T,VAR,u)
FileIdentifier = fopen('all');
fclose( FileIdentifier(1) );
fprintf( 1, '\n Output is in the file TwinDisksConstraintForcesExtra.1\n' );
fprintf( 1, '\n To load and plot columns 1 and 2 with a solid line and columns 1 and 3 with a dashed line, enter:\n' );
fprintf( 1, '    someName = load( ''TwinDisksConstraintForcesExtra.1'' );\n' );
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
sizes.NumContStates  = 20;    % sys(1) is the number of continuous states
sizes.NumDiscStates  = 0;     % sys(2) is the number of discrete states
sizes.NumOutputs     = 31;    % sys(3) is the number of outputs
sizes.NumInputs      = 0;     % sys(4) is the number of inputs
sizes.DirFeedthrough = 1;     % sys(6) is 1, and allows for the output to be a function of the input
sizes.NumSampleTimes = 1;     % sys(7) is the number of samples times (the number of rows in ts)
sys = simsizes(sizes);        % Convert it to a sizes array
stateOrderingStrings = [];
timeSampling         = [0 0]; % m-by-2 matrix containing the sample times
OpenOutputFilesAndWriteHeadings
VAR = ReadUserInput
