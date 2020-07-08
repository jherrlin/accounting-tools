BEGIN { FS=";"}
$0 ~ /^\s+[0-9]/ { acc[$2] = $4 }
END { for (a in acc) { printf("| %s | %-70s |\n", a ,acc[a]) | "sort" }}
