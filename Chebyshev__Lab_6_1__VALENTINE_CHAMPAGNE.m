%Chebyshev-Parallel-Motion Mechanism Lab 6-1
%Valentine Champagne

 
% Link Length 
u=3; %base unit
a=(13/8)*u; %crank 
b=(5)*u;%connecting rod in cranker slider
c=2.5*u;%connects both systems on point B to E
g=5*u; % connects points CG and FD
f=2*u; %connects F and G, with point H in middle
m=(4)*u; %height of system
e1=(9)*u; %length from Ox to Dx, full frame length
e2=4*u;  % length of C to D
th=4; %table height

cla 
% Origin, Aspect Ratio & Plot Ranges
O = [0, 0]; % Origin
D = [e1, -m]; % Point D
C = [e1-e2,-m]; %Point C
axis(gca, 'equal'); % Aspect Ratio
axis([-(a+2) (a+b+e1) -(m+5) (b+a)]); % Plot Ranges

% Motor Speed & Duration
k = 8; % Speed
z = 250; % Duration

% Draw Trajectory of Point A
A_traj = viscircles([0 0], a, 'LineStyle', '--','LineWidth', 0.1);

% Add Text for Title, C,D and Orgin
title_str = 'Chebyshev-Parallel-Motion Mechanism';
title_text = text(-3,a+9, title_str, 'FontSize', 16);

CC_str = 'C';
C_text = text(C(1),C(2)-0.75, CC_str, 'FontSize', 10);
 
DD_str = 'D';
D_text = text(D(1),D(2)-0.75, DD_str, 'FontSize', 10);
 
OO_str = 'O';
O_text = text(O(1),O(2)-0.75, OO_str, 'FontSize', 10);

%create title strings for texts
AA_str = 'A';
BB_str = 'B';
EE_str = 'E';
FF_str = 'F';
GG_str = 'G';
HH_str = 'H';

%Draw circles for orginin, C and D
O_circle = viscircles(O, 0.1);
C_circle = viscircles(C, 0.1);
D_circle = viscircles(D, 0.1);


%Lines 
platform=line([O(1) D(1)], [C(2) D(2)]);
%Xaxis = line([O(1) D(1)], [O(2) O(2)],'Color','#77AC30','LineStyle','--');
%height = line([O(1) O(1)],[O(2) C(2)],'Color','#0072BD');
%PLine = line ([O(1) D(1)],[th th],'Color','#EDB120','LineStyle','--');

% Motor Angle Loop
for t = 1:z
 % Calculate Angle Theta & Alpha in Radians
 theta = k * t/100;
 beta = asin(a*sin(theta)/b);
 
 % Calculate Coordinates of Point A, B & C
 A = a*[cos(theta) sin(theta)];
 B = [(a*cos(theta)+b*cos(beta)) 0];
 
 % Calculate omega for point E
BCy=B(2)-C(2); %calculate Y in BC
BC=sqrt(((C(1)-B(1))^2)+((C(2)-B(2))^2));% calculate BC, distance formula
if B(1)>C(1)
     BCx=0;
     omega3=acos(m/BC); %calculate part of omega 
 elseif C(1)==B(1)
        BCx=m;
 else
    BCx=C(1)-B(1);
    omega3=0;%calculate tangent of BC
 end
 omega1=atan(BCy/BCx);%calculate tangent of BC
 omega2=acos((BC^2)/(2*c*BC)); %calculate third part of omega
 omega=omega1+omega2+omega3; % omega
 gamma=pi-(omega);%calculate gamma
 
 E=[(-c*cos(omega))+C(1) (c*sin(omega))+C(2)];
 F=[(g*cos(gamma))+C(1) (g*sin(gamma))+C(2)];
 
 %Calculate alpha for point G
 FD=sqrt(((D(1)-F(1))^2)+((D(2)-F(2))^2));
 alpha=(asin((g*sin(gamma))/FD))-(acos(((g^2)+(FD^2)-(f^2))/(2*g*FD)));
 alpha=(pi-alpha);
 G=[(g*cos(alpha))+D(1) (g*sin(alpha))+D(2)]; 

 %Calculate point H
 H=[(F(1)+G(1))/2  (F(2)+G(2))/2];
 
 %calculating table angles
 T1=[B(1) th];
 T2=[H(1) th];
 
 % Draw Crank,rods, and table
 crank = line([O(1) A(1)], [O(1) A(2)]); 
 rod = line([A(1) B(1)], [A(2) B(2)]);
 rodc=line([B(1) E(1)], [B(2) E(2)]);
 rodg1=line([C(1) F(1)], [C(2) F(2)]);
 rodg2=line([D(1) G(1)], [D(2) G(2)]);
 rodf=line([F(1) G(1)], [F(2) G(2)]);
 tableL1=line([B(1) T1(1)], [B(2) T1(2)]);
 tableL2=line([H(1) T2(1)], [H(2) T2(2)]);
 top=line([T1(1) T2(1)], [T1(2) T2(2)]);
 
 % Draw Circle O, A, B, C, D, E, F, G and H
 A_circle = viscircles(A, 0.1);
 B_circle = viscircles(B, 0.1);
 E_circle = viscircles(E, 0.1);
 F_circle = viscircles(F, 0.1);
 G_circle = viscircles(G, 0.1);
 H_circle = viscircles(H, 0.1);

