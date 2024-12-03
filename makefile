all: .created-dirs data/raw/archive.zip data/raw/wine-reviews.csv data/processed/wine-reviews-clean.csv

.created-dirs:
	mkdir -p data/raw
	mkdir -p data/processed
	touch .created-dirs

# Here we download and extract the raw data
data/raw/archive.zip: .created-dirs
	curl -L -o ./data/raw/archive.zip https://www.kaggle.com/api/v1/datasets/download/zynicide/wine-reviews

data/raw/wine-reviews.csv: data/raw/archive.zip
	unzip data/raw/archive.zip -d data/raw/extract && mv data/raw/extract/winemag-data-130k-v2.csv data/raw/wine-reviews.csv && rm -rf data/raw/archive.zip data/raw/extract/

# At this point we need to process the data before we can analyze and make predictions on it. 
# First we remove data that we wont consider like the wine's designation, region, and winery as
# there are simply too many unique values for each of these features.
# we also drop rows with missing values and extract the vintage year from the title.
data/processed/wine-reviews-clean.csv:  .created-dirs data/raw/wine-reviews.csv
	Rscript preprocess.R

.PHONY: clean

clean:
	rm -rf data/
	rm -f .created-dirs