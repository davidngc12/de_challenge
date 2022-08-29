FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y python3.6
RUN apt-get install -y python3-pip
RUN apt-get install -y libpq-dev
RUN python3.6 -m pip install pip --upgrade
RUN python3.6 -m pip install wheel

WORKDIR /app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

#CMD ["python", "main.py"]
CMD ["/bin/bash"]