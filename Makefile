BPL_PATH=$(DELPHI)\Projects\Bpl
REG_PATH=hkcu\software\borland\delphi\7.0
DCC=dcc32
DCC_FLAGS=-q -b -W-IMPLICIT_IMPORT -W-GARBAGE -U"$(BPL_PATH)" -LE"$(BPL_PATH)" -LN"$(BPL_PATH)"

all: build

build: clean
    @cd Packages
	@dof2cfg SynEdit_R7.cfg
	@dof2cfg SynEdit_D7.cfg
	@$(DCC) $(DCC_FLAGS) SynEdit_R7.dpk >dcc32.log
	@$(DCC) $(DCC_FLAGS) SynEdit_D7.dpk >dcc32.log
 
install: build
	@reg add "$(REG_PATH)\known packages" /f /t REG_SZ /v "$(BPL_PATH)\SynEdit_D7.bpl" /d "SynEdit" >NUL

uninstall:
	@reg delete "$(REG_PATH)\known packages" /v "$(BPL_PATH)\$(PROJECT).bpl" /f >NUL
	@del /s /q "$(BPL_PATH)\$(PROJECT).*" 2>NUL >NUL

clean:
	@DEL /S /Q *.dcu 2>NUL >NUL
	@DEL /S /Q *.ddp 2>NUL >NUL
	@DEL /S /Q *.dcp 2>NUL >NUL
	@DEL /S /Q *.dsk 2>NUL >NUL
	@DEL /S /Q *.bpl 2>NUL >NUL
	@DEL /S /Q *.~* 2>NUL >NUL
