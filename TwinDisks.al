degrees off
autoz on

Newtonian N
Bodies DiskA, DiskB
points ahat,bhat

motionvariables' u{3}'
variables e{4}',posa{3}',posb{3}',ke,pe,cahat{3}',cbhat{3}'

constants l{3},rada,radb,a{3},q{3}

mass diska = mda
mass diskb = mdb
inertia diska,ida11,ida22,ida33
inertia diskb,idb11,idb22,idb33

w_diska_n> = u1*diska1> + u2*diska2> + u3*diska3>
w_diskb_diska> = 0>

dircos(N,DiskA,Euler,e1,e2,e3,e4)
kindiffs(N,DiskA,Euler,e1,e2,e3,e4)
dircos(DiskA,DiskB,body123,a1,a2,a3)


p_diskao_ahat> = rada * unitvec(dot(diska3>,n3>)*diska3>-n3>)
p_diskbo_bhat> = radb * unitvec(dot(diskb3>,n3>)*diskb3>-n3>)
p_diskao_diskbo> = l1 * diska1> + l2 * diska2> + l3 * diska3>

v_ahat_n> = 0>
v_diskao_n> = v_ahat_n> + cross(w_diska_n>,p_ahat_diskao>)
v_diskbo_n> = v_diskao_n> + cross(w_diska_n>,p_diskao_diskbo>)
v_bhat_n> = v_diskbo_n> + cross(w_diska_n>,p_diskbo_bhat>)

dependent[1] = dot(v_bhat_n>,cross(unitvec(p_ahat_bhat>),n3>))
dependent[2] = dot(v_bhat_n>,n3>)

constrain(dependent[u2,u3])

gravity(-9.81*n3>)

zero = fr() + frstar()

solve(zero,[u1'])


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


ke = mda/2*dot(v_diskao_n>,v_diskao_n>)+mdb/2*dot(v_diskbo_n>,v_diskbo_n>) + &
	dot(w_diska_n>,dot(I_diska_diskao>>,w_diska_n>))/2 + &
	dot(w_diskb_n>,dot(I_diskb_diskbo>>,w_diskb_n>))/2
pe = 9.81*mda*posa3 + 9.81*mdb*posb3

q1 = pi/4
q2 = 0
q3 = 0



T_DA = [N_diska[1,1],N_diska[2,1],N_diska[3,1],0.0, &
	N_diska[1,2],N_diska[2,2],N_diska[3,2],0.0, &
	N_diska[1,3],N_diska[2,3],N_diska[3,3],0.0, &
	posa1,posa2,posa3,1.0]

T_DB = [N_diskb[1,1],N_diskb[2,1],N_diskb[3,1],0.0, &
	N_diskb[1,2],N_diskb[2,2],N_diskb[3,2],0.0, &
	N_diskb[1,3],N_diskb[2,3],N_diskb[3,3],0.0, &
	posb1,posb2,posb3,1.0]

%inputVector = [dot(p_ahat_diskao>,n1>), dot(p_ahat_diskao>,n2>), &
%	dot(p_ahat_diskao>,n3>), dot(p_diskao_diskbo>,n1>), &
%	dot(p_diskao_diskbo>,n2>), dot(p_diskao_diskbo>,n3>), &
%	0, 0, 0, dot(p_ahat_bhat>,n1>), dot(p_ahat_bhat>,n2>), 0]

input rada = .1, radb = .1, mda = 2, mdb = 2 
input idb11 = .005, idb22 = .005, idb33 = .01
input ida11 = .005, ida22 = .005, ida33 = .01
input l1 = -.1, l2 = 0, l3 = 0
input a1 = pi/2, a2 = 0, a3 = 0
input e4 = cos(q1/2)*cos(q2/2)*cos(q3/2)+sin(q1/2)*sin(q2/2)*sin(q3/2)
input e1 = sin(q1/2)*cos(q2/2)*cos(q3/2)-cos(q1/2)*sin(q2/2)*sin(q3/2)
input e2 = cos(q1/2)*sin(q2/2)*cos(q3/2)+sin(q1/2)*cos(q2/2)*sin(q3/2)
input e3 = cos(q1/2)*cos(q2/2)*sin(q3/2)-sin(q1/2)*sin(q2/2)*cos(q3/2)
input u1 = 2

inputVecto = [dot(p_ahat_diskao>,n1>), dot(p_ahat_diskao>,n2>), &
	dot(p_ahat_diskao>,n3>), dot(p_diskao_diskbo>,n1>), &
	dot(p_diskao_diskbo>,n2>), dot(p_diskao_diskbo>,n3>), &
	0, 0, 0, dot(p_ahat_bhat>,n1>), dot(p_ahat_bhat>,n2>), 0]

explicit(inputVecto)

inputVector = replace(inputVecto,e1=input(e1),e2=input(e2),e3=input(e3), &
	e4=input(e4),u1=input(u1),a1=input(a1),a2=input(a2),a3=input(a3), &
	l1=input(l1),l2=input(l2),l3=input(l3),rada=input(rada), &
	radb=input(radb))

%input posa1 = dot(p_ahat_diska>,n1>), posa1 = dot(p_ahat_diska>,n2>), &
%	posa1 = dot(p_ahat_diska>,n3>)
%input posb1 = dot(p_diskao_diskbo>,n1>), posb2 = dot(p_diskao_diskbo>,n2>), &
%	posb3 = dot(p_diskao_diskbo>,n3>)
%input cahat1 = 0, cahat2 = 0, cahat3 = 0, cbhat1 = dot(p_ahat_bhat>,n1>), &
%	cbhat2 = dot(p_ahat_bhat>,n2>), cbhat3 = 0
input posa1 = inputVector[1], posa2 = inputVector[2], posa3 = inputVector[3]
input posb1 = inputVector[4], posb2 = inputVector[5], posb3 = inputVector[6]
input cahat1 = 0, cahat2 = 0, cahat3 = 0
input cbhat1 = inputVector[10], cbhat2 = inputVector[11], cbhat3 = 0



output ke+pe, dot(v_bhat_n>,cross(p_ahat_bhat>,n3>)), dot(v_bhat_n>,n3>), &
	e1,e2,e3,e4,u1,cahat1,cahat2,cahat3,cbhat1,cbhat2,cbhat3
encode t_da,t_db


code dynamics() TwinDisks.m
exit
