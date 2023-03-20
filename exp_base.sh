#!/bin/bash
# Versao 1.3
# Criador: Aline Carvalho
# Criacao: 25/07/2012
# Objetivo: Verificar o export da Base NFe
# 0 = Parametro nao informado
# 1 = Arquivo inexistente
# 2 = Ok
# 3 = Erro

### Verifica se estou recebendo parametro ou nao
if [ $# -eq 0 ]; then
        echo "0"
elif [ $# -gt 1 ]; then
        echo "0"
elif [ $1 = "discovery" ]; then
        for BKP in $(/usr/bin/find /tmp -type f -iname '*logico*.log');
        do
                FINAL="$FINAL,"'{"{#DBEXPORT}":"'$BKP'"}'
        done
        echo '{"data":['${FINAL#,}' ]}'
else
        RESP=$1

        ### Verifica se o arquivo existe
        if [ ! -e $RESP ]; then
                echo "1"
	else
                ### Verifica se o arquivo foi criado a menos de 1 dia. E se foi exportado com sucesso
                if grep -E -i 'successfully|completed|sucesso' $RESP  > /dev/null 2>&1
                then
                        echo "2"
                else
                        echo "3"
                fi
        fi
fi

