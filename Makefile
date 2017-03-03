.PHONY: install clean test retest coverage docs

install:
	pip install -e .[docs,test]
	pip install bumpversion twine wheel

lint:
	flake8 src/ tests/
	isort --recursive --check-only --diff src tests

clean:
	find . -name '*.pyc' -delete
	find . -name '__pycache__' -delete

test:
	py.test -vvv

retest:
	py.test -vvv --lf

coverage:
	py.test --cov=sigep --cov-report=term-missing --cov-report=html

docs:
	$(MAKE) -C docs html

release:
	pip install twine wheel
	rm -rf dist/*
	python setup.py sdist bdist_wheel
	twine upload -s dist/*