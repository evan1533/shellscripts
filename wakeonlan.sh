# Shows networking with bash (/dev/udp)
# Shows interpreting hex strings as bytes
# 30:5A:3A:47:CD:D0

BCASTIP=${1}
WOLPORT=7

MAGIC="\xff\xff\xff\xff\xff\xff"

MAC=$(echo ${2} | tr ':' ' ')
# Expects mac address to be punctuated by colons ':', transforms
# these to spaces so that FOR will split it up correctly
SUBMAGIC=""
for L in ${MAC}
do
  SUBMAGIC=${SUBMAGIC}"\x"${L}
done
for r in {1..16}
do
  MAGIC=${MAGIC}${SUBMAGIC}
done

echo ${MAGIC}
# echo -e ${MAGIC} >/dev/udp/${BCASTIP}/${WOLPORT}
# Should work, doesn't because of bash version on mac

echo -e ${MAGIC} | nc -u ${BCASTIP} ${WOLPORT}
# uses netcat
