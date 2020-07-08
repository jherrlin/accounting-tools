BEGIN { ledger="ledger.ledger"; basfile="bas-konton.txt"}
$0 ~ /^#KONTO/ { kod=$2; $1=$2=""; gsub(/^\s*"|".*$/, "", $0); printf("%s|%s\n", kod, $0) > basfile }
$0 ~ /^}/ { printf("\n") > ledger }
$0 ~ /^{/ { next }
$0 ~ /^#VER/ \
{
    gsub(/\r$|"/, "", $0);
    datetime=$NF;
    v=$3;
    $1=$2=$3=$4=$NF="";
    gsub(/^\s*/, "", $0);
    split(datetime, d, "")
    printf("%s%s%s%s-%s%s-%s%s * %s\n%6s :verification-nr:%s\n", d[1], d[2], d[3], d[4], d[5], d[6], d[7], d[8], $0, ";;", v) > ledger
}
$1 ~ /^#TRANS/ { $1=$3=""; split($2, a, ""); gsub(/\r$/, "", $4); printf("%5s:%s:%s:%s%41s SEK\n", a[1], a[2], a[3], a[4], $4) > ledger }
