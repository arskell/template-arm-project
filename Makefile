include ./makefile.conf

OBJS_CXX = $(SRCS_CXX:.cpp=.o)
OBJS_C = $(SRCS_C:.c=.o)
OBJS_ASM = $(SRCS_ASM:.s=.o)

.PHONY: clean all remove

.cpp.o:
	$(CXX) $(FLAGS) -c $(INCLUDE) $^ -o $@

.s.o:
	$(CXX) $(FLAGS) -c $(INCLUDE) $^ -o $@

.c.o:
	$(CXX) $(FLAGS) -c $(INCLUDE) $^ -o $@


$(PROJECT_NAME).hex: $(OBJS_ASM) $(OBJS_C) $(OBJS_CXX)
	$(CXX) $(FLAGS) $(INCLUDE) $(OBJS_ASM) $(OBJS_C) $(OBJS_CXX) $(LINKER_FLAGS) -o $(PROJECT_NAME).elf
	$(COPY) -Oihex $(PROJECT_NAME).elf $(PROJECT_NAME).hex
	$(SZ) $(PROJECT_NAME).hex

all: $(PROJECT_NAME)
	

clean:
	$(foreach file,$(OBJS_ASM), rm -f $(file))
	$(foreach file,$(OBJS_C), rm -f $(file))
	$(foreach file,$(OBJS_CXX), rm -f $(file))
	rm -f $(PROJECT_NAME).elf

remove: clean
	rm -f $(PROJECT_NAME).hex
