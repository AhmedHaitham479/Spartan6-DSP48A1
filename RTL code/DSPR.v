module DSP48A1 (A,B,C,D,CARRYIN,BCIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP,BCOUT,PCIN,PCOUT);
input[17:0]A,B,D;
input[7:0]OPMODE;
input[17:0]BCIN;
input[47:0]C,PCIN;
input CARRYIN,CLK,CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP;
output[47:0]PCOUT,P;
output[17:0]BCOUT;
output[35:0]M;
output CARRYOUT,CARRYOUTF;

parameter A0REG=1 ,A1REG=1 ,B0REG=1 ,B1REG=1;
parameter CREG=1, DREG=1, MREG=1, PREG=1, CARRYINREG=1, CARRYOUTREG=1, OPMODEREG=1;
parameter CARRYINSEL="OPMODE5";
parameter B_INPUT="DIRECT";
parameter RSTTYPE="SYNC";

wire CIN,cout;
reg CINbegin;
wire[7:0]out_OPMODEmux;
wire[35:0]out_multiplier;
wire [17:0]out_Dmux,out_Bmux,out_Amux,out_adder1,out_adder_mux,multiplierin1_mux,out_Amux2;
wire [47:0]out_Cmux,X,Z,out_adder2;
//stage 1
reg_mux_8 m0(OPMODE,CLK,CEOPMODE,RSTOPMODE,out_OPMODEmux);
reg_mux_18 m1(D,CLK,CED,RSTD,out_Dmux);

generate 
if(B_INPUT=="DIRECT")
reg_mux_18 m2(B,CLK,CEB,RSTB,out_Bmux);
else if(B_INPUT=="CASCADE")
reg_mux_18 m3(BCIN,CLK,CEB,RSTB,out_Bmux);
else
assign out_Bmux=0;
endgenerate

reg_mux_18 m4(A,CLK,CEA,RSTA,out_Amux);
reg_mux_48 m5(C,CLK,CEC,RSTC,out_Cmux);

//stage 2
Pre_Adder_Subtracter n1(out_Dmux,out_Bmux,out_OPMODEmux[6],out_adder1);
mux_2in n2(out_Bmux,out_adder1,out_OPMODEmux[4],out_adder_mux);

//stage 3
reg_mux_18 r1(out_adder_mux,CLK,CEA,RSTA,multiplierin1_mux);
reg_mux_18 r2(out_Amux,CLK,CEA,RSTA,out_Amux2);
multiplier r3(multiplierin1_mux,out_Amux2,out_multiplier);
assign BCOUT=multiplierin1_mux;

//stage 4
reg_mux_36 e1(out_multiplier,CLK,CEM,RSTM,M);
always@(*)begin
if(CARRYINSEL=="OPMODE5")
CINbegin=out_OPMODEmux[5];
else
CINbegin=CARRYIN;
end
reg_mux_1 e2(CINbegin,CLK,CECARRYIN,RSTCARRYIN,CIN);

//stage 5
mux_4in s1(48'h000000000000,{12'h0000,M},P,{out_Dmux[11:0],out_Amux[17:0],out_Bmux[17:0]},out_OPMODEmux[1:0],X);
mux_4in s2(48'h000000000000,PCIN,P,out_Cmux,out_OPMODEmux[3:2],Z);

//stage 6
Post_Adder_Subtracter_48 z1(Z,X,CIN,out_OPMODEmux[7],cout,out_adder2);
reg_mux_1 z2(cout,CLK,CECARRYIN,RSTCARRYIN,CARRYOUT);
assign CARRYOUTF=CARRYOUT;
reg_mux_48 z3(out_adder2,CLK,CEP,RSTP,P);
assign PCOUT=P;

endmodule