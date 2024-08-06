module Post_Adder_Subtracter_48(in1,in2,cin,opmode,cout,out);
input [47:0]in1,in2;
input cin;
input opmode;
output [47:0]out;
output cout;

assign {cout,out}=(opmode==1)?(in1-(in2+cin)):(in1+in2+cin);
endmodule