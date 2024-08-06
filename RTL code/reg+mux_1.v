module reg_mux_1(in,CLK,CE,RST,out);
input in;
input CLK,CE,RST;
output out;
reg REG_out;
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