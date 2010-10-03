degrees off
autoz on

Newtonian N
Bodies DiskA, DiskB
points ahat,bhat
points mc

motionvariables' u'
variables e{4}',posa{3}',posb{3}',ke,pe,cahat{3}',cbhat{3}', q{3}', u{6}
variables aforce{3},bforce{3}


constants l,rad,a,qq{3}, gamma, InertIn, InertOut

mass diska = m
mass diskb = m
InertIn = m*rad*rad/4
InertOut = m*rad*rad/2
l = sqrt(2) * rad * gamma
a = pi/2
inertia diska,inertin,inertin,inertout
inertia diskb,inertin,inertin,inertout


dircos(N,DiskA,Euler,e1,e2,e3,e4)
dircos(DiskA,DiskB,body123,pi/2,0,0)


%gamma is l/sqrt(2)/r
p_diskao_ahat> = rad * unitvec(dot(diska3>,n3>)*diska3>-n3>)
p_diskbo_bhat> = rad * unitvec(dot(diskb3>,n3>)*diskb3>-n3>)
p_diskao_diskbo> = -l * diska1>
p_diskao_mc> = -l/2 * diska1>

cl1> = unitvec(p_ahat_bhat>)
cl2> = cross(n3>,cl1>)
cl3> = n3>


w_diska_n> = u * unitvec(p_ahat_bhat>)
w_diskb_diska> = 0>


kindiffs(N,DiskA,Euler,e1,e2,e3,e4)


v_ahat_n> = 0>
v_diskao_n> = v_ahat_n> + cross(w_diska_n>,p_ahat_diskao>)
v_diskbo_n> = v_diskao_n> + cross(w_diska_n>,p_diskao_diskbo>)
v_bhat_n> = 0>

u1 = dot(w_diska_n>,diska1>)
u2 = dot(w_diska_n>,diska2>)
u3 = dot(w_diska_n>,diska3>)
u4 = dot(v_diskao_n>, n1>)
u5 = dot(v_diskao_n>, n2>)
u6 = dot(v_diskao_n>, n3>)

gravity(-9.81*n3>)


v_mc_n> = v_diskao_n> + cross(w_diska_n>,p_diskao_mc>)
a_mc_n> = Dt(v_mc_n>,n)

TI11 = 2*inertin + m*l*l/2
TI22 = inertin+inertout + m*l*l/2
TI33 = inertin+inertout + m*l*l/2

express(alf_diska_n>,diska)
express(w_diska_n>,diska)
Jalpha> = dot(alf_diska_n>,diska1>)*TI11*diska1> + &
	dot(alf_diska_n>,diska2>)*TI22*diska2> + &
	dot(alf_diska_n>,diska3>)*TI33*diska3>
wcrossjw> = cross(w_diska_n>,u1*TI11*diska1>+u2*TI22*diska2> + &
	u3*TI33*diska3>)

NEforces> = 2 * m * a_mc_n>
NEtorques> = Jalpha> + wcrossjw>
fictaforce> = aforce1*cl1> + aforce2*cl2> + aforce3*cl3>
fictbforce> = bforce1*cl1> + bforce2*cl2> + bforce3*cl3>
ficttorques> = cross(p_mc_ahat>,fictaforce>)+cross(p_mc_bhat>,fictbforce>)

totforces> = neforces> - fictaforce> -fictbforce> + 9.81*2*m*n3>

solvemat[1] = dot(totforces>,cl1>)
solvemat[2] = dot(totforces>,cl2>)
solvemat[3] = dot(totforces>,cl3>)
solvemat[4] = dot(ficttorques> - netorques>,diska1>)
solvemat[5] = dot(ficttorques> - netorques>,diska2>)
solvemat[6] = dot(ficttorques> - netorques>,diska3>)
solvevec = [aforce1,aforce2,aforce3,bforce1,bforce2,bforce3]

solve(solvemat,solvevec)


zero = fr() + frstar()

