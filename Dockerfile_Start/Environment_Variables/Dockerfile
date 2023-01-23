FROM ubuntu:latest
RUN apt-get update && \
    apt-get install -y python3
ENV NAME Gabriel 
COPY hello_world2.py .
ENTRYPOINT ["python3", "hello_world2.py"]
