all: .created-dirs .downloaded .processed .figures

.created-dirs:
	mkdir -p data/raw
	mkdir -p data/processed
	mkdir -p figures/
	touch .created-dirs

# Here we download and extract the raw data
.downloaded: .created-dirs
	curl -L -o ./data/raw/archive.zip https://www.kaggle.com/api/v1/datasets/download/zynicide/wine-reviews 
	touch .downloaded

.processed: .created-dirs .downloaded
	unzip data/raw/archive.zip -d data/raw/extract && mv data/raw/extract/winemag-data-130k-v2.csv data/raw/wine-reviews.csv && rm -rf data/raw/archive.zip data/raw/extract/
	Rscript preprocess.R
	python3 wine-desc-tokenize.py
	Rscript one-hot-encode.R
	touch .processed

.figures: .created-dirs .downloaded .processed
	Rscript top-25-words.R
	Rscript pca.R
	touch .figures

.PHONY: clean

clean:
	rm -rf data/
	rm -rf nltk_data/
	rm -rf figures/
	rm -rf __pycache__/
	rm -f .created-dirs
	rm -f .downloaded
	rm -f .processed