% Add Text for moving points
 Ax_str = num2str(A(1),'%+.3f');
 Ay_str = num2str(A(2),'%+.3f');
 A_str = ['A = ','(',Ax_str,', ',Ay_str,')'];
 A_coordinates = text(a-5,a+5.5, A_str, 'FontSize', 10);
 
 Bx_str = num2str(B(1),'%+.3f');
 By_str = num2str(B(2),'%+.3f');
 B_str = ['B = ','(',Bx_str,', ',By_str,')'];
 B_coordinates = text(a-5,a+4, B_str, 'FontSize', 10);
 
 Ex_str = num2str(E(1),'%+.3f');
 Ey_str = num2str(E(2),'%+.3f');
 E_str = ['E = ','(',Ex_str,', ',Ey_str,')'];
 E_coordinates = text(a-5,a+2.5, E_str, 'FontSize', 10);
 
 Fx_str = num2str(F(1),'%+.3f');
 Fy_str = num2str(F(2),'%+.3f');
 F_str = ['F = ','(',Fx_str,', ',Fy_str,')'];
 F_coordinates = text(a+15,a+5.5, F_str, 'FontSize', 10);
 
 Gx_str = num2str(G(1),'%+.3f');
 Gy_str = num2str(G(2),'%+.3f');
 G_str = ['G = ','(',Gx_str,', ',Gy_str,')'];
 G_coordinates = text(a+15,a+4, G_str, 'FontSize', 10);
 
 Hx_str = num2str(H(1),'%+.3f');
 Hy_str = num2str(H(2),'%+.3f');
 H_str = ['H = ','(',Hx_str,', ',Hy_str,')'];
 H_coordinates = text(a+15,a+2.5, H_str, 'FontSize', 10);
 %{
 
 %Angles
 theta_str = num2str((theta-floor(theta/(2*pi))*(2*pi))/pi*180,'%.5f');
 theta_str = ['\theta',' = ', theta_str];
 theta_value = text(D(1)+2,0, theta_str, 'FontSize', 10);
 
 beta_str = num2str((beta-floor(beta/(2*pi))*(2*pi))/pi*180,'%.5f');
 beta_str = ['\beta',' = ', beta_str];
 beta_value = text(D(1)+2,-2, beta_str, 'FontSize', 10);
 
 omega_str = num2str((omega-floor(omega/(2*pi))*(2*pi))/pi*180,'%.5f');
 omega_str = ['\delta',' = ', omega_str];
 omega_value = text(D(1)+2,-4, omega_str, 'FontSize', 10);
 
 gamma_str = num2str((gamma-floor(gamma/(2*pi))*(2*pi))/pi*180,'%.5f');
 gamma_str = ['\gamma',' = ', gamma_str];
 gamma_value = text(D(1)+2,-6, gamma_str, 'FontSize', 10);
 
 alpha_str = num2str((alpha-floor(alpha/(2*pi))*(2*pi))/pi*180,'%.5f');
 alpha_str = ['\alpha',' = ', alpha_str];
 alpha_value = text(D(1)+2,-8, alpha_str, 'FontSize', 10);
 %}
 % Add Text for Point Label A, B & C
 A_text = text((a+0.5)*cos(theta),(a+0.5)*sin(theta),AA_str, 'FontSize', 10);
 B_text = text(B(1),B(2)-0.5, BB_str, 'FontSize', 10);
 E_text = text(E(1)+0.5,E(2)-0.5, EE_str, 'FontSize', 10);
 F_text = text(F(1)+0.5,F(2)-0.5, FF_str, 'FontSize', 10);
 G_text = text(G(1)+0.5,G(2)-0.5, GG_str, 'FontSize', 10);
 H_text = text(H(1),H(2)-0.75, HH_str, 'FontSize', 10);

 pause(0.005);
 
 % Delete Crank, Slider & Extension, and Circle A, B & C
 delete(crank);
 delete(rod);
 delete(rodc);
 delete(rodg1);
 delete(rodg2);
 delete(rodf);
 delete(tableL1);
 delete(tableL2);
 delete(top);

 delete(A_circle);
 delete(B_circle);
 delete(E_circle);
 delete(F_circle);
 delete(G_circle);
 delete(H_circle);
 
 % Delete Coordinates of A, B & C, Theta, and Point Label A, B & C
 delete(A_coordinates);
 delete(B_coordinates);
 delete(E_coordinates);
 delete(F_coordinates);
 delete(G_coordinates);
 delete(H_coordinates);
 %{ 
 %Angles
 delete(theta_value);
 delete(beta_value);
 delete(omega_value);
 delete(gamma_value);
 delete(alpha_value);
 %}
 delete(A_text);
 delete(B_text);
 delete(E_text);
 delete(F_text);
 delete(G_text);
 delete(H_text);
 
