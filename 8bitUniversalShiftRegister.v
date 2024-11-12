#(Using Counter)
module usr(clk,d,s,q);
input [7:0]d;
input [1:0]s;
input clk;
output reg [7:0]q;
reg pps_clk;
reg [24:0] count;
initial

begin
q=8'b00000000;
end
always @(posedge clk)
begin
pps_clk<=0;
if(count < 25000000)
begin
count <= count+1;
end
else
begin
count <= 0;
pps_clk <= ~pps_clk;
end
end
always @(posedge clk)
begin
case(s)
2'b00:q=d;
2'b01:q={q[6:0],1'b0};
2'b10:q={1'b0,q[7:1]};
2'b11:q=q;
endcase
end
endmodule
#(Using Push Button)
module USR( input d, input en,input clk,input [1:0] s,input reset,output reg [7:0] out);
always@(posedge clk)
if(!reset)
out <= 0;
else
if (en)
begin
case(s)
2'b00 : out <= out; //no change
2'b01 : out <= {d,out[7:1]}; //shift right
2'b10 : out <= {out[6:0],d}; //shift left
2'b11 : out <= d; //parallel load
endcase
end
endmodule
Testbench
module usr_tb;
reg [7:0]d;
reg [1:0]s;
wire [7:0]q;
reg clk=1'b0;
usr u1(clk,d,s,q);
always

begin
#10 clk=~clk;
end
initial
begin
s<=2'b00;
d=8'h00;
#20;
s<=2'b00;
d=8'hff;
#20;
s<=2'b01;
#200;
s<=2'b00;
d=8'hff;
#20;
s<=2'b10;
#200;
$stop;
end
endmodule