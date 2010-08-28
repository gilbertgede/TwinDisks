function TwinDisks
SolveOrdinaryDifferentialEquations
% File  TwinDisks.m  created by Autolev 4.1 on Fri Aug 27 22:22:45 2010


%===========================================================================
function VAR = ReadUserInput
global   a1 a2 a3 ida11 ida22 ida33 idb11 idb22 idb33 l1 l2 l3 mda mdb rada radb;
global   e1 e2 e3 e4 posa1 posa2 posa3 posb1 posb2 posb3 u1;
global   ke pe u2 u3 e1p e2p e3p e4p posa1p posa2p posa3p posb1p posb2p posb3p u1p;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

%-------------------------------+--------------------------+-------------------+-----------------
% Quantity                      | Value                    | Units             | Description
%-------------------------------|--------------------------|-------------------|-----------------
a1                              =  1.570796326794897;      % UNITS               Constant
a2                              =  0;                      % UNITS               Constant
a3                              =  0;                      % UNITS               Constant
ida11                           =  .05;                    % UNITS               Constant
ida22                           =  .05;                    % UNITS               Constant
ida33                           =  .05;                    % UNITS               Constant
idb11                           =  0.05;                   % UNITS               Constant
idb22                           =  .05;                    % UNITS               Constant
idb33                           =  .05;                    % UNITS               Constant
l1                              =  .1;                     % UNITS               Constant
l2                              =  0;                      % UNITS               Constant
l3                              =  0;                      % UNITS               Constant
mda                             =  .1;                     % UNITS               Constant
mdb                             =  .1;                     % UNITS               Constant
rada                            =  .1;                     % UNITS               Constant
radb                            =  .1;                     % UNITS               Constant

e1                              =  0.6532814824381883;     % UNITS               Initial Value
e2                              = -0.2705980500730985;     % UNITS               Initial Value
e3                              =  0.2705980500730985;     % UNITS               Initial Value
e4                              =  0.6532814824381882;     % UNITS               Initial Value
posa1                           =  0.0;                    % UNITS               Initial Value
posa2                           =  0.0;                    % UNITS               Initial Value
posa3                           =  0.0;                    % UNITS               Initial Value
posb1                           =  0.0;                    % UNITS               Initial Value
posb2                           =  0.0;                    % UNITS               Initial Value
posb3                           =  0.0;                    % UNITS               Initial Value
u1                              =  1;                      % UNITS               Initial Value

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
z = zeros(212,1);

% Evaluate constants
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
z(93) = radb*z(23);
z(98) = radb*z(21);
z(107) = radb*z(15);
z(109) = radb*z(12);
z(116) = radb*z(20);
z(118) = radb*z(18);
z(144) = idb11*z(12);
z(145) = idb11*z(18);
z(146) = idb11*z(21);
z(147) = idb22*z(19);
z(148) = idb22*z(22);
z(149) = idb22*z(14);
z(150) = idb33*z(15);
z(151) = idb33*z(23);
z(152) = idb33*z(20);
z(173) = ida11 + z(12)*z(144) + z(14)*z(149) + z(15)*z(150);
z(174) = l3^2;
z(176) = z(12)*z(145);
z(177) = z(14)*z(147);
z(178) = z(15)*z(152);
z(180) = z(12)*z(146) + z(15)*z(151);
z(181) = z(14)*z(148);
z(182) = l1*l3;
z(185) = ida22 + z(18)*z(145) + z(19)*z(147) + z(20)*z(152);
z(186) = l1^2 + l3^2;
z(188) = z(18)*z(144);
z(189) = z(19)*z(149);
z(190) = z(20)*z(150);
z(192) = z(18)*z(146) + z(19)*z(148);
z(193) = z(20)*z(151);
z(196) = ida33 + z(21)*z(146) + z(22)*z(148) + z(23)*z(151);
z(197) = l1^2;
z(199) = z(21)*z(144) + z(23)*z(150);
z(200) = z(22)*z(149);
z(202) = z(21)*z(145) + z(22)*z(147);
z(203) = z(23)*z(152);

% Set the initial values of the states
VAR(1) = e1;
VAR(2) = e2;
VAR(3) = e3;
VAR(4) = e4;
VAR(5) = posa1;
VAR(6) = posa2;
VAR(7) = posa3;
VAR(8) = posb1;
VAR(9) = posb2;
VAR(10) = posb3;
VAR(11) = u1;



