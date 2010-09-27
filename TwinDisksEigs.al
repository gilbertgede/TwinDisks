degrees off
autoz on

Newtonian N
Bodies DiskA, DiskB
points ahat,bhat

motionvariables' u{3}'
variables e{4}',posa{3}',posb{3}',ke,pe,cahat{3}',cbhat{3}', q{3}'

constants l,rad,a,qq{3}

a = pi/2

mass diska = m
mass diskb = m
inertia diska,m*rad*rad/4,m*rad*rad/4,m*rad*rad/2
inertia diskb,m*rad*rad/4,m*rad*rad/4,m*rad*rad/2

w_diska_n> = u1*diska1> + u2*diska2> + u3*diska3>
w_diskb_diska> = 0>

dircos(N,DiskA,Euler,e1,e2,e3,e4)
kindiffs(N,DiskA,Euler,e1,e2,e3,e4)
dircos(DiskA,DiskB,body123,pi/2,0,0)


p_diskao_ahat> = rad * unitvec(dot(diska3>,n3>)*diska3>-n3>)
p_diskbo_bhat> = rad * unitvec(dot(diskb3>,n3>)*diskb3>-n3>)
p_diskao_diskbo> = -l*rad * diska1>

v_ahat_n> = 0>
v_diskao_n> = v_ahat_n> + cross(w_diska_n>,p_ahat_diskao>)
v_diskbo_n> = v_diskao_n> + cross(w_diska_n>,p_diskao_diskbo>)
v_bhat_n> = v_diskbo_n> + cross(w_diska_n>,p_diskbo_bhat>)


dependent[1] = dot(v_bhat_n>,cross(unitvec(p_ahat_bhat>),n3>))
dependent[2] = dot(v_bhat_n>,n3>)

constrain(dependent[u2,u3])

gravity(-9.81*n3>)

zero = fr() + frstar()

solve(zero,u1')


a11 = D(u1',u1)
a12 = D(u1',e1)
a13 = D(u1',e2)
a14 = D(u1',e3)
a15 = D(u1',e4)
a21 = D(e1',u1)
a22 = D(e1',e1)
a23 = D(e1',e2)
a24 = D(e1',e3)
a25 = D(e1',e4)
a31 = D(e2',u1)
a32 = D(e2',e1)
a33 = D(e2',e2)
a34 = D(e2',e3)
a35 = D(e2',e4)
a41 = D(e3',u1)
a42 = D(e3',e1)
a43 = D(e3',e2)
a44 = D(e3',e3)
a45 = D(e3',e4)
a51 = D(e4',u1)
a52 = D(e4',e1)
a53 = D(e4',e2)
a54 = D(e4',e3)
a55 = D(e4',e4)



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
%qq2 = asin(1/(1+1))
%qq3 = 0

q1' = dot(w_diska_n>,diska1>)
q2' = dot(w_diska_n>,diska2>)
q3' = dot(w_diska_n>,diska3>)


%inputVector = [dot(p_ahat_diskao>,n1>), dot(p_ahat_diskao>,n2>), &
%	dot(p_ahat_diskao>,n3>), dot(p_diskao_diskbo>,n1>), &
%	dot(p_diskao_diskbo>,n2>), dot(p_diskao_diskbo>,n3>), &
%	0, 0, 0, dot(p_ahat_bhat>,n1>), dot(p_ahat_bhat>,n2>), 0]

input rad = .1, m = 2
%input i11 = input(rad)^2*input(m)/4
%input i22 = input(i11),i33 = input(i11)*2
input l = 1
input e4 = cos(qq1/2)*cos(qq2/2)*cos(qq3/2)+sin(qq1/2)*sin(qq2/2)*sin(qq3/2)
input e1 = sin(qq1/2)*cos(qq2/2)*cos(qq3/2)-cos(qq1/2)*sin(qq2/2)*sin(qq3/2)
input e2 = cos(qq1/2)*sin(qq2/2)*cos(qq3/2)+sin(qq1/2)*cos(qq2/2)*sin(qq3/2)
input e3 = cos(qq1/2)*cos(qq2/2)*sin(qq3/2)-sin(qq1/2)*sin(qq2/2)*cos(qq3/2)
input u1 = 1

inputVecto = [dot(p_ahat_diskao>,n1>), dot(p_ahat_diskao>,n2>), &
	dot(p_ahat_diskao>,n3>), & 
	dot(p_diskao_diskbo>,n1>) + dot(p_ahat_diskao>,n1>), &
	dot(p_diskao_diskbo>,n2>) + dot(p_ahat_diskao>,n2>), &
	dot(p_diskao_diskbo>,n3>) + dot(p_ahat_diskao>,n3>), &
	0, 0, 0, dot(p_ahat_bhat>,n1>), dot(p_ahat_bhat>,n2>), 0]

explicit(inputVecto)

inputVector = replace(inputVecto,e1=input(e1),e2=input(e2),e3=input(e3), &
	e4=input(e4),u1=input(u1),a=input(a), &
	l=input(l),rad=input(rad))

input posa1 = inputVector[1], posa2 = inputVector[2], posa3 = inputVector[3]
input posb1 = inputVector[4], posb2 = inputVector[5], posb3 = inputVector[6]
input cahat1 = 0, cahat2 = 0, cahat3 = 0
input cbhat1 = inputVector[10], cbhat2 = inputVector[11], cbhat3 = 0


output t,ke,pe,ke+pe, dot(v_bhat_n>,cross(p_ahat_bhat>,n3>)), dot(v_bhat_n>,n3>), &
	e1,e2,e3,e4,u1,cahat1,cahat2,cahat3,cbhat1,cbhat2,cbhat3, &
	dot(w_diska_n>,diska1>), dot(w_diska_n>,diska2>), dot(w_diska_n>,diska3>), &
	a11,a12,a13,a14,a15,a21,a22,a23,a24,a25,a31,a32,a33,a34,a35, &
	a41,a42,a43,a44,a45,a51,a52,a53,a54,a55, q1,q2,q3


code dynamics() TwinDisksEig.m
exit
