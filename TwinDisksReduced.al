degrees off
autoz on

Newtonian N
Bodies DiskA, DiskB
points ahat,bhat

motionvariables' u'
variables e{4}'
%'
constants l,rad,a,qq{3}, gamma, grav

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

w_diska_n> = u * p_ahat_bhat>
w_diskb_diska> = 0>

u1 = dot(w_diska_n>,diska1>)
u2 = dot(w_diska_n>,diska2>)
u3 = dot(w_diska_n>,diska3>)

kindiffs(N,DiskA,Euler,e1,e2,e3,e4)

v_ahat_n> = 0>
v_diskao_n> = v_ahat_n> + cross(w_diska_n>,p_ahat_diskao>)
v_diskbo_n> = v_diskao_n> + cross(w_diska_n>,p_diskao_diskbo>)
v_bhat_n> = 0>


gravity(-grav*n3>)

zero = fr() + frstar()


solve(zero,u')


qq1 = pi/4
qq2 = 0
qq3 = 0

%qq1 = 0
%qq2 = asin(1/(1+1))
%qq3 = 0

%'
input rad = .1, m = 2
input gamma = 1
input e4 = cos(qq1/2)*cos(qq2/2)*cos(qq3/2)+sin(qq1/2)*sin(qq2/2)*sin(qq3/2)
input e1 = sin(qq1/2)*cos(qq2/2)*cos(qq3/2)-cos(qq1/2)*sin(qq2/2)*sin(qq3/2)
input e2 = cos(qq1/2)*sin(qq2/2)*cos(qq3/2)+sin(qq1/2)*cos(qq2/2)*sin(qq3/2)
input e3 = cos(qq1/2)*cos(qq2/2)*sin(qq3/2)-sin(qq1/2)*sin(qq2/2)*cos(qq3/2)
input u = 1

output e1,e2,e3,e4,u

code dynamics() TwinDisksReduced.m

Explicit(u')
Explicit(e1')
Explicit(e2')
Explicit(e3')
Explicit(e4')

save TwinDisksReduced.all

exit
