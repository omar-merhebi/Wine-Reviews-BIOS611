all: data/raw/archive.zip data/raw/wine-reviews.csv report.Rmd

data/raw/archive.zip: 
	mkdir -p ./data/raw  && curl -L -o ./data/raw/archive.zip https://www.kaggle.com/api/v1/datasets/download/zynicide/wine-reviews

data/raw/wine-reviews.csv: data/raw/archive.zip
	unzip data/raw/archive.zip -d data/raw/extract && mv data/raw/extract/winemag-data-130k-v2.csv data/raw/wine-reviews.csv && rm -rf data/raw/archive.zip data/raw/extract/

report.Rmd: 
	touch report.Rmd

.PHONY: clean

clean:
	rm -rf data/ && rm -f report.Rmd