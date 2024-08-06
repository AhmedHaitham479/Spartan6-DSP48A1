module mux_2in(in1,in2,opmode,out);
input[17:0]in1,in2;
input opmode;
output reg [17:0]out;

always@(*)begin
 case(opmode)
 2'b00:out=in1;
 2'b01:out=in2;
 endcase
end 
endmodule