end
% Draw Whole system
A_circle = viscircles(A, 0.1,'Color','#0072BD');
B_circle = viscircles(B, 0.1,'Color','#4DBEEE');
E_circle = viscircles(E, 0.1,'Color','#0072BD');
F_circle = viscircles(F, 0.1,'Color','#0072BD');
G_circle = viscircles(G, 0.1,'Color','#0072BD');
H_circle = viscircles(H, 0.1,'Color','#4DBEEE');

crank = line([O(1) A(1)], [O(1) A(2)],'Color','#77AC30');
rod = line([A(1) B(1)], [A(2) B(2)]);
rodc=line([B(1) E(1)], [B(2) E(2)],'Color','#A2142F');
rodg1=line([C(1) F(1)], [C(2) F(2)],'Color','#D95319');
rodg2=line([D(1) G(1)], [D(2) G(2)],'Color','#D95319');
rodf=line([F(1) G(1)], [F(2) G(2)],'Color','#7E2F8E');
tableL1=line([B(1) T1(1)], [B(2) T1(2)],'Color','#EDB120');
tableL2=line([H(1) T2(1)], [H(2) T2(2)],'Color','#EDB120');
top=line([T1(1) T2(1)], [T1(2) T2(2)],'Color','#EDB120');
 

% Draw Coordinates of Points
A_coordinates = text(a-5,a+5.5, A_str, 'FontSize', 10);
B_coordinates = text(a-5,a+4, B_str, 'FontSize', 10);
E_coordinates = text(a-5,a+2.5, E_str, 'FontSize',10);
F_coordinates = text(a+15,a+5.5, F_str, 'FontSize', 10);
G_coordinates = text(a+15,a+4, G_str, 'FontSize', 10);
H_coordinates = text(a+15,a+2.5, H_str, 'FontSize', 10);


%theta_value = text(a+2,a+1, theta_str, 'FontSize', 12);
% Label Points
A_text = text((a+0.5)*cos(theta),(a+0.5)*sin(theta),AA_str, 'FontSize', 10);
B_text = text(B(1),B(2)-0.5, BB_str, 'FontSize', 10);
E_text = text(E(1)+0.5,E(2)-0.5, EE_str, 'FontSize', 10);
F_text = text(F(1)+0.5,F(2)-0.5, FF_str, 'FontSize', 10);
G_text = text(G(1)+0.5,G(2)-0.5, GG_str, 'FontSize', 10);
H_text = text(H(1),H(2)-0.75, HH_str, 'FontSize', 10);
