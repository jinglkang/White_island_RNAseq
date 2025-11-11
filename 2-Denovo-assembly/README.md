# Transcriptome de novo assembly for the four species
## use DRAP v.1.92
```bash
export SHARED_DIR=$PWD
function docker_drap_cmd { echo "docker run --rm -e LOCAL_USER_ID=`id -u $USER` -u 1003:1003 -v $SHARED_DIR:$SHARED_DIR -w `pwd` sigenae/drap "; }
# 1. crested blenny
docker_drap_cmd`runDrap -o Blenny_runDrap -R1 Blenny*_1.fastq.gz -R2 Blenny*_2.fastq.gz -s FR --dbg trinity --dbg-mem 400 --no-trim --norm-mem 400 --no-rate --write
`docker_drap_cmd`runDrap -o Blenny_runDrap \
         -1 Blenny*_1.fastq.gz\
         -2 Blenny*_2.fastq.gz\
         -s FR --dbg trinity \
         --dbg-mem 400 --no-trim --norm-mem 400 --no-rate --run

# 2. blue-eyed triplefin
docker_drap_cmd`runDrap -o Blueeyed_runDrap -R1 Blueeyed*_1.fastq.gz -R2 Blueeyed*_2.fastq.gz -s FR --dbg trinity --dbg-mem 400 --no-trim --norm-mem 400 --no-rate --write
`docker_drap_cmd`runDrap -o Blueeyed_runDrap \
         -1 Blueeyed*_1.fastq.gz\
         -2 Blueeyed*_2.fastq.gz\
         -s FR --dbg trinity \
         --dbg-mem 400 --no-trim --norm-mem 400 --no-rate --run

# 3. common triplefin
docker_drap_cmd`runDrap -o Common_runDrap -R1 Common*_1.fastq.gz -R2 Common*_2.fastq.gz -s FR --dbg trinity --dbg-mem 400 --no-trim --norm-mem 400 --no-rate --write
`docker_drap_cmd`runDrap -o Common_runDrap \
         -1 Common*_1.fastq.gz\
         -2 Common*_2.fastq.gz\
         -s FR --dbg trinity \
         --dbg-mem 400 --no-trim --norm-mem 400 --no-rate --run

# 4. Yaldwin's triplefin
docker_drap_cmd`runDrap -o Yaldwin_runDrap -R1 Yaldwin*_1.fastq.gz -R2 Yaldwin*_2.fastq.gz -s FR --dbg trinity --dbg-mem 400 --no-trim --norm-mem 400 --no-rate --write
`docker_drap_cmd`runDrap -o Yaldwin_runDrap \
         -1 Yaldwin*_1.fastq.gz\
         -2 Yaldwin*_2.fastq.gz\
         -s FR --dbg trinity \
         --dbg-mem 400 --no-trim --norm-mem 400 --no-rate --run         
```
