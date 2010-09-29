degrees off
autoz on

Newtonian N
Bodies DiskA, DiskB
points ahat,bhat

motionvariables' u', aforcespeed{3}', bforcespeed{3}'
variables e{4}',posa{3}',posb{3}',ke,pe,cahat{3}',cbhat{3}', q{3}'
variables u{3}
variables aforce{3},bforce{3}

constants l,rad,a,qq{3}, gamma

l = sqrt(2) * rad * gamma
a = pi/2

mass diska = m
mass diskb = m
inertia diska,m*rad*rad/4,m*rad*rad/4,m*rad*rad/2
inertia diskb,m*rad*rad/4,m*rad*rad/4,m*rad*rad/2

dircos(N,DiskA,Euler,e1,e2,e3,e4)
dircos(DiskA,DiskB,body123,pi/2,0,0)

%gamma is l/sqrt(2)/r
p_diskao_ahat> = rad * unitvec(dot(diska3>,n3>)*diska3>-n3>)
p_diskbo_bhat> = rad * unitvec(dot(diskb3>,n3>)*diskb3>-n3>)
p_diskao_diskbo> = -l * diska1>

w_diska_n> = u * unitvec(p_ahat_bhat>)
w_diskb_diska> = 0>

u1 = dot(w_diska_n>,diska1>)
u2 = dot(w_diska_n>,diska2>)
u3 = dot(w_diska_n>,diska3>)

kindiffs(N,DiskA,Euler,e1,e2,e3,e4)


v_ahat_n> = aforcespeed1 * diska1> + aforcespeed2 * diska2> + aforcespeed3 * diska3>
v_diskao_n> = v_ahat_n> + cross(w_diska_n>,p_ahat_diskao>)
v_bhat_n> = bforcespeed1 * diskb1> + bforcespeed2 * diskb2> + bforcespeed3 * diskb3>
v_diskbo_n> = v_bhat_n> + cross(w_diskb_n>,p_bhat_diskbo>)


gravity(-9.81*n3>)
force_ahat> = aforce1 * n1> + aforce2 * n2> + aforce3 * n3>
force_bhat> = bforce1 * n1> + bforce2 * n2> + bforce3 * n3>


AUXILIARY[1] = aforcespeed1
AUXILIARY[2] = aforcespeed2
AUXILIARY[3] = aforcespeed3
AUXILIARY[4] = bforcespeed1
AUXILIARY[5] = bforcespeed2
AUXILIARY[6] = bforcespeed3

zee_not = [aforce1,aforce2,aforce3,bforce1,bforce2,bforce3]

constrain(AUXILIARY[aforcespeed1,aforcespeed2,aforcespeed3,bforcespeed1,bforcespeed2,bforcespeed3])


zero = fr() + frstar()

Kane(aforce1,aforce2,aforce3,bforce1,bforce2,bforce3)

solve(zero,u')


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

q1' = dot(w_diska_n>,diska1>)
q2' = dot(w_diska_n>,diska2>)
q3' = dot(w_diska_n>,diska3>)



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
	0, 0, 0, dot(p_ahat_bhat>,n1>), dot(p_ahat_bhat>,n2>), 0]

explicit(inputVecto)

inputVector = replace(inputVecto,e1=input(e1),e2=input(e2),e3=input(e3), &
	e4=input(e4),u1=input(u1),a=input(a), &
	gamma=input(gamma),rad=input(rad))

input posa1 = inputVector[1], posa2 = inputVector[2], posa3 = inputVector[3]
input posb1 = inputVector[4], posb2 = inputVector[5], posb3 = inputVector[6]
input cahat1 = 0, cahat2 = 0, cahat3 = 0
input cbhat1 = inputVector[10], cbhat2 = inputVector[11], cbhat3 = 0


output t,ke,pe,ke+pe, dot(v_bhat_n>,cross(p_ahat_bhat>,n3>)), dot(v_bhat_n>,n3>), &
	e1,e2,e3,e4,u,cahat1,cahat2,cahat3,cbhat1,cbhat2,cbhat3, &
	dot(w_diska_n>,diska1>), dot(w_diska_n>,diska2>), dot(w_diska_n>,diska3>), &
	q1,q2,q3,aforce1,aforce2,aforce3,bforce1,bforce2,bforce3


code dynamics() TwinDisksConstraintForces.m
exit



