# Quadlets are a way to run podman containers on Linux with systemd

For exampe the factorio.container

```
[Container]
ContainerName=factorio
Image=docker.io/factoriotools/factorio
PublishPort=34197:34197/udp
PublishPort=27015:27015/tcp
Volume=/home/flo/factorio:/factorio:z

[Service]
Restart=always
```

Create the directory where the data is stored (saves and config)
`mkdir /home/flo/factorio`

To run this on your machine use

podman quadlet install factorio.container

after that you can start the container

systemctl --user start factorio

the command `podman quadlet list`

[Bazzite Docs - Quadlet](https://docs.bazzite.gg/Installing_and_Managing_Software/Quadlet/#video-tutorial)