%===========================================================================
function OpenOutputFilesAndWriteHeadings
FileIdentifier = fopen('TwinDisks.1', 'wt');   if( FileIdentifier == -1 ) error('Error: unable to open file TwinDisks.1'); end
fprintf( 1,             '%%     ke+pe\n' );
fprintf( 1,             '%%    (UNITS)\n\n' );
fprintf(FileIdentifier, '%% FILE: TwinDisks.1\n%%\n' );
fprintf(FileIdentifier, '%%     ke+pe\n' );
fprintf(FileIdentifier, '%%    (UNITS)\n\n' );
FileIdentifier = fopen('TwinDisks.2', 'wt');   if( FileIdentifier == -1 ) error('Error: unable to open file TwinDisks.2'); end
fprintf(FileIdentifier, '%% FILE: TwinDisks.2\n%%\n' );
fprintf(FileIdentifier, '%% dot(v_bhat_n>,\n' );
fprintf(FileIdentifier, '%%    (UNITS)\n\n' );
FileIdentifier = fopen('TwinDisks.3', 'wt');   if( FileIdentifier == -1 ) error('Error: unable to open file TwinDisks.3'); end
fprintf(FileIdentifier, '%% FILE: TwinDisks.3\n%%\n' );
fprintf(FileIdentifier, '%% dot(v_bhat_n>,\n' );
fprintf(FileIdentifier, '%%    (UNITS)\n\n' );



%===========================================================================
% Main driver loop for numerical integration of differential equations
%===========================================================================
function SolveOrdinaryDifferentialEquations
global   a1 a2 a3 ida11 ida22 ida33 idb11 idb22 idb33 l1 l2 l3 mda mdb rada radb;
global   e1 e2 e3 e4 posa1 posa2 posa3 posb1 posb2 posb3 u1;
global   ke pe u2 u3 e1p e2p e3p e4p posa1p posa2p posa3p posb1p posb2p posb3p u1p;
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
global   a1 a2 a3 ida11 ida22 ida33 idb11 idb22 idb33 l1 l2 l3 mda mdb rada radb;
global   e1 e2 e3 e4 posa1 posa2 posa3 posb1 posb2 posb3 u1;
global   ke pe u2 u3 e1p e2p e3p e4p posa1p posa2p posa3p posb1p posb2p posb3p u1p;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

