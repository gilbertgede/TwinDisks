degrees off
autoz on

Newtonian N
Bodies DiskA, DiskB
points ahat,bhat

motionvariables' u{3}'
variables e{4}',posa{3}',posb{3}',ang{3},ke,pe

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


p_diskao_ahat> = rada * unitvec(dot(diska2>,n3>)*diska2>-n3>)
p_diskbo_bhat> = radb * unitvec(dot(diskb2>,n3>)*diskb2>-n3>)
p_diskao_diskbo> = l1 * diska1> + l2 * diska2> + l3 * diska3>

v_ahat_n> = 0>
v_diskao_n> = v_ahat_n> + cross(w_diska_n>,-p_diskao_ahat>)
v_diskbo_n> = v_diskao_n> + cross(w_diska_n>,p_diskao_diskbo>)
v_bhat_n> = v_diskbo_n> + cross(w_diska_n>,p_diskbo_bhat>)

dependent[1] = dot(v_bhat_n>,cross(p_ahat_bhat>,n3>))
dependent[2] = dot(v_bhat_n>,n3>)

constrain(dependent[u2,u3])

zero = fr() + frstar()

solve(zero,[u1'])

gravity(9.81*n3>)

posa1' = dot(v_diskao_n>,n1>)
posa2' = dot(v_diskao_n>,n2>)
posa3' = dot(v_diskao_n>,n3>)
posb1' = dot(v_diskbo_n>,n1>)
posb2' = dot(v_diskbo_n>,n2>)
posb3' = dot(v_diskbo_n>,n3>)

ke = mda/2*dot(v_diskao_n>,v_diskao_n>)+mdb/2*dot(v_diskbo_n>,v_diskbo_n>) &
	+dot(w_diska_n>,dot(I_diska_diskao>>,w_diska_n>)) &
	+dot(w_diskb_n>,dot(I_diskb_diskbo>>,w_diskb_n>))
pe = -9.81*mda*posa3 - 9.81*mdb*posb3

q1 = 0
q2 = pi/4
q3 = pi/2

%ang1 = atan2(2*(e1*e2+e3*e4),1-2*(e2^2+e3^2))
%ang2 = asin(2*(e1*e3-e4*e2))
%ang3 = atan2(2*(e1*e4+e2*e3),1-(e2^2+e3^2))

input rada = .1, radb = .1, ida11 = .05, ida22 = .05, ida33 = .05
input mda = .1, mdb = .1, idb11 = 0.05, idb22 = .05, idb33 = .05
input l1 = .1, l2 = 0, l3 = 0, a1 = pi/2, a2 = 0, a3 = 0
input e1 = cos(q1/2)*cos(q2/2)*cos(q3/2)+sin(q1/2)*sin(q2/2)*sin(q3/2)
input e2 = sin(q1/2)*cos(q2/2)*cos(q3/2)-cos(q1/2)*sin(q2/2)*sin(q3/2)
input e3 = cos(q1/2)*sin(q2/2)*cos(q3/2)+sin(q1/2)*cos(q2/2)*sin(q3/2)
input e4 = cos(q1/2)*cos(q2/2)*sin(q3/2)-sin(q1/2)*sin(q2/2)*cos(q3/2)
input u1 = 1

output ke+pe
output dot(v_bhat_n>,cross(p_ahat_bhat>,n3>))
output dot(v_bhat_n>,n3>)
%output ang1,ang2,ang3



code dynamics() TwinDisks.m
exit
