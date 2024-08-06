module mux_4in(in1,in2,in3,in4,opmode,out);
input[47:0]in1,in2,in3,in4;
input[1:0]opmode;
output reg [47:0]out;

always@(*)begin
 case(opmode)
 2'b00:out=in1;
 2'b01:out=in2;
 2'b10:out=in3;
 2'b11:out=in4;
 endcase
end 
endmodule