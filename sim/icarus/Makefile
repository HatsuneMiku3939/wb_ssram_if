VC = iverilog
VS = vvp
RM = rm

TARGET = tb
CMD = sim_list.cmd

all: simulation 

compile: 
	$(VC) -c $(CMD) -o $(TARGET)

simulation: compile
	$(VS) $(TARGET)

clean:
	$(RM) -f $(TARGET) sim.vcd
		
