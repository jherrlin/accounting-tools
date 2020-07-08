function konton() { return FILENAME ~ /bas-konton.txt/ }
function ledger() { return FILENAME ~ /.ledger/}

BEGIN                 { FS="|"; d="Debet"; k="Kredit"}
konton()              { accounts[$1]=$2 }
ledger() && FS == "|" { FS=" " }
ledger() && $0 ~ /include/ { next }   # Skip include lines
ledger() && $1 ~ /^[0-9]:/ \
{
    if       (substr($1, 0, 1) == 1 && substr($2, 0, 1) == "-") { type=k }
    else if  (substr($1, 0, 1) == 1 && substr($2, 0, 1) != "-") { type=d }

    else if  (substr($1, 0, 1) == 2 && substr($2, 0, 1) == "-") { type=k }
    else if  (substr($1, 0, 1) == 2 && substr($2, 0, 1) != "-") { type=d }

    else if  (substr($1, 0, 1) == 3 && substr($2, 0, 1) == "-") { type=k }
    else if  (substr($1, 0, 1) == 3 && substr($2, 0, 1) != "-") { type=d }

    else if  (substr($1, 0, 1) >= 4 && substr($1, 0, 1) <= 8 && substr($2, 0, 1) == "-") { type=k }
    else if  (substr($1, 0, 1) >= 4 && substr($1, 0, 1) <= 8 && substr($2, 0, 1) != "-") { type=d }
}
ledger() && $1  ~ /^[0-9]:/  { a=$1; gsub(":", "", a); printf("%s ; %4s ; %-6s ; %s\n", $0, a, type, accounts[a]) }
ledger() && $1 !~ /^[0-9]:/  { print }
