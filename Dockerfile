# Note, this does not work with default 2GB of RAM
FROM python:3.6-stretch
RUN apt-get update && apt-get install -y build-essential apt-utils
RUN apt-get install -y libhdf5-serial-dev libhdf5-dev

# for improved caching
ADD requirements.txt /rasa/requirements.txt
WORKDIR /rasa
RUN pip install -r requirements.txt

# install spacy languages
RUN python -m spacy download en

# add the rest of the project
ADD . /rasa
RUN make train-nlu
RUN make train-core