% Update variables after integration step
e1 = VAR(1);
e2 = VAR(2);
e3 = VAR(3);
e4 = VAR(4);
posa1 = VAR(5);
posa2 = VAR(6);
posa3 = VAR(7);
posb1 = VAR(8);
posb2 = VAR(9);
posb3 = VAR(10);
u1 = VAR(11);
z(2) = 2*e1*e2 - 2*e3*e4;
z(4) = 2*e1*e2 + 2*e3*e4;
z(6) = 2*e2*e3 - 2*e1*e4;
z(5) = 1 - 2*e1^2 - 2*e3^2;
z(34) = z(19)*z(5) + z(22)*z(6) - z(14)*z(4);
z(8) = 2*e1*e4 + 2*e2*e3;
z(9) = 1 - 2*e1^2 - 2*e2^2;
z(7) = 2*e1*e3 - 2*e2*e4;
z(35) = z(19)*z(8) + z(22)*z(9) - z(14)*z(7);
z(39) = 1 - z(35)^2;
z(40) = z(39)^0.5;
z(41) = z(35)/z(40);
z(43) = radb*z(41);
z(1) = 1 - 2*e2^2 - 2*e3^2;
z(24) = 1 - z(8)^2;
z(25) = z(24)^0.5;
z(26) = z(8)/z(25);
z(28) = rada*z(26);
z(51) = z(28) - l2;
z(27) = 1/z(25);
z(29) = rada*z(27);
z(47) = z(6)*z(29);
z(42) = 1/z(40);
z(44) = radb*z(42);
z(61) = z(47) - z(6)*z(44);
z(31) = z(12)*z(4) + z(18)*z(5) + z(21)*z(6);
z(55) = z(23)*z(43);
z(3) = 2*e1*e3 + 2*e2*e4;
z(33) = z(19)*z(2) + z(22)*z(3) - z(14)*z(1);
z(36) = z(15)*z(1) + z(23)*z(3) - z(20)*z(2);
z(58) = z(21)*z(43);
z(50) = z(3)*z(29);
z(64) = z(3)*z(44) - z(50);
z(30) = z(12)*z(1) + z(18)*z(2) + z(21)*z(3);
z(37) = z(15)*z(4) + z(23)*z(6) - z(20)*z(5);
z(65) = l1*z(2)*(l1*z(4)+l3*z(6)+z(34)*z(43)) + z(1)*z(51)*(l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28))) + z(61)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28))) + z(31)*z(55)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28))) + z(36)*z(58)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28))) - l1*z(5)*(l1*z(1)+l3*z(3)+z(33)*z(43)) - z(4)*z(51)*(l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28))) - z(64)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28))) - z(30)*z(55)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28))) - z(37)*z(58)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)));
z(52) = l2 - z(28);
z(38) = z(15)*z(7) + z(23)*z(9) - z(20)*z(8);
z(56) = z(12)*z(43);
z(32) = z(12)*z(7) + z(18)*z(8) + z(21)*z(9);
z(54) = z(15)*z(43);
z(70) = z(9)*z(52) + z(38)*z(56) - l3*z(8) - z(32)*z(54);
z(45) = z(4)*z(29);
z(59) = z(45) - z(4)*z(44);
z(48) = z(1)*z(29);
z(62) = z(1)*z(44) - z(48);
z(66) = l3*z(5)*(l1*z(1)+l3*z(3)+z(33)*z(43)) + z(3)*z(52)*(l1*z(4)+z(34)*z(43)+z(5)*(l2-z(28))) + z(59)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28))) + z(31)*z(54)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28))) + z(36)*z(56)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28))) - l3*z(2)*(l1*z(4)+l3*z(6)+z(34)*z(43)) - z(6)*z(52)*(l1*z(1)+z(33)*z(43)+z(2)*(l2-z(28))) - z(62)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28))) - z(30)*z(54)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28))) - z(37)*z(56)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)));
z(69) = l1*z(8) + z(7)*z(51) + z(38)*z(58) - z(32)*z(55);
z(46) = z(5)*z(29);
z(60) = z(46) - z(5)*z(44);
z(53) = z(20)*z(43);
z(57) = z(18)*z(43);
z(49) = z(2)*z(29);
z(63) = z(2)*z(44) - z(49);
z(67) = l1*z(6)*(l1*z(1)+z(33)*z(43)+z(2)*(l2-z(28))) + l3*z(1)*(l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28))) + z(60)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28))) + z(30)*z(53)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28))) + z(36)*z(57)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28))) - l1*z(3)*(l1*z(4)+z(34)*z(43)+z(5)*(l2-z(28))) - l3*z(4)*(l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28))) - z(63)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28))) - z(31)*z(53)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28))) - z(37)*z(57)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)));
z(68) = l3*z(7) + z(32)*z(53) + z(38)*z(57) - l1*z(9);
z(71) = z(67)*z(69) - z(65)*z(68);
z(72) = (z(65)*z(70)-z(66)*z(69))/z(71);
u2 = z(72)*u1;
z(73) = (z(66)*z(68)-z(67)*z(70))/z(71);
u3 = z(73)*u1;
z(134) = ida33*u3;
z(133) = ida22*u2;
z(137) = u2*z(134) - u3*z(133);
z(139) = z(19)*u2 + z(22)*u3 - z(14)*u1;
z(140) = z(15)*u1 + z(23)*u3 - z(20)*u2;
z(143) = idb33*z(140);
z(142) = idb22*z(139);
z(155) = z(139)*z(143) - z(140)*z(142);
z(138) = z(12)*u1 + z(18)*u2 + z(21)*u3;
z(141) = idb11*z(138);
z(153) = z(138)*z(142) - z(139)*z(141);
z(157) = z(28)*u1;
z(156) = z(28)*u3;
z(166) = u1*z(157) + u3*z(156);
e4p = -0.5*e1*u1 - 0.5*e2*u2 - 0.5*e3*u3;
e3p = 0.5*e1*u2 + 0.5*e4*u3 - 0.5*e2*u1;
e2p = 0.5*e3*u1 + 0.5*e4*u2 - 0.5*e1*u3;
e1p = 0.5*e2*u3 + 0.5*e4*u1 - 0.5*e3*u2;
z(79) = 2*e1*e4p + 2*e2*e3p + 2*e3*e2p + 2*e4*e1p;
z(86) = z(8)*z(79)/z(24)^0.5;
z(88) = rada*z(86)/z(25)^2;
z(75) = 2*e1*e2p + 2*e2*e1p + 2*e3*e4p + 2*e4*e3p;
z(105) = z(4)*z(88) + z(29)*z(75);
z(77) = -4*e1*e1p - 4*e3*e3p;
z(114) = z(5)*z(88) + z(29)*z(77);
z(76) = 2*e2*e3p + 2*e3*e2p - 2*e1*e4p - 2*e4*e1p;
z(89) = z(6)*z(88) + z(29)*z(76);
z(162) = u1*z(105) + u2*z(114) + u3*z(89);
z(87) = (z(8)*z(86)+z(25)*z(79))/z(25)^2;
z(160) = rada*u3*z(87);
z(164) = z(160) - u2*z(157);
z(161) = rada*u1*z(87);
z(165) = -u2*z(156) - z(161);
z(85) = -4*e2*e2p - 4*e3*e3p;
z(111) = z(1)*z(88) + z(29)*z(85);
z(74) = 2*e1*e2p + 2*e2*e1p - 2*e3*e4p - 2*e4*e3p;
z(120) = z(2)*z(88) + z(29)*z(74);
z(95) = 2*e1*e3p + 2*e2*e4p + 2*e3*e1p + 2*e4*e2p;
z(100) = z(3)*z(88) + z(29)*z(95);
z(163) = -u1*z(111) - u2*z(120) - u3*z(100);
z(154) = z(140)*z(141) - z(138)*z(143);
z(167) = l3*u2 + z(51)*u3;
z(169) = z(52)*u1 - l1*u2;
z(172) = u3*z(167) - u1*z(169);
z(168) = l1*u3 - l3*u1;
z(170) = u2*z(169) + z(160) - u3*z(168);
z(171) = u1*z(168) - u2*z(167) - z(161);
z(184) = z(137) + z(12)*z(155) + z(15)*z(153) + mda*(z(2)*z(45)*z(166)+z(45)*z(162)+z(1)*z(45)*z(164)+z(3)*z(45)*z(165)-z(5)*z(48)*z(166)-z(28)*z(165)-z(48)*z(163)-z(3)*z(28)*z(162)-z(4)*z(48)*z(164)-z(6)*z(28)*z(163)-z(6)*z(48)*z(165)) - z(14)*z(154) - mdb*(l3*z(172)+z(5)*z(48)*z(172)+z(48)*z(163)+l3*z(2)*z(162)+l3*z(5)*z(163)+z(4)*z(48)*z(170)+z(6)*z(48)*z(171)-z(2)*z(45)*z(172)-z(45)*z(162)-z(52)*z(171)-z(1)*z(45)*z(170)-z(3)*z(45)*z(171)-z(3)*z(52)*z(162)-z(6)*z(52)*z(163));
z(132) = ida11*u1;
z(136) = u3*z(132) - u1*z(134);
z(195) = z(136) + z(18)*z(155) + z(19)*z(154) + mda*(z(2)*z(46)*z(166)+z(46)*z(162)+z(1)*z(46)*z(164)+z(3)*z(46)*z(165)-z(5)*z(49)*z(166)-z(49)*z(163)-z(4)*z(49)*z(164)-z(6)*z(49)*z(165)) + mdb*(z(2)*z(46)*z(172)+l3*z(170)+z(46)*z(162)+l3*z(1)*z(162)+l3*z(4)*z(163)+z(1)*z(46)*z(170)+z(3)*z(46)*z(171)-z(5)*z(49)*z(172)-l1*z(171)-z(49)*z(163)-l1*z(3)*z(162)-l1*z(6)*z(163)-z(4)*z(49)*z(170)-z(6)*z(49)*z(171)) - z(20)*z(153);
z(135) = u1*z(133) - u2*z(132);
z(205) = z(135) + z(21)*z(155) + z(22)*z(154) + z(23)*z(153) + mda*(z(2)*z(47)*z(166)+z(28)*z(164)+z(47)*z(162)+z(1)*z(28)*z(162)+z(1)*z(47)*z(164)+z(3)*z(47)*z(165)+z(4)*z(28)*z(163)-z(5)*z(50)*z(166)-z(50)*z(163)-z(4)*z(50)*z(164)-z(6)*z(50)*z(165)) + mdb*(l1*z(172)+z(2)*z(47)*z(172)+z(47)*z(162)+z(51)*z(170)+l1*z(2)*z(162)+l1*z(5)*z(163)+z(1)*z(47)*z(170)+z(1)*z(51)*z(162)+z(3)*z(47)*z(171)+z(4)*z(51)*z(163)-z(5)*z(50)*z(172)-z(50)*z(163)-z(4)*z(50)*z(170)-z(6)*z(50)*z(171));
z(209) = z(184) + z(72)*z(195) + z(73)*z(205);
z(179) = z(176) + mdb*(z(45)*z(46)+z(48)*z(49)+l1*z(6)*z(48)+l3*z(1)*z(45)+l3*z(5)*z(49)+z(3)*z(46)*z(52)-l1*z(52)-l1*z(3)*z(45)-l3*z(2)*z(46)-l3*z(4)*z(48)-z(6)*z(49)*z(52)) - z(177) - z(178) - mda*(z(3)*z(28)*z(46)-z(45)*z(46)-z(48)*z(49)-z(6)*z(28)*z(49));
z(187) = z(185) + mda*(z(46)^2+z(49)^2) + mdb*(z(186)+z(46)^2+z(49)^2+2*l1*z(6)*z(49)+2*l3*z(1)*z(46)-2*l1*z(3)*z(46)-2*l3*z(4)*z(49));
z(204) = z(202) + mda*(z(46)*z(47)+z(49)*z(50)+z(1)*z(28)*z(46)-z(4)*z(28)*z(49)) + mdb*(l3*z(51)+z(46)*z(47)+z(49)*z(50)+l1*z(2)*z(46)+l1*z(6)*z(50)+l3*z(1)*z(47)+z(1)*z(46)*z(51)-l1*z(3)*z(47)-l1*z(5)*z(49)-l3*z(4)*z(50)-z(4)*z(49)*z(51)) - z(203);
z(207) = z(179) + z(72)*z(187) + z(73)*z(204);
z(80) = -4*e1*e1p - 4*e2*e2p;
z(81) = 2*e1*e3p + 2*e3*e1p - 2*e2*e4p - 2*e4*e2p;
z(82) = z(19)*z(79) + z(22)*z(80) - z(14)*z(81);
z(83) = z(35)*z(82)/z(39)^0.5;
z(84) = (z(35)*z(83)+z(40)*z(82))/z(40)^2;
z(110) = z(109)*z(84);
z(125) = z(15)*z(81) + z(23)*z(80) - z(20)*z(79);
z(108) = z(107)*z(84);
z(124) = z(12)*z(81) + z(18)*z(79) + z(21)*z(80);
z(128) = z(38)*z(110) + z(52)*z(80) + z(56)*z(125) - l3*z(79) - z(32)*z(108) - z(54)*z(124) - rada*z(9)*z(87);
z(117) = z(116)*z(84);
z(119) = z(118)*z(84);
z(126) = l3*z(81) + z(32)*z(117) + z(38)*z(119) + z(53)*z(124) + z(57)*z(125) - l1*z(80);
z(99) = z(98)*z(84);
z(94) = z(93)*z(84);
z(127) = l1*z(79) + z(38)*z(99) + z(51)*z(81) + z(58)*z(125) + rada*z(7)*z(87) - z(32)*z(94) - z(55)*z(124);
z(129) = u1*z(128) + u2*z(126) + u3*z(127);
z(96) = z(19)*z(74) + z(22)*z(95) - z(14)*z(85);
z(90) = radb*z(83)/z(40)^2;
z(106) = z(105) - z(4)*z(90) - z(44)*z(75);
z(92) = z(12)*z(75) + z(18)*z(77) + z(21)*z(76);
z(97) = z(15)*z(85) + z(23)*z(95) - z(20)*z(74);
z(78) = z(19)*z(77) + z(22)*z(76) - z(14)*z(75);
z(112) = z(1)*z(90) + z(44)*z(85) - z(111);
z(102) = z(12)*z(85) + z(18)*z(74) + z(21)*z(95);
z(103) = z(15)*z(75) + z(23)*z(76) - z(20)*z(77);
z(113) = l3*(l1*z(1)+l3*z(3)+z(33)*z(43))*z(77) + l3*z(5)*(l1*z(85)+l3*z(95)+z(43)*z(96)+radb*z(33)*z(84)) + z(52)*(l1*z(4)+z(34)*z(43)+z(5)*(l2-z(28)))*z(95) + (l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(106) + rada*z(6)*(l1*z(1)+z(33)*z(43)+z(2)*(l2-z(28)))*z(87) + z(31)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(108) + z(36)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(110) + z(54)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(92) + z(56)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(97) + z(6)*z(52)*(rada*z(2)*z(87)-l1*z(85)-z(43)*z(96)-radb*z(33)*z(84)-(l2-z(28))*z(74)) + z(62)*(rada*z(2)*z(87)-l1*z(85)-l3*z(95)-z(43)*z(96)-radb*z(33)*z(84)-(l2-z(28))*z(74)) + z(30)*z(54)*(rada*z(5)*z(87)-l1*z(75)-l3*z(76)-z(43)*z(78)-radb*z(34)*z(84)-(l2-z(28))*z(77)) + z(37)*z(56)*(rada*z(2)*z(87)-l1*z(85)-l3*z(95)-z(43)*z(96)-radb*z(33)*z(84)-(l2-z(28))*z(74)) - l3*(l1*z(4)+l3*z(6)+z(34)*z(43))*z(74) - l3*z(2)*(l1*z(75)+l3*z(76)+z(43)*z(78)+radb*z(34)*z(84)) - z(52)*(l1*z(1)+z(33)*z(43)+z(2)*(l2-z(28)))*z(76) - (l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(112) - rada*z(3)*(l1*z(4)+z(34)*z(43)+z(5)*(l2-z(28)))*z(87) - z(30)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(108) - z(37)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(110) - z(54)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(102) - z(56)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(103) - z(3)*z(52)*(rada*z(5)*z(87)-l1*z(75)-z(43)*z(78)-radb*z(34)*z(84)-(l2-z(28))*z(77)) - z(59)*(rada*z(5)*z(87)-l1*z(75)-l3*z(76)-z(43)*z(78)-radb*z(34)*z(84)-(l2-z(28))*z(77)) - z(31)*z(54)*(rada*z(2)*z(87)-l1*z(85)-l3*z(95)-z(43)*z(96)-radb*z(33)*z(84)-(l2-z(28))*z(74)) - z(36)*z(56)*(rada*z(5)*z(87)-l1*z(75)-l3*z(76)-z(43)*z(78)-radb*z(34)*z(84)-(l2-z(28))*z(77));
z(115) = z(114) - z(5)*z(90) - z(44)*z(77);
z(121) = z(2)*z(90) + z(44)*z(74) - z(120);
z(122) = l1*(l1*z(1)+z(33)*z(43)+z(2)*(l2-z(28)))*z(76) + l3*(l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(85) + (l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(115) + z(30)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(117) + z(36)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(119) + z(53)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(102) + z(57)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(97) + l1*z(3)*(rada*z(5)*z(87)-l1*z(75)-z(43)*z(78)-radb*z(34)*z(84)-(l2-z(28))*z(77)) + l3*z(4)*(rada*z(2)*z(87)-l3*z(95)-z(43)*z(96)-radb*z(33)*z(84)-(l2-z(28))*z(74)) + z(63)*(rada*z(2)*z(87)-l1*z(85)-l3*z(95)-z(43)*z(96)-radb*z(33)*z(84)-(l2-z(28))*z(74)) + z(31)*z(53)*(rada*z(2)*z(87)-l1*z(85)-l3*z(95)-z(43)*z(96)-radb*z(33)*z(84)-(l2-z(28))*z(74)) + z(37)*z(57)*(rada*z(2)*z(87)-l1*z(85)-l3*z(95)-z(43)*z(96)-radb*z(33)*z(84)-(l2-z(28))*z(74)) - l1*(l1*z(4)+z(34)*z(43)+z(5)*(l2-z(28)))*z(95) - l3*(l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(75) - (l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(121) - z(31)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(117) - z(37)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(119) - z(53)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(92) - z(57)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(103) - l1*z(6)*(rada*z(2)*z(87)-l1*z(85)-z(43)*z(96)-radb*z(33)*z(84)-(l2-z(28))*z(74)) - l3*z(1)*(rada*z(5)*z(87)-l3*z(76)-z(43)*z(78)-radb*z(34)*z(84)-(l2-z(28))*z(77)) - z(60)*(rada*z(5)*z(87)-l1*z(75)-l3*z(76)-z(43)*z(78)-radb*z(34)*z(84)-(l2-z(28))*z(77)) - z(30)*z(53)*(rada*z(5)*z(87)-l1*z(75)-l3*z(76)-z(43)*z(78)-radb*z(34)*z(84)-(l2-z(28))*z(77)) - z(36)*z(57)*(rada*z(5)*z(87)-l1*z(75)-l3*z(76)-z(43)*z(78)-radb*z(34)*z(84)-(l2-z(28))*z(77));
z(91) = z(89) - z(6)*z(90) - z(44)*z(76);
z(101) = z(3)*z(90) + z(44)*z(95) - z(100);
z(104) = l1*(l1*z(4)+l3*z(6)+z(34)*z(43))*z(74) + l1*z(2)*(l1*z(75)+l3*z(76)+z(43)*z(78)+radb*z(34)*z(84)) + z(51)*(l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(85) + (l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(91) + rada*z(1)*(l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(87) + z(31)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(94) + z(36)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(99) + z(55)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(92) + z(58)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(97) + z(4)*z(51)*(rada*z(2)*z(87)-l3*z(95)-z(43)*z(96)-radb*z(33)*z(84)-(l2-z(28))*z(74)) + z(64)*(rada*z(2)*z(87)-l1*z(85)-l3*z(95)-z(43)*z(96)-radb*z(33)*z(84)-(l2-z(28))*z(74)) + z(30)*z(55)*(rada*z(5)*z(87)-l1*z(75)-l3*z(76)-z(43)*z(78)-radb*z(34)*z(84)-(l2-z(28))*z(77)) + z(37)*z(58)*(rada*z(2)*z(87)-l1*z(85)-l3*z(95)-z(43)*z(96)-radb*z(33)*z(84)-(l2-z(28))*z(74)) - l1*(l1*z(1)+l3*z(3)+z(33)*z(43))*z(77) - l1*z(5)*(l1*z(85)+l3*z(95)+z(43)*z(96)+radb*z(33)*z(84)) - z(51)*(l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(75) - (l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(101) - rada*z(4)*(l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(87) - z(30)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(94) - z(37)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(99) - z(55)*(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*z(102) - z(58)*(l1*z(1)+l3*z(3)+z(33)*z(43)+z(2)*(l2-z(28)))*z(103) - z(1)*z(51)*(rada*z(5)*z(87)-l3*z(76)-z(43)*z(78)-radb*z(34)*z(84)-(l2-z(28))*z(77)) - z(61)*(rada*z(5)*z(87)-l1*z(75)-l3*z(76)-z(43)*z(78)-radb*z(34)*z(84)-(l2-z(28))*z(77)) - z(31)*z(55)*(rada*z(2)*z(87)-l1*z(85)-l3*z(95)-z(43)*z(96)-radb*z(33)*z(84)-(l2-z(28))*z(74)) - z(36)*z(58)*(rada*z(5)*z(87)-l1*z(75)-l3*z(76)-z(43)*z(78)-radb*z(34)*z(84)-(l2-z(28))*z(77));
z(123) = u1*z(113) + u2*z(122) + u3*z(104);
z(130) = (z(65)*z(129)-z(69)*z(123))/z(71);
z(183) = z(180) + mdb*(z(45)*z(47)+z(48)*z(50)+l1*z(2)*z(45)+l3*z(5)*z(50)+z(1)*z(45)*z(51)+z(3)*z(47)*z(52)-z(182)-l1*z(5)*z(48)-l3*z(2)*z(47)-z(4)*z(48)*z(51)-z(6)*z(50)*z(52)) - z(181) - mda*(z(3)*z(28)*z(47)+z(4)*z(28)*z(48)-z(45)*z(47)-z(48)*z(50)-z(1)*z(28)*z(45)-z(6)*z(28)*z(50));
z(194) = z(192) + mda*(z(46)*z(47)+z(49)*z(50)+z(1)*z(28)*z(46)-z(4)*z(28)*z(49)) + mdb*(l3*z(51)+z(46)*z(47)+z(49)*z(50)+l1*z(2)*z(46)+l1*z(6)*z(50)+l3*z(1)*z(47)+z(1)*z(46)*z(51)-l1*z(3)*z(47)-l1*z(5)*z(49)-l3*z(4)*z(50)-z(4)*z(49)*z(51)) - z(193);
z(198) = z(196) + mda*(z(28)^2+z(47)^2+z(50)^2+2*z(1)*z(28)*z(47)-2*z(4)*z(28)*z(50)) + mdb*(z(197)+z(47)^2+z(50)^2+z(51)^2+2*l1*z(2)*z(47)+2*z(1)*z(47)*z(51)-2*l1*z(5)*z(50)-2*z(4)*z(50)*z(51));
z(208) = z(183) + z(72)*z(194) + z(73)*z(198);
z(131) = (z(67)*z(129)-z(68)*z(123))/z(71);
z(211) = z(209) + z(207)*z(130) - z(208)*z(131);
z(175) = z(173) + mdb*(z(174)+z(45)^2+z(48)^2+z(52)^2+2*l3*z(5)*z(48)+2*z(3)*z(45)*z(52)-2*l3*z(2)*z(45)-2*z(6)*z(48)*z(52)) - mda*(2*z(3)*z(28)*z(45)-z(28)^2-z(45)^2-z(48)^2-2*z(6)*z(28)*z(48));
z(191) = z(188) + mdb*(z(45)*z(46)+z(48)*z(49)+l1*z(6)*z(48)+l3*z(1)*z(45)+l3*z(5)*z(49)+z(3)*z(46)*z(52)-l1*z(52)-l1*z(3)*z(45)-l3*z(2)*z(46)-l3*z(4)*z(48)-z(6)*z(49)*z(52)) - z(189) - z(190) - mda*(z(3)*z(28)*z(46)-z(45)*z(46)-z(48)*z(49)-z(6)*z(28)*z(49));
z(201) = z(199) + mdb*(z(45)*z(47)+z(48)*z(50)+l1*z(2)*z(45)+l3*z(5)*z(50)+z(1)*z(45)*z(51)+z(3)*z(47)*z(52)-z(182)-l1*z(5)*z(48)-l3*z(2)*z(47)-z(4)*z(48)*z(51)-z(6)*z(50)*z(52)) - z(200) - mda*(z(3)*z(28)*z(47)+z(4)*z(28)*z(48)-z(45)*z(47)-z(48)*z(50)-z(1)*z(28)*z(45)-z(6)*z(28)*z(50));
z(206) = z(175) + z(72)*z(191) + z(73)*z(201);
z(210) = z(206) + z(72)*z(207) + z(73)*z(208);
z(212) = z(211)/z(210);
u1p = -z(212);
posa1p = z(45)*u1 + z(46)*u2 + z(47)*u3 + z(1)*z(28)*u3 - z(3)*z(28)*u1;
posa2p = z(4)*z(28)*u3 - z(48)*u1 - z(49)*u2 - z(50)*u3 - z(6)*z(28)*u1;
posa3p = z(28)*(z(7)*u3-z(9)*u1);
posb1p = z(45)*u1 + z(46)*u2 + z(47)*u3 + z(1)*(l3*u2+z(51)*u3) + z(2)*(l1*u3-l3*u1) - z(3)*(l1*u2-z(52)*u1);
posb2p = z(4)*(l3*u2+z(51)*u3) + z(5)*(l1*u3-l3*u1) - z(48)*u1 - z(49)*u2 - z(50)*u3 - z(6)*(l1*u2-z(52)*u1);
posb3p = z(7)*(l3*u2+z(51)*u3) + z(8)*(l1*u3-l3*u1) - z(9)*(l1*u2-z(52)*u1);

% Update derivative array prior to integration step
VARp(1) = e1p;
VARp(2) = e2p;
VARp(3) = e3p;
VARp(4) = e4p;
VARp(5) = posa1p;
VARp(6) = posa2p;
VARp(7) = posa3p;
VARp(8) = posb1p;
VARp(9) = posb2p;
VARp(10) = posb3p;
VARp(11) = u1p;

sys = VARp';



%===========================================================================
% mdlOutputs: Calculates and return the outputs
%===========================================================================
function Output = mdlOutputs(T,VAR,u)
global   a1 a2 a3 ida11 ida22 ida33 idb11 idb22 idb33 l1 l2 l3 mda mdb rada radb;
global   e1 e2 e3 e4 posa1 posa2 posa3 posb1 posb2 posb3 u1;
global   ke pe u2 u3 e1p e2p e3p e4p posa1p posa2p posa3p posb1p posb2p posb3p u1p;
global   DEGtoRAD RADtoDEG z;
global   TINITIAL TFINAL INTEGSTP PRINTINT ABSERR RELERR;

% Evaluate output quantities
ke = ida11*u1^2 + ida22*u2^2 + ida33*u3^2 + idb22*z(22)^2*u3^2 + idb33*z(23)^2*u3^2 + idb11*z(12)*u1*(z(12)*u1+2*z(18)*u2) + idb11*z(18)*u2*(z(18)*u2+2*z(21)*u3) + idb11*z(21)*u3*(z(21)*u3+2*z(12)*u1) + idb22*z(19)*u2*(z(19)*u2+2*z(22)*u3) + idb33*z(15)*u1*(z(15)*u1+2*z(23)*u3) + idb22*z(14)*u1*(z(14)*u1-2*z(19)*u2-2*z(22)*u3) + idb33*z(20)*u2*(z(20)*u2-2*z(15)*u1-2*z(23)*u3) - 0.5*mda*(2*z(3)*z(28)*u1*(z(45)*u1+z(46)*u2+z(47)*u3)+2*z(4)*z(28)*u3*(z(48)*u1+z(49)*u2+z(50)*u3)-z(28)^2*u1^2-z(28)^2*u3^2-(z(45)*u1+z(46)*u2+z(47)*u3)^2-(z(48)*u1+z(49)*u2+z(50)*u3)^2-2*z(1)*z(28)*u3*(z(45)*u1+z(46)*u2+z(47)*u3)-2*z(6)*z(28)*u1*(z(48)*u1+z(49)*u2+z(50)*u3)) - 0.5*mdb*(2*z(4)*(l3*u2+z(51)*u3)*(z(48)*u1+z(49)*u2+z(50)*u3)+2*z(3)*(l1*u2-z(52)*u1)*(z(45)*u1+z(46)*u2+z(47)*u3)+2*z(5)*(l1*u3-l3*u1)*(z(48)*u1+z(49)*u2+z(50)*u3)-(l3*u2+z(51)*u3)^2-(l1*u2-z(52)*u1)^2-(l1*u3-l3*u1)^2-(z(45)*u1+z(46)*u2+z(47)*u3)^2-(z(48)*u1+z(49)*u2+z(50)*u3)^2-2*z(1)*(l3*u2+z(51)*u3)*(z(45)*u1+z(46)*u2+z(47)*u3)-2*z(2)*(l1*u3-l3*u1)*(z(45)*u1+z(46)*u2+z(47)*u3)-2*z(6)*(l1*u2-z(52)*u1)*(z(48)*u1+z(49)*u2+z(50)*u3));
pe = -9.810000000000001*mda*posa3 - 9.810000000000001*mdb*posb3;

Output(1)=ke+pe;
Output(2)=((-l1*z(1)-l3*z(3)-z(33)*z(43)-z(2)*(l2-z(28)))*(l3*u2+z(51)*u3)*z(4)+(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*(l3*u2+z(51)*u3)*z(1)+(-l1*z(1)-l3*z(3)-z(33)*z(43)-z(2)*(l2-z(28)))*(l1*u3-l3*u1)*z(5)+(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*(l1*u3-l3*u1)*z(2)+(-l1*z(1)-l3*z(3)-z(33)*z(43)-z(2)*(l2-z(28)))*(z(52)*u1-l1*u2)*z(6)+(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*(z(52)*u1-l1*u2)*z(3)+(-l1*z(1)-l3*z(3)-z(33)*z(43)-z(2)*(l2-z(28)))*(z(53)*u2-z(54)*u1-z(55)*u3)*z(31)+(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*(z(53)*u2-z(54)*u1-z(55)*u3)*z(30)+(-l1*z(1)-l3*z(3)-z(33)*z(43)-z(2)*(l2-z(28)))*(z(56)*u1+z(57)*u2+z(58)*u3)*z(37)+(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*(z(56)*u1+z(57)*u2+z(58)*u3)*z(36)+(l1*z(4)+l3*z(6)+z(34)*z(43)+z(5)*(l2-z(28)))*(z(59)*u1+z(60)*u2+z(61)*u3)+(-l1*z(1)-l3*z(3)-z(33)*z(43)-z(2)*(l2-z(28)))*(z(62)*u1+z(63)*u2+z(64)*u3));
Output(3)=((l3*u2+z(51)*u3)*z(7)+(l1*u3-l3*u1)*z(8)+(z(52)*u1-l1*u2)*z(9)+(z(53)*u2-z(54)*u1-z(55)*u3)*z(32)+(z(56)*u1+z(57)*u2+z(58)*u3)*z(38));
FileIdentifier = fopen('all');
WriteOutput( 1,                 Output(1:1) );
WriteOutput( FileIdentifier(1), Output(1:1) );
WriteOutput( FileIdentifier(2), Output(2:2) );
WriteOutput( FileIdentifier(3), Output(3:3) );



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
fclose( FileIdentifier(2) );
fclose( FileIdentifier(3) );
fprintf( 1, '\n Output is in the files TwinDisks.i  (i=1,2,3)\n' );
fprintf( 1, ' The output quantities and associated files are listed in the file TwinDisks.dir\n' );
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
sizes.NumContStates  = 11;    % sys(1) is the number of continuous states
sizes.NumDiscStates  = 0;     % sys(2) is the number of discrete states
sizes.NumOutputs     = 3;     % sys(3) is the number of outputs
sizes.NumInputs      = 0;     % sys(4) is the number of inputs
sizes.DirFeedthrough = 1;     % sys(6) is 1, and allows for the output to be a function of the input
sizes.NumSampleTimes = 1;     % sys(7) is the number of samples times (the number of rows in ts)
sys = simsizes(sizes);        % Convert it to a sizes array
stateOrderingStrings = [];
timeSampling         = [0 0]; % m-by-2 matrix containing the sample times
OpenOutputFilesAndWriteHeadings
VAR = ReadUserInput
