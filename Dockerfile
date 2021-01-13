FROM python:3.8

ADD notifier.py requirements.txt /
VOLUME /config
VOLUME /gifs
VOLUME /data

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y ffmpeg

RUN pip install -r /requirements.txt

ENTRYPOINT ["/usr/bin/env"]
CMD ["python3", "/notifier.py"]