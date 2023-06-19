module ALU(
	//TODO: Add some input or output parameters to deliever operands and results
	input[31:0] SrcA,
	input[31:0] SrcB,
	input[3:0] ALUOp,
	output reg[31:0] ALUResult,
	output reg[3:0] ALUFlags
	);
	
	always @ (*)
	//TODO: Write code for ALU calculation by cases(e.g., ADD, SUB)
	//TODO: Write code for data transfer instruction(e.g., MOV)
	
	begin
		case(ALUOp)
			4'b0010:
			begin
				ALUResult = SrcA - SrcB;
			end
			4'b0100:
			begin
				ALUResult = SrcA + SrcB;
			end
			4'b1010:
			begin
				ALUResult = SrcA - SrcB;
				if(SrcA == SrcB)
					ALUFlags = 4'bx1xx;
				else
					ALUFlags = 4'bx0xx;
			end
			4'b1101:
			begin
				ALUResult = SrcB;
			end
		endcase
	end
	
endmodule 
		