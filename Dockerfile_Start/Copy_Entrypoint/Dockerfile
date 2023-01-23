FROM ubuntu:latest
RUN apt-get update && \
    apt-get install -y python3 
COPY hello_world.py .
ENTRYPOINT ["python3", "hello_world.py"]
