#when you run 'make' in the terminal, it will run the help command
#use '@' in front of command so that it won't show up in the terminal when you run it

.DEFAULT_GOAL = help 

hello: # hello world
	@echo "hello world this is my first make command"

install: # install requirements
	@pip install numpy pandas

help: # Show all commands
	@egrep -h '\s#\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'