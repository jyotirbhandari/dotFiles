tftaint() {
    module="--module"
    if [ -z "$2" ]; then
        terraform taint "$1"
    else
        terraform taint $module="$1" "$2"
    fi
}

tftaint-random() {
    terraform taint --module=random_subnets random_shuffle."$1"
}

tfapply() {
    echo -e "\033[1mDo you really want to apply?\033[0m
  Terraform will apply changes to all your managed infrastructure in \033[31;1;5m`basename $PWD`\033[0m environment.
  Then following values are accepted \033[1m'yes', 'no', 'public', 'private', 'database' and 'elasticache'\033[0m.
    "
    echo -n "  Enter a value: "
    read CHOICE
    if [ $CHOICE == no ]; then
        return
    elif [ $CHOICE == yes ]; then
        terraform apply
    else
        tftaint-random "$CHOICE"; terraform apply
    fi
}

tfdestroy() {
    echo -e "Terraform will apply changes to all your managed infrastructure in \033[31;1;5m`basename $PWD`\033[0m environment"
    if [ -z "$1" ]; then
        terraform destroy
    else
        terraform destroy "$1"
    fi
}

alias tf='terraform'
alias tfshow='terraform show |less'

