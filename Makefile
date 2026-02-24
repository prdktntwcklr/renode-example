PROJECT_DIR := nucleo-f446re/ButtonLed
TEST_FILE   := tests/test-button.robot

.PHONY: all build test clean

all: build test

build:
	@echo "Building binaries in $(PROJECT_DIR)..."
	$(MAKE) -C $(PROJECT_DIR)

test:
	@echo "Running Renode tests..."
	renode-test $(TEST_FILE)

clean:
	$(MAKE) -C $(PROJECT_DIR) clean
