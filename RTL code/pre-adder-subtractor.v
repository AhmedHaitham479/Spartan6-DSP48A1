module Pre_Adder_Subtracter(in1,in2,opmode,out);
input [17:0]in1,in2;
input opmode;
output [17:0]out;

assign out =(opmode==1)?(in1-in2):(in1+in2);
endmodule

