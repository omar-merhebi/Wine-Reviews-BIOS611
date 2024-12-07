all: .created-dirs .downloaded .processed .figures .predictions

.created-dirs:
	mkdir -p data/raw
	mkdir -p data/processed
	mkdir -p data/results
	mkdir -p figures/
	mkdir -p models/
	touch .created-dirs

# Here we download and extract the raw data
.downloaded: .created-dirs
	curl -L -o ./data/raw/archive.zip https://www.kaggle.com/api/v1/datasets/download/zynicide/wine-reviews 
	touch .downloaded

.processed: .created-dirs .downloaded
	unzip data/raw/archive.zip -d data/raw/extract && mv data/raw/extract/winemag-data-130k-v2.csv data/raw/wine-reviews.csv && rm -rf data/raw/archive.zip data/raw/extract/
	Rscript preprocess.R
	python3 wine-desc-tokenize.py
	Rscript preprocess-for-nn.R
	touch .processed

.predictions: .created-dirs .downloaded .processed
	python3 train-nn.py
	Rscript join-post-prediction-data.R
	touch .predictions

.figures: .created-dirs .downloaded .processed .predictions
	Rscript top-25-words.R
	Rscript pca.R
	Rscript nn-result-scatterplots.R
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