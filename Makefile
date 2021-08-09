TOP_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
VENV_DIR := ${TOP_DIR}/.venv/
SRC_DIR := ${TOP_DIR}/src/
TESTS_DIR := ${TOP_DIR}/tests/
SHELL := /bin/bash

tests:	install_dependencies
	@echo "Running tests..." && \
	cd ${TOP_DIR} && \
	source ${VENV_DIR}/bin/activate && \
	PYTHONDONTWRITEBYTECODE=1 PYTHONPATH=${SRC_DIR}:${TESTS_DIR} coverage run -m unittest discover --verbose -t ${TOP_DIR} -s ${TESTS_DIR} --pattern '*_test.py'

coverage_report:	tests
	cd ${TOP_DIR} && \
	source ${VENV_DIR}/bin/activate && \
	coverage xml

init:
	@cd ${TOP_DIR} && \
	if [ ! $(shell virtualenv --version 1>/dev/null 2>&1) ]; then \
		pip3 install virtualenv; \
	fi; \
	if [ ! -d "${VENV_DIR}" ]; then \
		echo "Creating virtualenv..." && \
		virtualenv ${VENV_DIR} -p $(shell which python3); \
	fi

install_dependencies:	init
	@echo "Installing dependencies..." && \
	cd ${TOP_DIR} && \
	source ${VENV_DIR}/bin/activate && \
	pip install -r requirements-dev.txt

dist:   tests
	source ${VENV_DIR}/bin/activate && \
	python3 ${TOP_DIR}/setup.py sdist bdist_wheel

clean:
	cd ${TOP_DIR} && \
	rm -rf build/ dist/ *.egg-info/

upload: clean dist
	cd ${TOP_DIR} && \
	source ${VENV_DIR}/bin/activate && \
	twine upload dist/*

all_tests:	python36_tests python37_tests python38_tests python39_tests

python36_tests:
	docker build -f ${TOP_DIR}/Dockerfile.build --build-arg=PYTHON_VERSION=3.6 --tag bytesbufio-build-36:latest ${TOP_DIR} && \
	docker run --rm bytesbufio-build-36:latest make tests

python37_tests:
	docker build -f ${TOP_DIR}/Dockerfile.build --build-arg=PYTHON_VERSION=3.7 --tag bytesbufio-build-37:latest ${TOP_DIR} && \
	docker run --rm bytesbufio-build-37:latest make tests

python38_tests:
	docker build -f ${TOP_DIR}/Dockerfile.build --build-arg=PYTHON_VERSION=3.8 --tag bytesbufio-build-38:latest ${TOP_DIR} && \
	docker run --rm bytesbufio-build-38:latest make tests

python39_tests:
	docker build -f ${TOP_DIR}/Dockerfile.build --build-arg=PYTHON_VERSION=3.9 --tag bytesbufio-build-39:latest ${TOP_DIR} && \
	docker run --rm bytesbufio-build-39:latest make tests
