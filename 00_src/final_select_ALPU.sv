module final_select_ALPU (
    input logic [31:0] i_alu_data, 
    input logic [31:0] i_fpu_data, 
    input logic [4:0]  i_alu_op,
    output logic [31:0] o_result



);


always_comb begin
    case (i_alu_op)
		5'b01010:	o_result = i_fpu_data;
		5'b01011:	o_result = i_fpu_data;
		5'b01100:	o_result = i_fpu_data;
		5'b01101:	o_result = i_fpu_data;

    default: o_result = i_alu_data;

    endcase


end

endmodule