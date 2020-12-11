test:
	nvim --headless -u tests/minimal_init.vim -c 'PlenaryBustedDirectory tests/'

lint:
	luacheck lua/
