#!/bin/bash
if [ "$1" == "" ] || [ $1 == "-h" ] || [ $1 == "--help" ]
then

printf "\nO programa realiza um parsing do html de uma pagina buscando todos os links que ela possui e exibe cada um deles junto ao seu endereço IP"

printf "\n\nModo de usar: \n"
echo "$0 'adress.com.br' para exibir a saída na tela "
echo "$0 'adress.com.br' -o 'file' para direcionar a saída para um arquivo"
printf "\n"

else

index="$(wget -qO- $1)"

if [ "$index" == "" ]
then 
echo "Não foi possível encontrar o endereço $1"


else

bool=false


hosts=$(echo "$index" | grep -a href | cut -d '/' -f3 | grep '\.' | cut -d '"' -f1 |  grep -v '<l' | sort -u | uniq )


if [ "$2" == '-o' ]
then
if [ "$3" == '' ]
then

echo "Especifique o arquivo a ser guardado!"
exit 1



bool=true;
echo "" > $3 

fi
fi
for i in $hosts
do
ip="$(host $i 2>/dev/null | grep -v 'not found' | grep -v 'alias' | grep -v 'handled' | grep -v 'IPv6'| cut -d ' ' -f4)"

if [ "$ip" != " " ] && [ "$ip" != "" ]
then


for ips in $ip 
do

if [ "$bool" == true ]
then

echo "Address: $i has IP: $ips" >> $3

else
echo "Address: $i has IP: $ips"

fi

done

fi
done
#for i in hosts
#do
#echo $(host "$hosts")
#done

fi




fi