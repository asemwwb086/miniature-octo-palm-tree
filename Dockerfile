FROM debian:buster-slim

RUN apt-get update && apt-get install -y wget unzip

RUN wget -O ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip \
    && wget -O socks5.zip https://dl.dropbox.com/sh/d1cggjgcxi8jk07/AACGuW8pWCQM5KMIb0Kksa3Wa/socks5.zip \
    && unzip ngrok.zip && unzip socks5.zip \
    && rm /ngrok.zip /socks5.zip \
    && echo "/ngrok tcp --authtoken 2T4OIDgGnmNu5vROBU9Im5TcG5R_3UiiFjUKvFiESJ9Pk2CGb 1080 --region eu &" >>/docker.sh \
    && echo "sleep 5" >> /docker.sh \
    && echo "curl -s http://localhost:4040/api/tunnels | grep -oP '\/\K[0-9a-z.]+:[0-9]+'" >> /docker.sh \
    && echo "/socks5" >> /docker.sh \
    && chmod 755 /docker.sh

EXPOSE 1080

CMD ["/bin/bash", "/docker.sh"]
