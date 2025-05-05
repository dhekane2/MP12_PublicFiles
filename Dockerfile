FROM python:3.6

# Creating Application Source Code Directory
RUN mkdir -p /app

# Setting Home Directory for containers
WORKDIR /app

# Copy src python files
COPY . /app

# Install dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# create directories for models and data
RUN mkdir -p /app/models
RUN mkdir -p /app/data

# Preload data
RUN python data_preload.py

# Pretrain models
RUN DATASET=mnist TYPE=ff python train.py
RUN DATASET=mnist TYPE=cnn python train.py
RUN DATASET=kmnist TYPE=ff python train.py
RUN DATASET=kmnist TYPE=cnn python train.py

# Running Python Application
CMD ["python", "classify.py"]
