#!/bin/bash
INTERVALO=5
PROTOHOST="${window.location.protocol}//${window.location.host}"
NOVNC_BIN="/var/www/html/noVNC/utils/novnc_proxy"
TEMPLATE="/var/www/html/noVNC/console_list.html.template"
HTML="/var/www/html/noVNC/console_list.html"
BASE_URL="$PROTOHOST/noVNC/vnc_lite.html?port="
echo "Monitorando múltiplas sessões VNC e atualizando console_list.html..."
echo

while true; do
    PROCESSOS=$(ps aux | grep "vnc 0.0.0.0:" | grep -v grep)

    # Limpa lista temporária de URLs
    URLS=""

    if [ -z "$PROCESSOS" ]; then

        cp "$TEMPLATE" "$HTML"
        sed -i '/<ul>/,/<\/ul>/c <ul>\n<li><a href="#">Nenhum console disponível</a></li>\n</ul>' "$HTML"

        sleep "$INTERVALO"
        continue
    fi

    echo "$PROCESSOS" | while read -r LINHA; do

        PORTA=$(echo "$LINHA" | sed -n 's/.*vnc 0\.0\.0\.0:\([0-9]*\).*/\1/p')
        NAME=$(echo "$LINHA" | sed -n 's/.*name \([A-Za-z0-9._-]*\).*/\1/p')

        if [ -z "$PORTA" ]; then
            echo "[ERRO] Porta não identificada no processo:"
            echo "$LINHA"
            continue
        fi

        LISTEN_PORT="580${PORTA}"
        VNC_PORT="590${PORTA}"
        WEB_PORT="580${PORTA}"
        PIDFILE="/tmp/novnc_${PORTA}.pid"

        # Monta URL para a página HTML
        URL="${BASE_URL}${WEB_PORT}&scale=true"
        URLS="${URLS}<li><a href=\"${URL}\" target=\"_blank\">Console ${NAME} - ${WEB_PORT} </a></li>\n"

        # Atualiza o HTML com todas as URLs encontradas
        cp "$TEMPLATE" "$HTML"

        sed -i "/<ul>/,/<\/ul>/c <ul>\n$URLS</ul>" "$HTML"

        echo "[ATUALIZADO] console_list.html atualizado."
        echo

        # Verifica se já existe noVNC rodando
        if [ -f "$PIDFILE" ]; then
            PID=$(cat "$PIDFILE")
            if ps -p "$PID" > /dev/null 2>&1; then
                echo "[OK] noVNC já ativo para porta $PORTA (PID $PID)."
                continue
            else
                echo "[INFO] PID antigo encontrado para porta $PORTA, limpando..."
                rm -f "$PIDFILE"
            fi
        fi

        # Inicia nova instância do noVNC
        echo "[INICIANDO] noVNC para porta $PORTA → listen $LISTEN_PORT → vnc localhost:$VNC_PORT"

        $NOVNC_BIN --listen "$LISTEN_PORT" --vnc "localhost:$VNC_PORT" &
        NOVNC_PID=$!

        echo "$NOVNC_PID" > "$PIDFILE"

        echo "[OK] noVNC iniciado para porta $PORTA com PID $NOVNC_PID"
    done
    sleep "$INTERVALO"
done
