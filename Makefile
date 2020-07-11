TOP_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
VENV_DIR := ${TOP_DIR}/venv/
SRC_DIR := ${TOP_DIR}/src/
TESTS_DIR := ${TOP_DIR}/tests/
SHELL := /bin/bash

tests:	init_venv
	@echo "Running tests..." && \
	cd ${TOP_DIR} && \
	source ${VENV_DIR}/bin/activate && \
	PYTHONPATH=${SRC_DIR}:${TESTS_DIR} python -B -m unittest discover -p '*_test.py' ${TESTS_DIR}

init_venv:
	@cd ${TOP_DIR} && \
	if [ ! -d "${VENV_DIR}" ]; then \
		echo "Creating virtualenv..." && \
		virtualenv ${VENV_DIR} -p $(shell which python3.8); \
	fi
