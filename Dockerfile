FROM docker.io/library/python:3.12-alpine
RUN mkdir -p /tmp/httproot && echo "OK - hermes probe" > /tmp/httproot/index.html
EXPOSE 8642
CMD ["python3","-m","http.server","8642","--directory","/tmp/httproot"]
