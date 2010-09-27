newtonian n
bodies s
frames da, db
frames a, b

constants m, r, l, g, alpha
constants k

alpha = pi/2

variables q{5}'
variables w'
points ca, cb

inertia s(da), Ixx, Iyy, Izz, Ixy, 0, 0

autoz on
simprot(n, a, 3, q1)
simprot(a, b, 1, q2)
simprot(b, da, 2, q3)
simprot(da, db, 3, alpha)

p_no_ca> = q4*n1> + q5*n2>
p_ca_dao> = express(-r*b3>, da)
p_dao_dbo> = -l*da3>
p_dao_so> = -k*da3>
p_dbo_cb> = express(r*unitvec(a3> - dot(a3>, db2>)*db2>), da)

zee_not = [w, q1', q2', q3']

w_da_n> = w*unitvec(p_ca_cb>)
w_db_da> = 0>

w1 = dot(w_da_n>, da1>)
w2 = dot(w_da_n>, da2>)
w3 = dot(w_da_n>, da3>)

q1' = (-w1*sin(q3) + w3*cos(q3))/cos(q2)
q2' = w1*cos(q3) + w3*sin(q3)
autoz off
solve(dt(dot(p_ca_cb>, a3>)), q3')

zero> = q4'*n1> + q5'*n2> - cross(q3'*b2>, p_ca_dao>)
wr[1] = dot(zero>, n1>)
wr[2] = dot(zero>, n2>)
solve(wr, [q4', q5'])
autoz on

v_so_n> = cross(w_da_n>, p_ca_so>)
zee_not := [w']

alf_da_n> = dt(w_da_n>, da)
a_so_n> = dt(v_so_n>, da) + cross(w_da_n>, v_so_n>)

fr_1 = dot(g*m*a3>, coef(v_so_n>, w))
fr_star_1 = -dot(m*a_so_n>, coef(v_so_n>, w)) &
            -dot(dot(alf_da_n>, I_S_SO>>) + cross(w_da_n>, dot(I_S_SO>>, w_da_n>)), coef(w_da_n>, w))

solve(rhs(fr_1) + rhs(fr_star_1), w')


% Extraneous outputs
%ke = m*dot(v_so_n>, v_so_n>)/2.0 + dot(w_da_n>, dot(I_S_SO>>, w_da_n>))/2.0
%pe = -m*g*dot(p_ca_so>, a3>)
%te = ke + pe

%no_cb[1] = dot(p_no_cb>, n1>)
	%no_cb[2] = dot(p_no_cb>, n2>)
%no_cb[3] = dot(p_no_cb>, a3>)

unitsystem  kg,m,s
input r = 0.1 m, l = .1 m, k = 0.0 m
input m = 0.1 kg, g = 9.81 m/s^2
input Ixx = 0.0, Iyy = 0.0, Izz = 0.0, Ixy = 0.0
input q1 = 0.0 rad, q2 = 0.0 rad, q3 = 0.0, q4 = 0.0 m, q5 = 0.0 m
input w = 0.0 rad/s

%output q1 rad, q2 rad, q3 rad, q4 m, q5 m, q1' rad/s, q2' rad/s, q3' rad/s
%output q4' m/s, q5' m/s, w1 rad/s, w2 rad/s, w3 rad/s, ke kg*m^2/s/s, pe kg*m^2/s/s, te kg*m^2/s/s
%encode no_cb

code dynamics() TwinDisksLuke.m
