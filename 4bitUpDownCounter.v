(Asynchronous Counter)
module up_down_counter_async(clk,reset,mode,q,ones,tens);
input clk;
input reset;//active high
input mode;
output reg[3:0] q;
output reg[7:0] ones,tens;
always @(posedge clk or posedge reset)
begin
if(reset)
q<=4'b0000;
else

begin
if(mode==1)
q<=q+1;
else
q<=q-1;
end
end
always @(q)
begin
case(q)
4'b0000: begin ones=8'h03; tens=8'hff; end //0
4'b0001: begin ones=8'h9f; tens=8'hff; end //1
4'b0010: begin ones=8'h25; tens=8'hff; end //2
4'b0011: begin ones=8'h0d; tens=8'hff; end //3
4'b0100: begin ones=8'h99; tens=8'hff; end //4
4'b0101: begin ones=8'h49; tens=8'hff; end //5
4'b0110: begin ones=8'h41; tens=8'hff; end //6
4'b0111: begin ones=8'h1f; tens=8'hff; end //7
4'b1000: begin ones=8'h01; tens=8'hff; end //8
4'b1001: begin ones=8'h09; tens=8'hff; end //9
4'b1010: begin ones=8'h03; tens=8'h9f; end //10
4'b1011: begin ones=8'h9f; tens=8'h9f; end //11
4'b1100: begin ones=8'h25; tens=8'h9f; end //12
4'b1101: begin ones=8'h0d; tens=8'h9f; end //13
4'b1110: begin ones=8'h99; tens=8'h9f; end //14
4'b1111: begin ones=8'h49; tens=8'h9f; end //15
default: begin ones=8'hff; tens=8'hff; end //all off
endcase
end
endmodule
Testbench
module tb_async;
reg clk, reset, mode;
wire [3:0] q;
wire [7:0] ones, tens;
up_down_counter_async s1(clk,reset,mode,q,ones,tens);
initial
begin
clk=0;
forever #5 clk=~clk;
end
initial
begin
reset=1;
mode=0;
#160
reset=0;
mode=0;
#160;
mode=1;
#160;
$stop;
end
endmodule

Verilog Code
(Synchronous Counter)
module up_down_counter_sync(clk,reset,mode,q,ones,tens);
input clk;
input reset;//active high
input mode;
output reg[3:0] q;
output reg[7:0] ones,tens;
always @(posedge clk)
begin
if(reset)
q<=4'b0000;
else
begin
if(mode==1)
q<=q+1;
else
q<=q-1;
end
end
always @(q)
begin
case(q)
4'b0000: begin ones=8'h03; tens=8'hff; end //0
4'b0001: begin ones=8'h9f; tens=8'hff; end //1
4'b0010: begin ones=8'h25; tens=8'hff; end //2
4'b0011: begin ones=8'h0d; tens=8'hff; end //3
4'b0100: begin ones=8'h99; tens=8'hff; end //4
4'b0101: begin ones=8'h49; tens=8'hff; end //5
4'b0110: begin ones=8'h41; tens=8'hff; end //6
4'b0111: begin ones=8'h1f; tens=8'hff; end //7
4'b1000: begin ones=8'h01; tens=8'hff; end //8
4'b1001: begin ones=8'h09; tens=8'hff; end //9
4'b1010: begin ones=8'h03; tens=8'h9f; end //10
4'b1011: begin ones=8'h9f; tens=8'h9f; end //11
4'b1100: begin ones=8'h25; tens=8'h9f; end //12
4'b1101: begin ones=8'h0d; tens=8'h9f; end //13
4'b1110: begin ones=8'h99; tens=8'h9f; end //14
4'b1111: begin ones=8'h49; tens=8'h9f; end //15
default: begin ones=8'hff; tens=8'hff; end //all off
endcase
end
endmodule
Testbench
module tb_sync;
reg clk, reset, mode;
wire [3:0] q;
wire [7:0] ones, tens;
up_down_counter_sync s1(clk,reset,mode,q,ones,tens);
initial
begin
clk=0;

forever #5 clk=~clk;
end
initial
begin
reset=1;
mode=0;
#160
reset=0;
mode=0;
#160;
mode=1;
#160;
$stop;
end
endmodule