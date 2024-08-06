module reg_mux_8(in,CLK,CE,RST,out);
input [7:0]in;
input CLK,CE,RST;
output [7:0]out;
reg [7:0]REG_out;
parameter REG=1;
parameter RSTTYPE="SYNC";

assign out =(REG==1)?REG_out:in;

generate 
if(RSTTYPE=="SYNC")begin
  always@(posedge CLK)begin
  if(CE==1)begin
   if(RST==1)
   REG_out<=0;
   else
   REG_out<=in;
 end
 end
end
else begin
always@(posedge CLK or posedge RST)begin
   if(RST==1)
   REG_out<=0;
   else begin
    if(CE==1)
    REG_out<=in;
   end 
end
end
endgenerate
endmodule