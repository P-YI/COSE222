module ARMProcessor(
	input clk,
	input reset,
	output[31:0] pc,
	input[31:0] inst,
	input nIRQ,
	output[3:0] be,
	output[31:0] memaddr,
	output memwrite,
	output memread,
	output[31:0] writedata,
	input[31:0] readdata
	);
	
	assign pc = pctmp;
	assign be = 4'b1111; // default
	assign memread = 'b1; // default
	
	//TODO: Wire setting
	wire[3:0] ReadAddr1, ReadAddr2, WriteAddr;
	wire[31:0] ReadData1, ReadData2, ReadData3;
	wire[31:0] Result, ExtImm, SrcB, ALUResult, PCPlus4, PCBranch, pctmp;
	wire[3:0] ALUOp, ALUFlags;
	wire[1:0] RegSrc, ImmSrc;
	wire PCSrc, RegWrite, MemWrite, MemtoReg, ALUSrc, Svalue;
	wire[31:0] NextPC;
	
	//TODO: Assign values to variables 
	/*assign Variable = Value*/
	assign ReadAddr1 = inst[19:16];
	assign ReadAddr2 = inst[3:0];
	assign WriteAddr = inst[15:12];
	assign memaddr = ALUResult;
	assign memwrite = MemWrite;
	assign memread = 'b1;
	assign writedata = ReadData3;
	assign SrcB = (ALUSrc == 1'b0) ? ReadData2 : ExtImm;
	assign Result = (MemtoReg == 1'b0) ? ALUResult : readdata;
	assign PCPlus4 = pctmp + 32'd4;
	assign PCBranch = pctmp + ExtImm + 32'd8;
	assign NextPC = (PCSrc == 1'b0) ? PCPlus4 : PCBranch;
	
	
	ControlUnit _ControlUnit(
			.NZCV(NZCV), 
			.cond(inst[31:28]), 
			.op(inst[27:26]), 
			.funct(inst[25:20]), 
			.ALUOp(ALUOp), 
			.ImmSrc(ImmSrc), 
			.RegSrc(RegSrc),  
			.PCSrc(PCSrc), 
			.RegWrite(RegWrite), 
			.MemWrite(MemWrite), 
			.MemtoReg(MemtoReg), 
			.ALUSrc(ALUSrc), 
			.Svalue(Svalue)
	);
	
	RegisterFile _RegisterFile( 
			.clk(clk), 
			.reset(reset), 
			.we(RegWrite), 
			.RegSrc(RegSrc), 
			.addr1(ReadAddr1), 
			.addr2(ReadAddr2), 
			.addr3(WriteAddr),
			.waddr(WriteAddr), 
			.wdata(Result), 
			.pcin(NextPC), 
			.data1(ReadData1), 
			.data2(ReadData2), 
			.data3(ReadData3), 
			.pcout(pctmp)
	);
										
	Extend _Extend( 
		.in(inst[23:0]), 
		.ImmSrc(ImmSrc), 
		.ExtImm(ExtImm) 
	);
	
	ALU _ALU( 
		.SrcA(ReadData1), 
		.SrcB(SrcB), 
		.ALUOp(ALUOp), 
		.ALUFlags(ALUFlags), 
		.ALUResult(ALUResult) 
	); 

endmodule
