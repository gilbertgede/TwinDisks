function TwinDisks
SolveOrdinaryDifferentialEquations
% File  TwinDisks.m  created by Autolev 4.1 on Wed Sep 01 23:10:09 2010


%===========================================================================
function VAR = ReadUserInput
global   a1 a2 a3 ida11 ida22 ida33 idb11 idb22 idb33 l1 l2 l3 mda mdb rada radb;
global   cahat1 cahat2 cahat3 cbhat1 cbhat2 cbhat3 e1 e2 e3 e4 posa1 posa2 posa3 posb1 posb2 posb3 u1;
global   ke pe u2 u3 cahat1p cahat2p cahat3p cbhat1p cbhat2p cbhat3p e1p e2p e3p e4p posa1p posa2p posa3p posb1p posb2p posb3p u1p;
global   DEGtoRAD RADtoDEG z t_da t_db Encode;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

%-------------------------------+--------------------------+-------------------+-----------------
% Quantity                      | Value                    | Units             | Description
%-------------------------------|--------------------------|-------------------|-----------------
a1                              =  1.570796326794897;      % UNITS               Constant
a2                              =  0;                      % UNITS               Constant
a3                              =  0;                      % UNITS               Constant
ida11                           =  .005;                   % UNITS               Constant
ida22                           =  .005;                   % UNITS               Constant
ida33                           =  .01;                    % UNITS               Constant
idb11                           =  .005;                   % UNITS               Constant
idb22                           =  .005;                   % UNITS               Constant
idb33                           =  .01;                    % UNITS               Constant
l1                              = -.1;                     % UNITS               Constant
l2                              =  0;                      % UNITS               Constant
l3                              =  0;                      % UNITS               Constant
mda                             =  2;                      % UNITS               Constant
mdb                             =  2;                      % UNITS               Constant
rada                            =  .1;                     % UNITS               Constant
radb                            =  .1;                     % UNITS               Constant

cahat1                          =  0;                      % UNITS               Initial Value
cahat2                          =  0;                      % UNITS               Initial Value
cahat3                          =  0;                      % UNITS               Initial Value
cbhat1                          = -0.1;                    % UNITS               Initial Value
cbhat2                          =  0.1414213562373095;     % UNITS               Initial Value
cbhat3                          =  0;                      % UNITS               Initial Value
e1                              =  0.3826834323650898;     % UNITS               Initial Value
e2                              =  0;                      % UNITS               Initial Value
e3                              =  0;                      % UNITS               Initial Value
e4                              =  0.9238795325112867;     % UNITS               Initial Value
posa1                           =  0;                      % UNITS               Initial Value
posa2                           =  0.07071067811865475;    % UNITS               Initial Value
posa3                           =  0.07071067811865477;    % UNITS               Initial Value
posb1                           = -0.1;                    % UNITS               Initial Value
posb2                           =  0;                      % UNITS               Initial Value
posb3                           =  0;                      % UNITS               Initial Value
u1                              =  2;                      % UNITS               Initial Value

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
z = zeros(239,1);

% Evaluate constants
cahat3p = 0;
cbhat3p = 0;
z(10) = cos(a2);
z(11) = cos(a3);
z(12) = z(10)*z(11);
z(13) = sin(a3);
z(14) = z(10)*z(13);
z(15) = sin(a2);
z(16) = cos(a1);
z(17) = sin(a1);
z(18) = z(13)*z(16) + z(11)*z(15)*z(17);
z(19) = z(11)*z(16) - z(13)*z(15)*z(17);
z(20) = z(10)*z(17);
z(21) = z(13)*z(17) - z(11)*z(15)*z(16);
z(22) = z(11)*z(17) + z(13)*z(15)*z(16);
z(23) = z(10)*z(16);
z(66) = l1^2 + l2^2;
z(67) = l1*z(15);
z(68) = l2*z(20);
z(97) = radb*z(67);
z(98) = radb*z(23);
z(99) = radb*z(68);
z(100) = rada*z(23);
z(115) = radb*z(22);
z(118) = radb*z(21);
z(127) = radb*z(14);
z(129) = radb*z(12);
z(136) = radb*z(19);
z(138) = radb*z(18);
z(171) = idb11*z(12);
z(172) = idb11*z(18);
z(173) = idb11*z(21);
z(174) = idb22*z(19);
z(175) = idb22*z(22);
z(176) = idb22*z(14);
z(177) = idb33*z(15);
z(178) = idb33*z(23);
z(179) = idb33*z(20);
z(200) = ida11 + z(12)*z(171) + z(14)*z(176) + z(15)*z(177);
z(201) = l2^2;
z(203) = z(12)*z(172);
z(204) = z(14)*z(174);
z(205) = z(15)*z(179);
z(206) = l1*l2;
z(208) = z(12)*z(173) + z(15)*z(178);
z(209) = z(14)*z(175);
z(212) = ida22 + z(18)*z(172) + z(19)*z(174) + z(20)*z(179);
z(213) = l1^2;
z(215) = z(18)*z(171);
z(216) = z(19)*z(176);
z(217) = z(20)*z(177);
z(219) = z(18)*z(173) + z(19)*z(175);
z(220) = z(20)*z(178);
z(223) = ida33 + z(21)*z(173) + z(22)*z(175) + z(23)*z(178);
z(225) = z(21)*z(171) + z(23)*z(177);
z(226) = z(22)*z(176);
z(228) = z(21)*z(172) + z(22)*z(174);
z(229) = z(23)*z(179);

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
VAR(17) = u1;



%===========================================================================
function OpenOutputFilesAndWriteHeadings
FileIdentifier = fopen('TwinDisks.1', 'wt');   if( FileIdentifier == -1 ) error('Error: unable to open file TwinDisks.1'); end
fprintf( 1,             '%%     ke+pe     dot(v_bhat_n>, dot(v_bhat_n>,       e1             e2             e3             e4             u1           cahat1         cahat2         cahat3         cbhat1         cbhat2         cbhat3\n' );
fprintf( 1,             '%%    (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)\n\n' );
fprintf(FileIdentifier, '%% FILE: TwinDisks.1\n%%\n' );
fprintf(FileIdentifier, '%%     ke+pe     dot(v_bhat_n>, dot(v_bhat_n>,       e1             e2             e3             e4             u1           cahat1         cahat2         cahat3         cbhat1         cbhat2         cbhat3\n' );
fprintf(FileIdentifier, '%%    (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)        (UNITS)\n\n' );



