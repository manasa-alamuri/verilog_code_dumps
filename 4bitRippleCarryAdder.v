module RA(Aones,Atens,Bones,Btens,ones,tens,Sum,C4,A,B,C0);
input [3:0] A,B;
input C0;
output [3:0]Sum;
output C4;
output [7:0] Aones,Atens,Bones,Btens,ones,tens; //hex format
reg [7:0] Aones,Atens,Bones,Btens,ones,tens;
wire w1,w2,w3;
FA f1(Sum[0],w1,A[0],B[0],C0);
FA f2(Sum[1],w2,A[1],B[1],w1);
FA f3(Sum[2],w3,A[2],B[2],w2);
FA f4(Sum[3],C4,A[3],B[3],w3);
//7 segment
always @(A or B or Sum or C4 or C0)
begin
case(A)
4'b0000: begin Aones=8'h03; Atens=8'hff; end //0
4'b0001: begin Aones=8'h9f; Atens=8'hff; end //1
4'b0010: begin Aones=8'h25; Atens=8'hff; end //2
4'b0011: begin Aones=8'h0d; Atens=8'hff; end //3
4'b0100: begin Aones=8'h99; Atens=8'hff; end //4
4'b0101: begin Aones=8'h49; Atens=8'hff; end //5
4'b0110: begin Aones=8'h41; Atens=8'hff; end //6
4'b0111: begin Aones=8'h1f; Atens=8'hff; end //7
4'b1000: begin Aones=8'h01; Atens=8'hff; end //8
4'b1001: begin Aones=8'h09; Atens=8'hff; end //9
4'b1010: begin Aones=8'h03; Atens=8'h9f; end //10
4'b1011: begin Aones=8'h9f; Atens=8'h9f; end //11
4'b1100: begin Aones=8'h25; Atens=8'h9f; end //12
4'b1101: begin Aones=8'h0d; Atens=8'h9f; end //13
4'b1110: begin Aones=8'h99; Atens=8'h9f; end //14
4'b1111: begin Aones=8'h49; Atens=8'h9f; end //15
default: begin Aones=8'hff; Atens=8'hff; end //all off
endcase
case(B)
4'b0000: begin Bones=8'h03; Btens=8'hff; end //0
4'b0001: begin Bones=8'h9f; Btens=8'hff; end //1
4'b0010: begin Bones=8'h25; Btens=8'hff; end //2
4'b0011: begin Bones=8'h0d; Btens=8'hff; end //3
4'b0100: begin Bones=8'h99; Btens=8'hff; end //4
4'b0101: begin Bones=8'h49; Btens=8'hff; end //5
4'b0110: begin Bones=8'h41; Btens=8'hff; end //6
4'b0111: begin Bones=8'h1f; Btens=8'hff; end //7
4'b1000: begin Bones=8'h01; Btens=8'hff; end //8
4'b1001: begin Bones=8'h09; Btens=8'hff; end //9
4'b1010: begin Bones=8'h03; Btens=8'h9f; end //10
4'b1011: begin Bones=8'h9f; Btens=8'h9f; end //11
4'b1100: begin Bones=8'h25; Btens=8'h9f; end //12
4'b1101: begin Bones=8'h0d; Btens=8'h9f; end //13
4'b1110: begin Bones=8'h99; Btens=8'h9f; end //14
4'b1111: begin Bones=8'h49; Btens=8'h9f; end //15
default: begin Bones=8'hff; Btens=8'hff; end //all off
endcase

case({C4,Sum})
5'b00000: begin ones=8'h03; tens=8'hff; end //0
5'b00001: begin ones=8'h9f; tens=8'hff; end //1
5'b00010: begin ones=8'h25; tens=8'hff; end //2
5'b00011: begin ones=8'h0d; tens=8'hff; end //3
5'b00100: begin ones=8'h99; tens=8'hff; end //4
5'b00101: begin ones=8'h49; tens=8'hff; end //5
5'b00110: begin ones=8'h41; tens=8'hff; end //6
5'b00111: begin ones=8'h1f; tens=8'hff; end //7
5'b01000: begin ones=8'h01; tens=8'hff; end //8
5'b01001: begin ones=8'h09; tens=8'hff; end //9
5'b01010: begin ones=8'h03; tens=8'h9f; end //10
5'b01011: begin ones=8'h9f; tens=8'h9f; end //11
5'b01100: begin ones=8'h25; tens=8'h9f; end //12
5'b01101: begin ones=8'h0d; tens=8'h9f; end //13
5'b01110: begin ones=8'h99; tens=8'h9f; end //14
5'b01111: begin ones=8'h49; tens=8'h9f; end //15
5'b10000: begin ones=8'h41; tens=8'h9f; end //16
5'b10001: begin ones=8'h1f; tens=8'h9f; end //17
5'b10010: begin ones=8'h01; tens=8'h9f; end //18
5'b10011: begin ones=8'h09; tens=8'h9f; end //19
5'b10100: begin ones=8'h03; tens=8'h25; end //20
5'b10101: begin ones=8'h9f; tens=8'h25; end //21
5'b10110: begin ones=8'h25; tens=8'h25; end //22
5'b10111: begin ones=8'h0d; tens=8'h25; end //23
5'b11000: begin ones=8'h99; tens=8'h25; end //24
5'b11001: begin ones=8'h49; tens=8'h25; end //25
5'b11010: begin ones=8'h41; tens=8'h25; end //26
5'b11011: begin ones=8'h1f; tens=8'h25; end //27
5'b11100: begin ones=8'h01; tens=8'h25; end //28
5'b11101: begin ones=8'h09; tens=8'h25; end //29
5'b11110: begin ones=8'h03; tens=8'h0d; end //30
5'b11111: begin ones=8'h9f; tens=8'h0d; end //31
default: begin ones=8'hff; tens=8'hff; end //all off
endcase
end
endmodule
module FA(S,Cout,A,B,Cin);
input A,B,Cin;
output S,Cout;
reg S,Cout;
always @(A or B or Cin)
begin
S=A^B^Cin;
Cout=((A^B)&Cin)|(A&B);
end
endmodule

Testbench
module RA_tb;
reg [3:0] A;
reg [3:0] B;
reg C0;
wire [3:0] Sum;
wire C4;
wire [7:0] Aones,Atens,Bones,Btens,ones,tens;

RA r1(Aones,Atens,Bones,Btens,ones,tens,Sum,C4,A,B,C0);
initial
begin
A = 4'b0;
B = 4'b0;
C0 = 4'b0;
// Wait for global reset to finish
#10;
// Add stimulus here
A = 4'b1011;
B = 4'b0100;
C0 = 1'b0;
#20;
A = 4'd1111;
B = 4'b1101;
C0 = 1’b1;
#20
$stop;
end
endmodule