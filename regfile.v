`include "defines.vh"
module regfile(
    input wire clk,
    input wire rst,
    input wire re1,
    input wire [4:0] raddr1,
    output reg [31:0] rdata1,
    input wire re2,
    input wire [4:0] raddr2,
    output reg [31:0] rdata2,
    
    input wire we,
    input wire [4:0] waddr,
    input wire [31:0] wdata
);
    reg [31:0] reg_array [31:0];
    // write
    always @ (posedge clk) begin
      if (rst) begin
        if (we && waddr!=5'b0) begin
            reg_array[waddr] <= wdata;
        end
      end
    end

    // read out 1
    always @ (*) begin
      if (rst) begin
        rdata1 <= 32'hbfbf_fffc;
      end else if(raddr1 == 5'h0) begin
        rdata1 <= 32'hbfbf_fffc;
      end else if((raddr1 == waddr) && (we == `Enable)
                       && (re1 == `Enable)) begin
        rdata1 <= wdata;
      end else if(re1 == `Enable) begin
        rdata1 <= reg_array[raddr1];
      end else begin
        rdata1 <= 32'hbfbf_fffc;
      end
    end
      

    // read out 2
    always @ (*) begin
      if (rst) begin
        rdata2 <= 32'hbfbf_fffc;
      end else if(raddr2 == 5'h0) begin
        rdata2 <= 32'hbfbf_fffc;
      end else if((raddr2 == waddr) && (we == `Enable)
                       && (re2 == `Enable)) begin
        rdata2 <= wdata;
      end else if(re1 == `Enable) begin
        rdata2 <= reg_array[raddr2];
      end else begin
        rdata2 <= 32'hbfbf_fffc;
      end
    end
endmodule