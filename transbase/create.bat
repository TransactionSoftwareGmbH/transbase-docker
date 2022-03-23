rem docker build -t transbase .
docker create --name transbase transbase
docker cp tblic.ini transbase:/opt/transbase
docker commit transbase transbase
