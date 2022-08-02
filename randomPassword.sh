echo -n "Password length?: "
read length
</dev/urandom tr -dc '0123456789!?@#$%&abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' | head -c$length; echo ""
