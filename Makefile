test:
	nvim --headless -u tests/minimal_init.vim -c 'PlenaryBustedDirectory tests/'

test-local: 
	nvim --headless -c 'PlenaryBustedDirectory tests/'

lint:
	luacheck lua/
