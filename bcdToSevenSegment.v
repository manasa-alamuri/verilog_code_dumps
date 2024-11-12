module seven_segment(seg0, seg1, seg2, seg3, a);
input [1:0] a;
output [7:0] seg0, seg1, seg2, seg3;
reg [7:0] seg0, seg1, seg2, seg3;
always @ (a)
//S
begin
case(a)
2'b01 :
begin
seg0 = 8'b01001001; //S
seg1 = 8'b11111111; //off
seg2 = 8'b11111111; //off
seg3 = 8'b11111111; //off
end
//6L
2'b10 :
begin
seg0 = 8'b11100011; //L
seg1 = 8'b01000001; //6
seg2 = 8'b11111111; //off
seg3 = 8'b11111111;
end
//H2O
2'b11 :
begin
seg0 = 8'b00000011; //O
seg1 = 8'b00100101; //2
seg2 = 8'b10010001; //H
seg3 = 8'b11111111;
end
//DUDE
2'b00 :
begin
seg0 = 8'b01100001; //E
seg1 = 8'b00000011; //D
seg2 = 8'b10000011; //U
seg3 = 8'b00000011; //D
end
//all off
default:
begin
seg0 = 8'b11111111;
seg1 = 8'b11111111;
seg2 = 8'b11111111;
seg3 = 8'b11111111;
end
endcase
end
endmodule
module seven_segment_tb;
reg [1:0] a;
wire [7:0] seg0, seg1, seg2, seg3;
seven_segment s1(seg0, seg1, seg2, seg3, a);
initial
begin
a = 2'b01; #10 //S
a = 2'b10; #10 //6L
a = 2'b11; #10 //H2O
a = 2'b00; #10 //DUDE
$stop;
end
endmodule