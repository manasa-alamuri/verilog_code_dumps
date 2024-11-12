module add_shift_multiplier_4x3(
input [3:0] A, // 4-bit multiplicand
input [2:0] B, // 3-bit multiplier
output reg [7:0] P // 8-bit product
);
integer i;
reg [7:0] temp;
always @(A or B) begin
temp = 0; // Initialize temp to zero
for (i = 0; i < 3; i = i + 1) begin
if (B[i] == 1)
temp = temp + (A << i); // Shift A and add if B[i] is 1
end
P = temp; // Assign the final product to output P
end
endmodule
module seven_segment_display(
input [3:0] digit, // 4-bit input (0 to 15 for hexadecimal display)
output reg [7:0] seg // Seven-segment display output (active low)
);
always @(digit) begin
case (digit)
4'd0: seg = 8'b00000011; // "0"
4'd1: seg = 8'b10011111; // "1"
4'd2: seg = 8'b00100111; // "2"
4'd3: seg = 8'b00001101; // "3"
4'd4: seg = 8'b11011001; // "4"
4'd5: seg = 8'b01001001; // "5"
4'd6: seg = 8'b01000001; // "6"
4'd7: seg = 8'b00011111; // "7"
4'd8: seg = 8'b00000001; // "8"
4'd9: seg = 8'b00011001; // "9"
4'd10: seg = 8'b00010001; // "A"
4'd11: seg = 8'b00000001; // "b"
4'd12: seg = 8'b01100011; // "C"
4'd13: seg = 8'b10000101; // "d"
4'd14: seg = 8'b01100001; // "E"
4'd15: seg = 8'b01110001; // "F"
default: seg = 8'b11111111; // Blank
endcase
end

endmodule
module display_controller(
input [7:0] product, // 8-bit product
input [3:0] A, // 4-bit input A
input [2:0] B, // 3-bit input B
//output [7:0] segA, // Seven-segment display for A
//output [7:0] segB, // Seven-segment display for B
output [7:0] seg1, // Seven-segment display for product's units place
output [7:0] seg2, // Seven-segment display for product's tens place
output [7:0] seg3 // Seven-segment display for product's hundreds place (blank if unused)
);
wire [3:0] digit1, digit2, digit3;
// Extract BCD digits from the product for display
assign digit1 = product % 10; // Units place
assign digit2 = (product / 10) % 10; // Tens place
assign digit3 = (product / 100) % 10; // Hundreds place (usually blank if product < 100)
// Instantiate seven-segment converters for each digit
seven_segment_display seg1_disp (.digit(digit1), .seg(seg1));
seven_segment_display seg2_disp (.digit(digit2), .seg(seg2));
// Show blank if no hundreds digit (product < 100)
seven_segment_display seg3_disp (.digit(digit3), .seg(seg3));
endmodule
module multiplier(
input [3:0] A, // 4-bit multiplicand input
input [2:0] B, // 3-bit multiplier input
output reg [7:0] Aones,
output reg [7:0] Atens,
output reg [7:0] segB, // Seven-segment display for input B
output [7:0] seg1, // Seven-segment display for product's units place
output [7:0] seg2, // Seven-segment display for product's tens place
output [7:0] seg3, // Seven-segment display for product's hundreds place
output [7:0] product
);
// Instantiate the multiplier
add_shift_multiplier_4x3 multiplier (
.A(A),
.B(B),
.P(product)
);
// Instantiate the display controller
display_controller display (

.product(product),
.A(A),
.B(B),
//.segA(segA),
//.segB(segB),
.seg1(seg1),
.seg2(seg2),
.seg3(seg3)
);
always @(A or B)
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
3'b000: segB=8'h03;
3'b001: segB=8'h9f;
3'b010: segB=8'h25;
3'b011: segB=8'h0d;
3'b100: segB=8'h99;
3'b101: segB=8'h49;
3'b110: segB=8'h41;
3'b111: segB=8'h1f;
default: segB=8'hff;
endcase
end
endmodule
Testbench
module multiplier_tb;

reg [3:0] A; // 4-bit multiplicand input
reg [2:0] B; // 3-bit multiplier input
wire [7:0] seg1, seg2, seg3; // Seven-segment displays for product digits
wire [7:0] product;
// Instantiate the top module
multiplier uut (
.A(A),
.B(B),
.seg1(seg1),
.seg2(seg2),
.seg3(seg3),

.product(product)
);
initial begin
// Test case 1: A = 3, B = 2, Expected Product = 6
A = 4'b0011; // 3
B = 3'b010; // 2
#10;
$display("A = %d, B = %d, Product = %d", A, B, uut.multiplier.P);
// Test case 2: A = 5, B = 3, Expected Product = 15
A = 4'b0101; // 5
B = 3'b011; // 3
#10;
$display("A = %d, B = %d, Product = %d", A, B, uut.multiplier.P);
// Test case 3: A = 15, B = 7, Expected Product = 105
A = 4'b1111; // 15
B = 3'b111; // 7
#10;
$display("A = %d, B = %d, Product = %d", A, B, uut.multiplier.P);
// Test case 4: A = 1, B = 4, Expected Product = 4
A = 4'b0001; // 1
B = 3'b100; // 4
#10;
$display("A = %d, B = %d, Product = %d", A, B, uut.multiplier.P);
$stop;
end
endmodule