%===========================================================================
% Main driver loop for numerical integration of differential equations
%===========================================================================
function SolveOrdinaryDifferentialEquations
global   a1 a2 a3 ida11 ida22 ida33 idb11 idb22 idb33 l1 l2 l3 mda mdb rada radb;
global   cahat1 cahat2 cahat3 cbhat1 cbhat2 cbhat3 e1 e2 e3 e4 posa1 posa2 posa3 posb1 posb2 posb3 u1;
global   ke pe u2 u3 cahat1p cahat2p cahat3p cbhat1p cbhat2p cbhat3p e1p e2p e3p e4p posa1p posa2p posa3p posb1p posb2p posb3p u1p;
global   DEGtoRAD RADtoDEG z t_da t_db Encode;
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
global   a1 a2 a3 ida11 ida22 ida33 idb11 idb22 idb33 l1 l2 l3 mda mdb rada radb;
global   cahat1 cahat2 cahat3 cbhat1 cbhat2 cbhat3 e1 e2 e3 e4 posa1 posa2 posa3 posb1 posb2 posb3 u1;
global   ke pe u2 u3 cahat1p cahat2p cahat3p cbhat1p cbhat2p cbhat3p e1p e2p e3p e4p posa1p posa2p posa3p posb1p posb2p posb3p u1p;
global   DEGtoRAD RADtoDEG z t_da t_db Encode;
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
u1 = VAR(17);
z(2) = 2*e1*e2 - 2*e3*e4;
z(4) = 2*e1*e2 + 2*e3*e4;
z(7) = 2*e1*e3 - 2*e2*e4;
z(9) = 1 - 2*e1^2 - 2*e2^2;
z(8) = 2*e1*e4 + 2*e2*e3;
z(38) = z(15)*z(7) + z(23)*z(9) - z(20)*z(8);
z(39) = 1 - z(38)^2;
z(40) = z(39)^0.5;
z(41) = z(38)/z(40);
z(43) = radb*z(41);
z(24) = 1 - z(9)^2;
z(25) = z(24)^0.5;
z(26) = z(9)/z(25);
z(28) = rada*z(26);
z(51) = l3 - z(28);
z(27) = 1/z(25);
z(29) = rada*z(27);
z(42) = 1/z(40);
z(44) = radb*z(42);
z(65) = z(29) - z(44);
z(69) = z(66) + z(43)^2 + z(51)^2 + z(65)^2 + 2*z(67)*z(43) + 2*l1*z(7)*z(65) + 2*l2*z(8)*z(65) + 2*z(23)*z(43)*z(51) + 2*z(9)*z(51)*z(65) + 2*z(38)*z(43)*z(65) - 2*z(68)*z(43);
z(70) = z(69)^0.5;
z(73) = l1/z(70);
z(6) = 2*e2*e3 - 2*e1*e4;
z(71) = z(51)/z(70);
z(5) = 1 - 2*e1^2 - 2*e3^2;
z(37) = z(15)*z(4) + z(23)*z(6) - z(20)*z(5);
z(75) = z(43)/z(70);
z(74) = l2/z(70);
z(3) = 2*e1*e3 + 2*e2*e4;
z(1) = 1 - 2*e2^2 - 2*e3^2;
z(36) = z(15)*z(1) + z(23)*z(3) - z(20)*z(2);
z(47) = z(6)*z(29);
z(61) = z(47) - z(6)*z(44);
z(30) = z(12)*z(1) + z(18)*z(2) + z(21)*z(3);
z(55) = z(22)*z(43);
z(34) = z(19)*z(5) + z(22)*z(6) - z(14)*z(4);
z(58) = z(21)*z(43);
z(50) = z(3)*z(29);
z(64) = z(3)*z(44) - z(50);
z(31) = z(12)*z(4) + z(18)*z(5) + z(21)*z(6);
z(33) = z(19)*z(2) + z(22)*z(3) - z(14)*z(1);
z(76) = l1*z(2)*(z(4)*z(73)+z(6)*z(71)+z(37)*z(75)) + l2*z(4)*(z(2)*z(74)+z(3)*z(71)+z(36)*z(75)) + z(61)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75)) + z(30)*z(55)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75)) + z(34)*z(58)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75)) - l1*z(5)*(z(1)*z(73)+z(3)*z(71)+z(36)*z(75)) - l2*z(1)*(z(5)*z(74)+z(6)*z(71)+z(37)*z(75)) - z(64)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75)) - z(31)*z(55)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75)) - z(33)*z(58)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75));
z(52) = z(28) - l3;
z(32) = z(12)*z(7) + z(18)*z(8) + z(21)*z(9);
z(53) = z(14)*z(43);
z(35) = z(19)*z(8) + z(22)*z(9) - z(14)*z(7);
z(56) = z(12)*z(43);
z(80) = l2*z(9) + z(8)*z(52) - z(32)*z(53) - z(35)*z(56);
z(45) = z(4)*z(29);
z(59) = z(45) - z(4)*z(44);
z(48) = z(1)*z(29);
z(62) = z(1)*z(44) - z(48);
z(77) = l2*z(3)*(z(4)*z(73)+z(5)*z(74)+z(37)*z(75)) + z(2)*z(52)*(z(4)*z(73)+z(6)*z(71)+z(37)*z(75)) + z(59)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75)) + z(31)*z(53)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75)) + z(34)*z(56)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75)) - l2*z(6)*(z(1)*z(73)+z(2)*z(74)+z(36)*z(75)) - z(5)*z(52)*(z(1)*z(73)+z(3)*z(71)+z(36)*z(75)) - z(62)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75)) - z(30)*z(53)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75)) - z(33)*z(56)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75));
z(79) = l1*z(8) + z(32)*z(55) - l2*z(7) - z(35)*z(58);
z(46) = z(5)*z(29);
z(60) = z(46) - z(5)*z(44);
z(54) = z(19)*z(43);
z(57) = z(18)*z(43);
z(49) = z(2)*z(29);
z(63) = z(2)*z(44) - z(49);
z(78) = l1*z(6)*(z(1)*z(73)+z(2)*z(74)+z(36)*z(75)) + z(1)*z(51)*(z(5)*z(74)+z(6)*z(71)+z(37)*z(75)) + z(60)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75)) + z(30)*z(54)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75)) + z(34)*z(57)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75)) - l1*z(3)*(z(4)*z(73)+z(5)*z(74)+z(37)*z(75)) - z(4)*z(51)*(z(2)*z(74)+z(3)*z(71)+z(36)*z(75)) - z(63)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75)) - z(31)*z(54)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75)) - z(33)*z(57)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75));
z(81) = z(7)*z(51) + z(32)*z(54) - l1*z(9) - z(35)*z(57);
z(82) = z(78)*z(79) - z(76)*z(81);
z(83) = (z(76)*z(80)-z(77)*z(79))/z(82);
u2 = z(83)*u1;
z(84) = (z(77)*z(81)-z(78)*z(80))/z(82);
u3 = z(84)*u1;
z(161) = ida33*u3;
z(160) = ida22*u2;
z(164) = u2*z(161) - u3*z(160);
z(166) = z(19)*u2 + z(22)*u3 - z(14)*u1;
z(167) = z(15)*u1 + z(23)*u3 - z(20)*u2;
z(170) = idb33*z(167);
z(169) = idb22*z(166);
z(182) = z(166)*z(170) - z(167)*z(169);
z(165) = z(12)*u1 + z(18)*u2 + z(21)*u3;
z(168) = idb11*z(165);
z(180) = z(165)*z(169) - z(166)*z(168);
z(184) = z(28)*u1;
z(183) = z(28)*u2;
z(192) = u1*z(184) + u2*z(183);
e1p = 0.5*e2*u3 + 0.5*e4*u1 - 0.5*e3*u2;
e2p = 0.5*e3*u1 + 0.5*e4*u2 - 0.5*e1*u3;
z(88) = -4*e1*e1p - 4*e2*e2p;
z(93) = z(9)*z(88)/z(24)^0.5;
z(94) = (z(9)*z(93)+z(25)*z(88))/z(25)^2;
z(188) = rada*u1*z(94);
z(193) = z(188) - u3*z(183);
z(95) = rada*z(93)/z(25)^2;
e4p = -0.5*e1*u1 - 0.5*e2*u2 - 0.5*e3*u3;
e3p = 0.5*e1*u2 + 0.5*e4*u3 - 0.5*e2*u1;
z(86) = 2*e1*e2p + 2*e2*e1p + 2*e3*e4p + 2*e4*e3p;
z(125) = z(4)*z(95) + z(29)*z(86);
z(105) = -4*e1*e1p - 4*e3*e3p;
z(134) = z(5)*z(95) + z(29)*z(105);
z(103) = 2*e2*e3p + 2*e3*e2p - 2*e1*e4p - 2*e4*e1p;
z(112) = z(6)*z(95) + z(29)*z(103);
z(189) = u1*z(125) + u2*z(134) + u3*z(112);
z(187) = rada*u2*z(94);
z(191) = -u3*z(184) - z(187);
z(110) = -4*e2*e2p - 4*e3*e3p;
z(131) = z(1)*z(95) + z(29)*z(110);
z(85) = 2*e1*e2p + 2*e2*e1p - 2*e3*e4p - 2*e4*e3p;
z(140) = z(2)*z(95) + z(29)*z(85);
z(109) = 2*e1*e3p + 2*e2*e4p + 2*e3*e1p + 2*e4*e2p;
z(120) = z(3)*z(95) + z(29)*z(109);
z(190) = -u1*z(131) - u2*z(140) - u3*z(120);
z(181) = z(167)*z(168) - z(165)*z(170);
z(195) = l1*u3 + z(52)*u1;
z(194) = z(51)*u2 - l2*u3;
z(198) = u1*z(195) - u2*z(194);
z(196) = l2*u1 - l1*u2;
z(197) = u2*z(196) - u3*z(195) - z(187);
z(199) = u3*z(194) + z(188) - u1*z(196);
z(211) = z(164) + z(12)*z(182) + z(15)*z(180) + mda*(z(3)*z(45)*z(192)+z(28)*z(193)+z(45)*z(189)+z(1)*z(45)*z(191)+z(2)*z(28)*z(189)+z(2)*z(45)*z(193)+z(5)*z(28)*z(190)-z(6)*z(48)*z(192)-z(48)*z(190)-z(4)*z(48)*z(191)-z(5)*z(48)*z(193)) - z(14)*z(181) - mdb*(z(6)*z(48)*z(198)+z(48)*z(190)+z(4)*z(48)*z(197)+z(5)*z(48)*z(199)-l2*z(198)-z(3)*z(45)*z(198)-z(45)*z(189)-z(52)*z(199)-l2*z(3)*z(189)-l2*z(6)*z(190)-z(1)*z(45)*z(197)-z(2)*z(45)*z(199)-z(2)*z(52)*z(189)-z(5)*z(52)*z(190));
z(159) = ida11*u1;
z(163) = u3*z(159) - u1*z(161);
z(222) = z(163) + z(18)*z(182) + z(19)*z(181) + mda*(z(3)*z(46)*z(192)+z(46)*z(189)+z(1)*z(46)*z(191)+z(2)*z(46)*z(193)-z(6)*z(49)*z(192)-z(28)*z(191)-z(49)*z(190)-z(1)*z(28)*z(189)-z(4)*z(28)*z(190)-z(4)*z(49)*z(191)-z(5)*z(49)*z(193)) + mdb*(z(3)*z(46)*z(198)+z(46)*z(189)+z(51)*z(197)+z(1)*z(46)*z(197)+z(1)*z(51)*z(189)+z(2)*z(46)*z(199)+z(4)*z(51)*z(190)-l1*z(198)-z(6)*z(49)*z(198)-z(49)*z(190)-l1*z(3)*z(189)-l1*z(6)*z(190)-z(4)*z(49)*z(197)-z(5)*z(49)*z(199)) - z(20)*z(180);
z(162) = u1*z(160) - u2*z(159);
z(231) = z(162) + z(21)*z(182) + z(22)*z(181) + z(23)*z(180) + mda*(z(3)*z(47)*z(192)+z(47)*z(189)+z(1)*z(47)*z(191)+z(2)*z(47)*z(193)-z(6)*z(50)*z(192)-z(50)*z(190)-z(4)*z(50)*z(191)-z(5)*z(50)*z(193)) + mdb*(z(3)*z(47)*z(198)+l1*z(199)+z(47)*z(189)+l1*z(2)*z(189)+l1*z(5)*z(190)+z(1)*z(47)*z(197)+z(2)*z(47)*z(199)-z(6)*z(50)*z(198)-l2*z(197)-z(50)*z(190)-l2*z(1)*z(189)-l2*z(4)*z(190)-z(4)*z(50)*z(197)-z(5)*z(50)*z(199));
z(235) = z(211) + z(83)*z(222) + z(84)*z(231);
z(207) = z(203) + mda*(z(45)*z(46)+z(48)*z(49)+z(2)*z(28)*z(46)+z(4)*z(28)*z(48)-z(1)*z(28)*z(45)-z(5)*z(28)*z(49)) + mdb*(z(45)*z(46)+z(48)*z(49)+l1*z(6)*z(48)+l2*z(3)*z(46)+z(1)*z(45)*z(51)+z(2)*z(46)*z(52)-z(206)-l1*z(3)*z(45)-l2*z(6)*z(49)-z(4)*z(48)*z(51)-z(5)*z(49)*z(52)) - z(204) - z(205);
z(214) = z(212) + mdb*(z(213)+z(46)^2+z(49)^2+z(51)^2+2*l1*z(6)*z(49)+2*z(1)*z(46)*z(51)-2*l1*z(3)*z(46)-2*z(4)*z(49)*z(51)) - mda*(2*z(1)*z(28)*z(46)-z(28)^2-z(46)^2-z(49)^2-2*z(4)*z(28)*z(49));
z(230) = z(228) + mdb*(z(46)*z(47)+z(49)*z(50)+l1*z(2)*z(46)+l1*z(6)*z(50)+l2*z(4)*z(49)+z(1)*z(47)*z(51)-l2*z(51)-l1*z(3)*z(47)-l1*z(5)*z(49)-l2*z(1)*z(46)-z(4)*z(50)*z(51)) - z(229) - mda*(z(1)*z(28)*z(47)-z(46)*z(47)-z(49)*z(50)-z(4)*z(28)*z(50));
z(233) = z(207) + z(83)*z(214) + z(84)*z(230);
z(89) = 2*e1*e4p + 2*e2*e3p + 2*e3*e2p + 2*e4*e1p;
z(87) = 2*e1*e3p + 2*e3*e1p - 2*e2*e4p - 2*e4*e2p;
z(90) = z(15)*z(87) + z(23)*z(88) - z(20)*z(89);
z(91) = z(38)*z(90)/z(39)^0.5;
z(92) = (z(38)*z(91)+z(40)*z(90))/z(40)^2;
z(128) = z(127)*z(92);
z(130) = z(129)*z(92);
z(144) = z(12)*z(87) + z(18)*z(89) + z(21)*z(88);
z(145) = z(19)*z(89) + z(22)*z(88) - z(14)*z(87);
z(147) = l2*z(88) + z(52)*z(89) + rada*z(8)*z(94) - z(32)*z(128) - z(35)*z(130) - z(53)*z(144) - z(56)*z(145);
z(137) = z(136)*z(92);
z(139) = z(138)*z(92);
z(148) = z(32)*z(137) + z(51)*z(87) + z(54)*z(144) - l1*z(88) - z(35)*z(139) - z(57)*z(145) - rada*z(7)*z(94);
z(116) = z(115)*z(92);
z(119) = z(118)*z(92);
z(146) = l1*z(89) + z(32)*z(116) + z(55)*z(144) - l2*z(87) - z(35)*z(119) - z(58)*z(145);
z(149) = u1*z(147) + u2*z(148) + u3*z(146);
z(96) = radb*z(91)/z(40)^2;
z(126) = z(125) - z(4)*z(96) - z(44)*z(86);
z(122) = z(12)*z(86) + z(18)*z(105) + z(21)*z(103);
z(117) = z(19)*z(105) + z(22)*z(103) - z(14)*z(86);
z(101) = 2*z(97)*z(92) + 2*l1*z(65)*z(87) + 2*l2*z(65)*z(89) + 2*radb*z(43)*z(92) + 2*z(98)*z(51)*z(92) + 2*z(43)*z(65)*z(90) + 2*z(51)*z(65)*z(88) + 2*radb*z(38)*z(65)*z(92) + 2*z(65)*(z(95)-z(96)) + 2*l1*z(7)*(z(95)-z(96)) + 2*l2*z(8)*(z(95)-z(96)) + 2*z(9)*z(51)*(z(95)-z(96)) + 2*z(38)*z(43)*(z(95)-z(96)) - 2*z(99)*z(92) - 2*rada*z(51)*z(94) - 2*z(100)*z(43)*z(94) - 2*rada*z(9)*z(65)*z(94);
z(102) = l1*z(101)/(z(69)^0.5*z(70)^2);
z(108) = l2*z(101)/(z(69)^0.5*z(70)^2);
z(111) = z(15)*z(110) + z(23)*z(109) - z(20)*z(85);
z(107) = (2*radb*z(70)*z(92)-z(43)*z(101)/z(69)^0.5)/z(70)^2;
z(104) = (2*rada*z(70)*z(94)+z(51)*z(101)/z(69)^0.5)/z(70)^2;
z(106) = z(15)*z(86) + z(23)*z(103) - z(20)*z(105);
z(132) = z(1)*z(96) + z(44)*z(110) - z(131);
z(114) = z(12)*z(110) + z(18)*z(85) + z(21)*z(109);
z(123) = z(19)*z(85) + z(22)*z(109) - z(14)*z(110);
z(133) = l2*(z(4)*z(73)+z(5)*z(74)+z(37)*z(75))*z(109) + z(52)*(z(4)*z(73)+z(6)*z(71)+z(37)*z(75))*z(85) + (z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(126) + rada*z(2)*(z(4)*z(73)+z(6)*z(71)+z(37)*z(75))*z(94) + z(31)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(128) + z(34)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(130) + z(53)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(122) + z(56)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(117) + 0.5*l2*z(6)*(z(1)*z(102)+z(2)*z(108)-2*z(73)*z(110)-2*z(74)*z(85)-2*z(75)*z(111)-z(36)*z(107)) + 0.5*z(5)*z(52)*(z(1)*z(102)+z(3)*z(104)-2*z(71)*z(109)-2*z(73)*z(110)-2*z(75)*z(111)-z(36)*z(107)) + 0.5*z(62)*(z(1)*z(102)+z(2)*z(108)+z(3)*z(104)-2*z(71)*z(109)-2*z(73)*z(110)-2*z(74)*z(85)-2*z(75)*z(111)-z(36)*z(107)) + 0.5*z(30)*z(53)*(z(4)*z(102)+z(5)*z(108)+z(6)*z(104)-2*z(71)*z(103)-2*z(73)*z(86)-2*z(74)*z(105)-2*z(75)*z(106)-z(37)*z(107)) + 0.5*z(33)*z(56)*(z(4)*z(102)+z(5)*z(108)+z(6)*z(104)-2*z(71)*z(103)-2*z(73)*z(86)-2*z(74)*z(105)-2*z(75)*z(106)-z(37)*z(107)) - l2*(z(1)*z(73)+z(2)*z(74)+z(36)*z(75))*z(103) - z(52)*(z(1)*z(73)+z(3)*z(71)+z(36)*z(75))*z(105) - (z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(132) - rada*z(5)*(z(1)*z(73)+z(3)*z(71)+z(36)*z(75))*z(94) - z(30)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(128) - z(33)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(130) - z(53)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(114) - z(56)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(123) - 0.5*l2*z(3)*(z(4)*z(102)+z(5)*z(108)-2*z(73)*z(86)-2*z(74)*z(105)-2*z(75)*z(106)-z(37)*z(107)) - 0.5*z(2)*z(52)*(z(4)*z(102)+z(6)*z(104)-2*z(71)*z(103)-2*z(73)*z(86)-2*z(75)*z(106)-z(37)*z(107)) - 0.5*z(59)*(z(4)*z(102)+z(5)*z(108)+z(6)*z(104)-2*z(71)*z(103)-2*z(73)*z(86)-2*z(74)*z(105)-2*z(75)*z(106)-z(37)*z(107)) - 0.5*z(31)*z(53)*(z(1)*z(102)+z(2)*z(108)+z(3)*z(104)-2*z(71)*z(109)-2*z(73)*z(110)-2*z(74)*z(85)-2*z(75)*z(111)-z(36)*z(107)) - 0.5*z(34)*z(56)*(z(1)*z(102)+z(2)*z(108)+z(3)*z(104)-2*z(71)*z(109)-2*z(73)*z(110)-2*z(74)*z(85)-2*z(75)*z(111)-z(36)*z(107));
z(135) = z(134) - z(5)*z(96) - z(44)*z(105);
z(141) = z(2)*z(96) + z(44)*z(85) - z(140);
z(142) = l1*(z(1)*z(73)+z(2)*z(74)+z(36)*z(75))*z(103) + z(51)*(z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(110) + (z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(135) + rada*z(4)*(z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(94) + z(30)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(137) + z(34)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(139) + z(54)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(114) + z(57)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(117) + 0.5*l1*z(3)*(z(4)*z(102)+z(5)*z(108)-2*z(73)*z(86)-2*z(74)*z(105)-2*z(75)*z(106)-z(37)*z(107)) + 0.5*z(4)*z(51)*(z(2)*z(108)+z(3)*z(104)-2*z(71)*z(109)-2*z(74)*z(85)-2*z(75)*z(111)-z(36)*z(107)) + 0.5*z(63)*(z(1)*z(102)+z(2)*z(108)+z(3)*z(104)-2*z(71)*z(109)-2*z(73)*z(110)-2*z(74)*z(85)-2*z(75)*z(111)-z(36)*z(107)) + 0.5*z(31)*z(54)*(z(1)*z(102)+z(2)*z(108)+z(3)*z(104)-2*z(71)*z(109)-2*z(73)*z(110)-2*z(74)*z(85)-2*z(75)*z(111)-z(36)*z(107)) + 0.5*z(33)*z(57)*(z(4)*z(102)+z(5)*z(108)+z(6)*z(104)-2*z(71)*z(103)-2*z(73)*z(86)-2*z(74)*z(105)-2*z(75)*z(106)-z(37)*z(107)) - l1*(z(4)*z(73)+z(5)*z(74)+z(37)*z(75))*z(109) - z(51)*(z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(86) - (z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(141) - rada*z(1)*(z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(94) - z(31)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(137) - z(33)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(139) - z(54)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(122) - z(57)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(123) - 0.5*l1*z(6)*(z(1)*z(102)+z(2)*z(108)-2*z(73)*z(110)-2*z(74)*z(85)-2*z(75)*z(111)-z(36)*z(107)) - 0.5*z(1)*z(51)*(z(5)*z(108)+z(6)*z(104)-2*z(71)*z(103)-2*z(74)*z(105)-2*z(75)*z(106)-z(37)*z(107)) - 0.5*z(60)*(z(4)*z(102)+z(5)*z(108)+z(6)*z(104)-2*z(71)*z(103)-2*z(73)*z(86)-2*z(74)*z(105)-2*z(75)*z(106)-z(37)*z(107)) - 0.5*z(30)*z(54)*(z(4)*z(102)+z(5)*z(108)+z(6)*z(104)-2*z(71)*z(103)-2*z(73)*z(86)-2*z(74)*z(105)-2*z(75)*z(106)-z(37)*z(107)) - 0.5*z(34)*z(57)*(z(1)*z(102)+z(2)*z(108)+z(3)*z(104)-2*z(71)*z(109)-2*z(73)*z(110)-2*z(74)*z(85)-2*z(75)*z(111)-z(36)*z(107));
z(113) = z(112) - z(6)*z(96) - z(44)*z(103);
z(121) = z(3)*z(96) + z(44)*z(109) - z(120);
z(124) = l1*(z(4)*z(73)+z(6)*z(71)+z(37)*z(75))*z(85) + l2*(z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(86) + (z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(113) + z(30)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(116) + z(34)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(119) + z(55)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(114) + z(58)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(117) + 0.5*l1*z(5)*(z(1)*z(102)+z(3)*z(104)-2*z(71)*z(109)-2*z(73)*z(110)-2*z(75)*z(111)-z(36)*z(107)) + 0.5*l2*z(1)*(z(5)*z(108)+z(6)*z(104)-2*z(71)*z(103)-2*z(74)*z(105)-2*z(75)*z(106)-z(37)*z(107)) + 0.5*z(64)*(z(1)*z(102)+z(2)*z(108)+z(3)*z(104)-2*z(71)*z(109)-2*z(73)*z(110)-2*z(74)*z(85)-2*z(75)*z(111)-z(36)*z(107)) + 0.5*z(31)*z(55)*(z(1)*z(102)+z(2)*z(108)+z(3)*z(104)-2*z(71)*z(109)-2*z(73)*z(110)-2*z(74)*z(85)-2*z(75)*z(111)-z(36)*z(107)) + 0.5*z(33)*z(58)*(z(4)*z(102)+z(5)*z(108)+z(6)*z(104)-2*z(71)*z(103)-2*z(73)*z(86)-2*z(74)*z(105)-2*z(75)*z(106)-z(37)*z(107)) - l1*(z(1)*z(73)+z(3)*z(71)+z(36)*z(75))*z(105) - l2*(z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(110) - (z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(121) - z(31)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(116) - z(33)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(119) - z(55)*(z(1)*z(73)+z(2)*z(74)+z(3)*z(71)+z(36)*z(75))*z(122) - z(58)*(z(4)*z(73)+z(5)*z(74)+z(6)*z(71)+z(37)*z(75))*z(123) - 0.5*l1*z(2)*(z(4)*z(102)+z(6)*z(104)-2*z(71)*z(103)-2*z(73)*z(86)-2*z(75)*z(106)-z(37)*z(107)) - 0.5*l2*z(4)*(z(2)*z(108)+z(3)*z(104)-2*z(71)*z(109)-2*z(74)*z(85)-2*z(75)*z(111)-z(36)*z(107)) - 0.5*z(61)*(z(4)*z(102)+z(5)*z(108)+z(6)*z(104)-2*z(71)*z(103)-2*z(73)*z(86)-2*z(74)*z(105)-2*z(75)*z(106)-z(37)*z(107)) - 0.5*z(30)*z(55)*(z(4)*z(102)+z(5)*z(108)+z(6)*z(104)-2*z(71)*z(103)-2*z(73)*z(86)-2*z(74)*z(105)-2*z(75)*z(106)-z(37)*z(107)) - 0.5*z(34)*z(58)*(z(1)*z(102)+z(2)*z(108)+z(3)*z(104)-2*z(71)*z(109)-2*z(73)*z(110)-2*z(74)*z(85)-2*z(75)*z(111)-z(36)*z(107));
z(143) = u1*z(133) + u2*z(142) + u3*z(124);
z(150) = (z(76)*z(149)-z(79)*z(143))/z(82);
z(210) = z(208) + mda*(z(45)*z(47)+z(48)*z(50)+z(2)*z(28)*z(47)-z(5)*z(28)*z(50)) + mdb*(l1*z(52)+z(45)*z(47)+z(48)*z(50)+l1*z(2)*z(45)+l2*z(3)*z(47)+l2*z(4)*z(48)+z(2)*z(47)*z(52)-l1*z(5)*z(48)-l2*z(1)*z(45)-l2*z(6)*z(50)-z(5)*z(50)*z(52)) - z(209);
z(221) = z(219) + mdb*(z(46)*z(47)+z(49)*z(50)+l1*z(2)*z(46)+l1*z(6)*z(50)+l2*z(4)*z(49)+z(1)*z(47)*z(51)-l2*z(51)-l1*z(3)*z(47)-l1*z(5)*z(49)-l2*z(1)*z(46)-z(4)*z(50)*z(51)) - z(220) - mda*(z(1)*z(28)*z(47)-z(46)*z(47)-z(49)*z(50)-z(4)*z(28)*z(50));
z(224) = z(223) + mda*(z(47)^2+z(50)^2) - mdb*(2*l1*z(5)*z(50)+2*l2*z(1)*z(47)-z(201)-z(213)-z(47)^2-z(50)^2-2*l1*z(2)*z(47)-2*l2*z(4)*z(50));
z(234) = z(210) + z(83)*z(221) + z(84)*z(224);
z(151) = (z(78)*z(149)-z(81)*z(143))/z(82);
z(237) = z(235) + z(233)*z(150) - z(234)*z(151);
z(154) = z(28)*z(83);
z(157) = z(51)*z(83) - l2*z(84);
z(155) = z(52) + l1*z(84);
z(156) = l2 - l1*z(83);
z(158) = 9.810000000000001*mda*(z(7)*z(154)-z(8)*z(28)) - 9.810000000000001*mdb*(z(7)*z(157)+z(8)*z(155)+z(9)*z(156));
z(238) = z(237) - z(158);
z(202) = z(200) + mda*(z(28)^2+z(45)^2+z(48)^2+2*z(2)*z(28)*z(45)-2*z(5)*z(28)*z(48)) + mdb*(z(201)+z(45)^2+z(48)^2+z(52)^2+2*l2*z(3)*z(45)+2*z(2)*z(45)*z(52)-2*l2*z(6)*z(48)-2*z(5)*z(48)*z(52));
z(218) = z(215) + mda*(z(45)*z(46)+z(48)*z(49)+z(2)*z(28)*z(46)+z(4)*z(28)*z(48)-z(1)*z(28)*z(45)-z(5)*z(28)*z(49)) + mdb*(z(45)*z(46)+z(48)*z(49)+l1*z(6)*z(48)+l2*z(3)*z(46)+z(1)*z(45)*z(51)+z(2)*z(46)*z(52)-z(206)-l1*z(3)*z(45)-l2*z(6)*z(49)-z(4)*z(48)*z(51)-z(5)*z(49)*z(52)) - z(216) - z(217);
z(227) = z(225) + mda*(z(45)*z(47)+z(48)*z(50)+z(2)*z(28)*z(47)-z(5)*z(28)*z(50)) + mdb*(l1*z(52)+z(45)*z(47)+z(48)*z(50)+l1*z(2)*z(45)+l2*z(3)*z(47)+l2*z(4)*z(48)+z(2)*z(47)*z(52)-l1*z(5)*z(48)-l2*z(1)*z(45)-l2*z(6)*z(50)-z(5)*z(50)*z(52)) - z(226);
z(232) = z(202) + z(83)*z(218) + z(84)*z(227);
z(236) = z(232) + z(83)*z(233) + z(84)*z(234);
z(239) = z(238)/z(236);
u1p = -z(239);
posa1p = z(45)*u1 + z(46)*u2 + z(47)*u3 + z(2)*z(28)*u1 - z(1)*z(28)*u2;
posa2p = z(5)*z(28)*u1 - z(48)*u1 - z(49)*u2 - z(50)*u3 - z(4)*z(28)*u2;
posa3p = -z(28)*(z(7)*u2-z(8)*u1);
posb1p = z(45)*u1 + z(46)*u2 + z(47)*u3 + z(2)*(l1*u3+z(52)*u1) - z(1)*(l2*u3-z(51)*u2) - z(3)*(l1*u2-l2*u1);
posb2p = z(5)*(l1*u3+z(52)*u1) - z(48)*u1 - z(49)*u2 - z(50)*u3 - z(4)*(l2*u3-z(51)*u2) - z(6)*(l1*u2-l2*u1);
posb3p = z(8)*(l1*u3+z(52)*u1) - z(7)*(l2*u3-z(51)*u2) - z(9)*(l1*u2-l2*u1);
cahat1p = z(45)*u1 + z(46)*u2 + z(47)*u3 - z(4)*z(29)*u1 - z(5)*z(29)*u2;
cahat2p = z(1)*z(29)*u1 + z(2)*z(29)*u2 - z(48)*u1 - z(49)*u2 - z(50)*u3;
cbhat1p = z(45)*u1 + z(46)*u2 + z(47)*u3 + z(2)*(l1*u3+z(52)*u1) - z(4)*z(44)*u1 - z(5)*z(44)*u2 - z(6)*z(44)*u3 - z(1)*(l2*u3-z(51)*u2) - z(3)*(l1*u2-l2*u1) - z(33)*z(43)*(z(12)*u1+z(18)*u2+z(21)*u3) - z(30)*z(43)*(z(14)*u1-z(19)*u2-z(22)*u3) - z(37)*z(44)*(z(20)*u2-z(15)*u1-z(23)*u3);
cbhat2p = z(1)*z(44)*u1 + z(2)*z(44)*u2 + z(3)*z(44)*u3 + z(5)*(l1*u3+z(52)*u1) + z(36)*z(44)*(z(20)*u2-z(15)*u1-z(23)*u3) - z(48)*u1 - z(49)*u2 - z(50)*u3 - z(4)*(l2*u3-z(51)*u2) - z(6)*(l1*u2-l2*u1) - z(34)*z(43)*(z(12)*u1+z(18)*u2+z(21)*u3) - z(31)*z(43)*(z(14)*u1-z(19)*u2-z(22)*u3);

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
VARp(17) = u1p;

sys = VARp';



%===========================================================================
% mdlOutputs: Calculates and return the outputs
%===========================================================================
function Output = mdlOutputs(T,VAR,u)
global   a1 a2 a3 ida11 ida22 ida33 idb11 idb22 idb33 l1 l2 l3 mda mdb rada radb;
global   cahat1 cahat2 cahat3 cbhat1 cbhat2 cbhat3 e1 e2 e3 e4 posa1 posa2 posa3 posb1 posb2 posb3 u1;
global   ke pe u2 u3 cahat1p cahat2p cahat3p cbhat1p cbhat2p cbhat3p e1p e2p e3p e4p posa1p posa2p posa3p posb1p posb2p posb3p u1p;
global   DEGtoRAD RADtoDEG z t_da t_db Encode;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

% Evaluate output quantities
ke = 0.5*ida11*u1^2 + 0.5*ida22*u2^2 + 0.5*ida33*u3^2 + 0.5*idb22*z(22)^2*u3^2 + 0.5*idb33*z(23)^2*u3^2 + 0.5*idb11*z(12)*u1*(z(12)*u1+2*z(18)*u2) + 0.5*idb11*z(18)*u2*(z(18)*u2+2*z(21)*u3) + 0.5*idb11*z(21)*u3*(z(21)*u3+2*z(12)*u1) + 0.5*idb22*z(19)*u2*(z(19)*u2+2*z(22)*u3) + 0.5*idb33*z(15)*u1*(z(15)*u1+2*z(23)*u3) + 0.5*idb22*z(14)*u1*(z(14)*u1-2*z(19)*u2-2*z(22)*u3) + 0.5*idb33*z(20)*u2*(z(20)*u2-2*z(15)*u1-2*z(23)*u3) + 0.5*mda*(z(28)^2*u1^2+z(28)^2*u2^2+(z(45)*u1+z(46)*u2+z(47)*u3)^2+(z(48)*u1+z(49)*u2+z(50)*u3)^2+2*z(2)*z(28)*u1*(z(45)*u1+z(46)*u2+z(47)*u3)+2*z(4)*z(28)*u2*(z(48)*u1+z(49)*u2+z(50)*u3)-2*z(1)*z(28)*u2*(z(45)*u1+z(46)*u2+z(47)*u3)-2*z(5)*z(28)*u1*(z(48)*u1+z(49)*u2+z(50)*u3)) - 0.5*mdb*(2*z(5)*(l1*u3+z(52)*u1)*(z(48)*u1+z(49)*u2+z(50)*u3)+2*z(1)*(l2*u3-z(51)*u2)*(z(45)*u1+z(46)*u2+z(47)*u3)+2*z(3)*(l1*u2-l2*u1)*(z(45)*u1+z(46)*u2+z(47)*u3)-(l1*u3+z(52)*u1)^2-(l1*u2-l2*u1)^2-(l2*u3-z(51)*u2)^2-(z(45)*u1+z(46)*u2+z(47)*u3)^2-(z(48)*u1+z(49)*u2+z(50)*u3)^2-2*z(2)*(l1*u3+z(52)*u1)*(z(45)*u1+z(46)*u2+z(47)*u3)-2*z(4)*(l2*u3-z(51)*u2)*(z(48)*u1+z(49)*u2+z(50)*u3)-2*z(6)*(l1*u2-l2*u1)*(z(48)*u1+z(49)*u2+z(50)*u3));
pe = 9.810000000000001*mda*posa3 + 9.810000000000001*mdb*posb3;

Output(1)=ke+pe;  Output(2)=((-l1*z(1)-l2*z(2)-z(36)*z(43)-z(3)*(l3-z(28)))*(z(51)*u2-l2*u3)*z(4)+(l1*z(4)+l2*z(5)+z(37)*z(43)+z(6)*(l3-z(28)))*(z(51)*u2-l2*u3)*z(1)+(-l1*z(1)-l2*z(2)-z(36)*z(43)-z(3)*(l3-z(28)))*(l1*u3+z(52)*u1)*z(5)+(l1*z(4)+l2*z(5)+z(37)*z(43)+z(6)*(l3-z(28)))*(l1*u3+z(52)*u1)*z(2)+(-l1*z(1)-l2*z(2)-z(36)*z(43)-z(3)*(l3-z(28)))*(l2*u1-l1*u2)*z(6)+(l1*z(4)+l2*z(5)+z(37)*z(43)+z(6)*(l3-z(28)))*(l2*u1-l1*u2)*z(3)+(-l1*z(1)-l2*z(2)-z(36)*z(43)-z(3)*(l3-z(28)))*(z(54)*u2+z(55)*u3-z(53)*u1)*z(31)+(l1*z(4)+l2*z(5)+z(37)*z(43)+z(6)*(l3-z(28)))*(z(54)*u2+z(55)*u3-z(53)*u1)*z(30)+(-l1*z(1)-l2*z(2)-z(36)*z(43)-z(3)*(l3-z(28)))*(-z(56)*u1-z(57)*u2-z(58)*u3)*z(34)+(l1*z(4)+l2*z(5)+z(37)*z(43)+z(6)*(l3-z(28)))*(-z(56)*u1-z(57)*u2-z(58)*u3)*z(33)+(l1*z(4)+l2*z(5)+z(37)*z(43)+z(6)*(l3-z(28)))*(z(59)*u1+z(60)*u2+z(61)*u3)+(-l1*z(1)-l2*z(2)-z(36)*z(43)-z(3)*(l3-z(28)))*(z(62)*u1+z(63)*u2+z(64)*u3));  Output(3)=((z(51)*u2-l2*u3)*z(7)+(l1*u3+z(52)*u1)*z(8)+(l2*u1-l1*u2)*z(9)+(z(54)*u2+z(55)*u3-z(53)*u1)*z(32)+(-z(56)*u1-z(57)*u2-z(58)*u3)*z(35));  Output(4)=e1;  Output(5)=e2;  Output(6)=e3;  Output(7)=e4;  Output(8)=u1;  Output(9)=cahat1;  Output(10)=cahat2;  Output(11)=cahat3;  Output(12)=cbhat1;  Output(13)=cbhat2;  Output(14)=cbhat3;
FileIdentifier = fopen('all');
WriteOutput( 1,                 Output(1:14) );
WriteOutput( FileIdentifier(1), Output(1:14) );
t_da(1,1) = z(1);
t_da(1,2) = z(4);
t_da(1,3) = z(7);
t_da(1,4) = 0;
t_da(1,5) = z(2);
t_da(1,6) = z(5);
t_da(1,7) = z(8);
t_da(1,8) = 0;
t_da(1,9) = z(3);
t_da(1,10) = z(6);
t_da(1,11) = z(9);
t_da(1,12) = 0;
t_da(1,13) = posa1;
t_da(1,14) = posa2;
t_da(1,15) = posa3;
t_da(1,16) = 1;
t_db(1,1) = z(30);
t_db(1,2) = z(31);
t_db(1,3) = z(32);
t_db(1,4) = 0;
t_db(1,5) = z(33);
t_db(1,6) = z(34);
t_db(1,7) = z(35);
t_db(1,8) = 0;
t_db(1,9) = z(36);
t_db(1,10) = z(37);
t_db(1,11) = z(38);
t_db(1,12) = 0;
t_db(1,13) = posb1;
t_db(1,14) = posb2;
t_db(1,15) = posb3;
t_db(1,16) = 1;

Encode(1) = 0.0;
Encode(2) = 0.0;




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
fprintf( 1, '\n Output is in the file TwinDisks.1\n' );
fprintf( 1, '\n To load and plot columns 1 and 2 with a solid line and columns 1 and 3 with a dashed line, enter:\n' );
fprintf( 1, '    someName = load( ''TwinDisks.1'' );\n' );
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
sizes.NumContStates  = 17;    % sys(1) is the number of continuous states
sizes.NumDiscStates  = 0;     % sys(2) is the number of discrete states
sizes.NumOutputs     = 14;    % sys(3) is the number of outputs
sizes.NumInputs      = 0;     % sys(4) is the number of inputs
sizes.DirFeedthrough = 1;     % sys(6) is 1, and allows for the output to be a function of the input
sizes.NumSampleTimes = 1;     % sys(7) is the number of samples times (the number of rows in ts)
sys = simsizes(sizes);        % Convert it to a sizes array
stateOrderingStrings = [];
timeSampling         = [0 0]; % m-by-2 matrix containing the sample times
OpenOutputFilesAndWriteHeadings
VAR = ReadUserInput