solve(zero,u')
%'



posa1' = dot(v_diskao_n>,n1>)
posa2' = dot(v_diskao_n>,n2>)
posa3' = dot(v_diskao_n>,n3>)
posb1' = dot(v_diskbo_n>,n1>)
posb2' = dot(v_diskbo_n>,n2>)
posb3' = dot(v_diskbo_n>,n3>)

cahat1' = dot((v_diskao_n>+cross(w_diska_n>-u3*diska3>,p_diskao_ahat>)) ,n1>)
cahat2' = dot((v_diskao_n>+cross(w_diska_n>-u3*diska3>,p_diskao_ahat>)) ,n2>)
cahat3' = 0
cbhat1' = dot((v_diskbo_n>+cross(w_diskb_n>-dot(w_diskb_n>,diskb3>)*diskb3>,p_diskbo_bhat>)) ,n1>)
cbhat2' = dot((v_diskbo_n>+cross(w_diskb_n>-dot(w_diskb_n>,diskb3>)*diskb3>,p_diskbo_bhat>)) ,n2>)
cbhat3' = 0


ke = m/2*dot(v_diskao_n>,v_diskao_n>)+m/2*dot(v_diskbo_n>,v_diskbo_n>) + &
	dot(w_diska_n>,dot(I_diska_diskao>>,w_diska_n>))/2 + &
	dot(w_diskb_n>,dot(I_diskb_diskbo>>,w_diskb_n>))/2
pe = 9.81*m*posa3 + 9.81*m*posb3

qq1 = pi/4
qq2 = 0
qq3 = 0

%qq1 = 0
%qq2 = asin(rad/(rad+l))
%qq3 = 0

q1' = u1
q2' = u2
q3' = u3
%'

input rad = .1, m = 2
input gamma = 1
input e4 = cos(qq1/2)*cos(qq2/2)*cos(qq3/2)+sin(qq1/2)*sin(qq2/2)*sin(qq3/2)
input e1 = sin(qq1/2)*cos(qq2/2)*cos(qq3/2)-cos(qq1/2)*sin(qq2/2)*sin(qq3/2)
input e2 = cos(qq1/2)*sin(qq2/2)*cos(qq3/2)+sin(qq1/2)*cos(qq2/2)*sin(qq3/2)
input e3 = cos(qq1/2)*cos(qq2/2)*sin(qq3/2)-sin(qq1/2)*sin(qq2/2)*cos(qq3/2)
input u = 1

inputVecto = [dot(p_ahat_diskao>,n1>), dot(p_ahat_diskao>,n2>), &
	dot(p_ahat_diskao>,n3>), & 
	dot(p_diskao_diskbo>,n1>) + dot(p_ahat_diskao>,n1>), &
	dot(p_diskao_diskbo>,n2>) + dot(p_ahat_diskao>,n2>), &
	dot(p_diskao_diskbo>,n3>) + dot(p_ahat_diskao>,n3>), &
	0, 0, 0, dot(p_ahat_bhat>,n1>), dot(p_ahat_bhat>,n2>), 0, &
	dot(v_diskao_n>,n1>),dot(v_diskao_n>,n2>), &
	dot(v_diskao_n>,n3>),u1,u2,u3]

explicit(inputVecto)

inputVector = replace(inputVecto,e1=input(e1),e2=input(e2),e3=input(e3), &
	e4=input(e4),u=input(u),a=input(a), &
	gamma=input(gamma),rad=input(rad))

input posa1 = inputVector[1], posa2 = inputVector[2], posa3 = inputVector[3]
input posb1 = inputVector[4], posb2 = inputVector[5], posb3 = inputVector[6]
input cahat1 = 0, cahat2 = 0, cahat3 = 0
input cbhat1 = inputVector[10], cbhat2 = inputVector[11], cbhat3 = 0


output t,ke,pe,ke+pe,e1,e2,e3,e4,u, &
	cahat1,cahat2,cahat3,cbhat1,cbhat2,cbhat3, &
	u1,u2,u3,u4,u5,u6, q1,q2,q3, &
	aforce1,aforce2,aforce3,bforce1,bforce2,bforce3, &
	dot(unitvec(p_ahat_bhat>),a_mc_n>)

code dynamics() TwinDisksConstraintForcesExtra.m
exit



