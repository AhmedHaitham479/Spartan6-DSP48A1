module multiplier(in1,in2,out);
input [17:0]in1,in2;
output [35:0]out;

assign out = in1*in2;
endmodule