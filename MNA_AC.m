%Sarah Dolan, ELEC 4700, March 2022
%% PA-7, MNA Building
iterations = 500;
omega = linspace (0, 2*pi , iterations);

R0 = 1000;
R1 = 1;
R2 = 2;
R3 = 10;
R4 = 0.1;
C1 = 0.25;
L = 0.2;
a = 100;

G0 = 1/R0;
G1 = 1/R1;
G2 = 1/R2;
G3 = 1/R3;
G4 = 1/R4;

Vo = zeros(1, iterations);
V1 = zeros(1, iterations);
V2 = zeros(1, iterations);
V3 = zeros(1, iterations);
V4 = zeros(1, iterations);
IL = zeros(1, iterations);
Is = zeros(1, iterations);

Vs =  10*real(exp(1i * omega));

for n = 1:iterations 
    G = [0     0     1     0     0     0     0;
         1     0     G1    -G1   0     0     0;
         0    -1    -G1  (G1+G2) 0     0     0;
         0     0     0     1    -1     0     0;
         0     1     0     0    -G3    0     0;
         0     -a    0     0     0     1     0;
         0     0     0     0     0     -G4   (G4+G0)];
    
    C = [0     0     0     0     0     0     0;
         0     0     C1   -C1    0     0     0;
         0     0    -C1    C1    0     0     0;
         0     -L    0     1     0     0     0;
         0     0     0     0     0     0     0;
         0     0     0     0     0     0     0;
         0     0     0     0     0     0     0];
    
    F = [Vs(n)    0     0     0     0     0     0];
    
    V = F/(G' + 1i * omega(n) * C') ;

    Is(n) = real(V(1, 1));
    IL(n) = real(V(1, 2));
    V1(n) = real(V(1, 3));
    V2(n) = real(V(1, 4));
    V3(n) = real(V(1, 5));
    V4(n) = real(V(1, 6));
    Vo(n) = real(V(1, 7));

end

nexttile
plot (omega, Vo);
hold on
plot (omega, V1);
title("Vo and V3, AC Simulation")
ylabel("Potential (V)")
xlabel("\omega")
legend('V_0','V_1')
xlim([0 2*pi])
set(gca,'XTick',0:pi/2:2*pi) 
set(gca,'XTickLabel',{'0','pi/2','pi','3*pi/2','2*pi'})

nexttile
plot (omega, 20 * log(Vo./V1));
title("AC Gain, V_o/ V_1")
ylabel("V_o/ V_1 (dB)")
xlabel("\omega")
xlim([0 2*pi])
set(gca,'XTick',0:pi/2:2*pi) 
set(gca,'XTickLabel',{'0','pi/2','pi','3*pi/2','2*pi'})



