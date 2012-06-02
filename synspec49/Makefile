#Makefile for synspec49

## General Makefile Setup ##
SHELL = /bin/sh
ifeq ($(FC),f77)
  FC := gfortran
endif
ifeq ($(FFLAGS),)
  FFLAGS := -g -static -fno-automatic
endif

# Clear and set list of suffixes for implicit rules (which we
# will probably not use).
.SUFFIXES: 
.SUFFIXES: .F .o

# Important definitions
#mainFile := synspec49.f
prog := synspec49
srcFiles := synspec49.f
includeFiles := $(wildcard *.FOR *.for)
objectFiles := $(srcFiles:.f=.o)
# definitions required for building include/header dependencies
#   a variable holding the grep command, can be used as a function
grepSrcFiles = grep -l "^[^C].*INCLUDE.*$(1)" $(srcFiles)
#   headerDepends.  Takes any header file as argument 1
#   and returns the makefile rule with all the objects that 
#   depend on that header file in one line.
define headerDepends
 $(subst .F,.o,$(shell $(call grepSrcFiles,$(1)))) : $(1)
endef

# Build Main
$(prog): $(objectFiles)
	$(FC) $(FFLAGS) -o $(prog) $^

# Build objects
$(objectFiles): %.o: %.f
	$(FC) $(FFLAGS) -c $< -o $@

# include/header file dependencies
# Calls headerDepends for very header file, and then evaluates the result as a makefile rule
ifdef includeFiles
  $(foreach header,$(includeFiles),$(eval $(call headerDepends,$(header))))
endif

# Other Actions
.PHONY: cleanall cleanobj
cleanall:
	-rm *.o $(prog)
cleanobj:
	-rm *.o

# Debuging
.PHONY: show
show:
	@echo $(grepSrcFiles)
	@echo $(call grepSrcFiles,COMA.FOR)
	@echo $(shell $(call grepSrcFiles,COMA.FOR))
	@echo $(subst .F,.o,$(shell $(call grepSrcFiles,COMA.FOR))) : COMA.FOR
	@echo $(call headerDepends,COMA.FOR)
	@echo $(call headerDepends,COMM.FOR)
	@echo $(call headerDepends,COMR.FOR)
