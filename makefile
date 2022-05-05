include .env

create-venv:
	( \
		python3 -m venv venv; \
		source venv/bin/activate; \
	)

install:
	python3 -m pip install --upgrade pip
	python3 -m pip install -r requirements.txt
	python3 -m pip install --upgrade prodigy -f "https://${PRODIGY_KEY}@download.prodi.gy"

download:
	wget https://zenodo.org/record/3563990/files/barkmeow_v0.2.tar.gz
	mkdir data
	tar xvzf barkmeow_v0.2.tar.gz -C data
	rm -rf barkmeow_v0.2.tar.gz
	cp data/barkmeow/cat/*.wav data
	cp data/barkmeow/dog/*.wav data
	rm -rf data/barkmeow/cat
	rm -rf data/barkmeow/dog
	rm -rf data/barkmeow

clean-cache:
	rm -rf */__pycache__/*
	rm -rf .ipynb_checkpoints

clean-files:
	rm -rf data/*

clean-venv:
	rm -rf venv

clean-prodigy:
	python3 -m prodigy drop barkmeow_data

prodigy-label:
	python3 -m prodigy classify-audio barkmeow_data data -F classify-recipe.py