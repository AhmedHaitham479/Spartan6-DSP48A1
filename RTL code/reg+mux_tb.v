module reg_mux_18_tb();
reg [17:0]in;
reg CLK,CE,RST;
wire [17:0]out;
parameter REG=1;
parameter RSTTYPE="SYNC";

reg_mux_18 #(.REG(REG),.RSTTYPE(RSTTYPE))dut(in,CLK,CE,RST,out);

initial begin
 CLK=0;
 forever
   #1 CLK=~CLK;
end

initial begin
CE=1;
RST=1;
repeat(10)
@(negedge CLK);

CE=1;
RST=0;
repeat(10)begin
in=$random;
@(negedge CLK);
end
$stop;
end
endmodule

