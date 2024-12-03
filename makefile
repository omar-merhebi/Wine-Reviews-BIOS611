all: .created-dirs .downloaded .processed

.created-dirs:
	mkdir -p data/raw
	mkdir -p data/processed
	touch .created-dirs

# Here we download and extract the raw data
.downloaded: .created-dirs
	curl -L -o ./data/raw/archive.zip https://www.kaggle.com/api/v1/datasets/download/zynicide/wine-reviews 
	touch .downloaded

.processed: .created-dirs .downloaded
	unzip data/raw/archive.zip -d data/raw/extract && mv data/raw/extract/winemag-data-130k-v2.csv data/raw/wine-reviews.csv && rm -rf data/raw/archive.zip data/raw/extract/
	Rscript preprocess.R
	python3 wine-desc-tokenize.py
	touch .processed

.PHONY: clean

clean:
	rm -rf data/
	rm -rf nltk_data/
	rm -f .created-dirs
	rm -f .downloaded
	rm -f .processed