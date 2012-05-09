MODELSIMWORK = work
MODELSIMVLIB = vlib
MODELSIMVSIM = vsim
MODELSIMVLOG = vlog

DESIGNTOP = top

RM = rm

CMD = sim_list.cmd

all: simulation 

compile: 
	$(MODELSIMVLIB) $(MODELSIMWORK)
	$(MODELSIMVLOG) -work $(MODELSIMWORK) -lint -f $(CMD)

simulation: compile
	$(MODELSIMVSIM) -c -do "run -all; quit" \
		$(MODELSIMWORK).$(DESIGNTOP)		

clean:
	$(RM) -rf $(MODELSIMWORK)
	$(RM) -f transcript
	$(RM) -f sim.vcd 
	$(RM) -f vsim.wlf
