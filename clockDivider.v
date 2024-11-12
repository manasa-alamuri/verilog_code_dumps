module CD(
input wire clk_in,
input wire reset,
output reg clk_out_f2,
output reg clk_out_f4,
output reg clk_out_f6,
output reg [2:0] mod5
);
reg [1:0] counter; // 3-bit counter to count the clock cycles
always @(posedge clk_in or posedge reset) begin
if (reset) begin
mod5 <= 0;
counter <= 0;
clk_out_f2 <= 0;
clk_out_f4 <= 0;
clk_out_f6 <= 0;
end else begin
counter <= counter + 1; // Increment the counter on each clock cycle
if(mod5 == 3'd5) mod5<=0;
else mod5 <= mod5+1;
clk_out_f2 <= ~clk_out_f2;

// Clock divider for f/4 (toggle every 4 cycles)
if (counter[0] == 1'b1) begin
clk_out_f4 <= ~clk_out_f4;
end
// Clock divider for f/6 (toggle at every 3rd and 6th cycle)
if (mod5 == 3'd2 | mod5 == 3'd5) begin
clk_out_f6 <= ~clk_out_f6; // Toggle the clock for f/6
end
end
end
endmodule






#Testbench
module CD_tb();
reg clk_in;
reg reset;
wire clk_out_f2;
wire clk_out_f4;
wire clk_out_f6;
// Instantiate the clock divider
CD uut (
.clk_in(clk_in),
.reset(reset),
.clk_out_f2(clk_out_f2),
.clk_out_f4(clk_out_f4),
.clk_out_f6(clk_out_f6)
);

// Generate input clock (100 MHz -> 10 ns period)
initial begin
clk_in = 0; // Initialize clock
forever #5 clk_in = ~clk_in; // Toggle every 5ns -> 100MHz clock
end
// Test process
initial begin
// Initialization
reset = 1; // Start with reset
#10 reset = 0; // Release reset after 10ns
// Run the simulation for 400ns
#400 $finish; // End simulation
end
initial begin
$monitor("Time = %0t | clk_in = %b | clk_out_f2 = %b | clk_out_f4 = %b | clk_out_f6 = %b",
$time, clk_in, clk_out_f2, clk_out_f4, clk_out_f6);
end
endmodule