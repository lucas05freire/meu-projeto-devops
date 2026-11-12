#!/bin/bash
# healthcheck.sh - verifica a saude basica da maquina
set -e
echo "=== Health Check - $(hostname) - $(date '+%d/%m/%Y %H:%M') ==="

# 1) Internet: o ping respondeu?
if ping -c 1 ubuntu.com > /dev/null 2>&1; then
    echo "[OK] Internet"
else
    echo "[FALHA] Internet"
fi

# 2) Disco: acima de 80% de uso, alerta
USO_DISCO=$(df / --output=pcent | tail -1 | tr -d ' %')
if [ "$USO_DISCO" -lt 80 ]; then
    echo "[OK] Disco: ${USO_DISCO}% usado"
else
    echo "[FALHA] Disco: ${USO_DISCO}% usado (acima de 80%!)"
fi

echo "=== Fim do health check ==="

# 3) Memória disponível
echo "[OK] Memoria disponivel: $(free -m | grep Mem | awk '{print $7}') MB"

# 4) Processos
ps aux | wc -l

# 5) Validação de site
SITE=${1:-ubuntu.com}
ping -c 1 "$SITE"
