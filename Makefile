TOP_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
VENV_DIR := ${TOP_DIR}/venv/
SRC_DIR := ${TOP_DIR}/src/
TESTS_DIR := ${TOP_DIR}/tests/
SHELL := /bin/bash

tests:	install_dependencies
	@echo "Running tests..." && \
	cd ${TOP_DIR} && \
	source ${VENV_DIR}/bin/activate && \
	PYTHONDONTWRITEBYTECODE=1 PYTHONPATH=${SRC_DIR}:${TESTS_DIR} coverage run -m unittest discover --verbose -t ${TOP_DIR} -s ${TESTS_DIR} --pattern '*_test.py'


init_venv:
	@cd ${TOP_DIR} && \
	if [ ! -d "${VENV_DIR}" ]; then \
		echo "Creating virtualenv..." && \
		virtualenv ${VENV_DIR} -p $(shell which python3.8); \
	fi

install_dependencies:	init_venv
	@echo "Installing dependencies..." && \
	cd ${TOP_DIR} && \
	source ${VENV_DIR}/bin/activate && \
	pip install -r requirements-dev.txt

dist:   tests
	source ${TOP_DIR}/venv/bin/activate && \
	python3 ${TOP_DIR}/setup.py sdist bdist_wheel

clean:
	cd ${TOP_DIR} && \
	rm -rf build/ dist/ *.egg-info/

upload: clean dist
	cd ${TOP_DIR} && \
	source ${TOP_DIR}/venv/bin/activate && \
	twine upload dist/*
