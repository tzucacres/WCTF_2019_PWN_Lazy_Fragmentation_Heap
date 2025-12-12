\
        LazyFragmentationHeap - Docker package (UID/GID configured)
        ==========================================================

        Esta versão do pacote foi gerada para usar UID=1000 e GID=1000 no container,
        para que os arquivos criados no volume montado apareçam com permissões amigáveis
        ao seu usuário no host (UID/GID 1000).

        Conteúdo
        -------
        - VM Windows - https://drive.google.com/file/d/1seI7J-XO7EWqVk3jAzJ4knL1ljHF01ee/view?usp=sharing
        - Dockerfile
        - entrypoint.sh
        - docker-compose.yml
        - .env.example
        - exp_auto.py (exemplo de exploit helper placeholder)

        Instruções rápidas
        -----------------
        1. Copie este diretório para o host/VM onde quer rodar o container, por exemplo:
           ~/Documentos/docker/pwn

        2. Crie a pasta de trabalho onde está seu exploit e coloque `exp_auto.py` lá:
           mkdir -p ~/Documentos/docker/pwn/work
           cp /caminho/para/exp_auto.py ~/Documentos/docker/pwn/work/

        3. Ajuste o .env (ou crie .env a partir do .env.example) com o LOCAL_PATH absoluto:
           cp .env.example .env
           # edite .env e adapte LOCAL_PATH

        4. Build + Run:
           docker-compose build --no-cache
           docker-compose up -d

        5. Entrar no container:
           docker-compose exec pwn bash
           # dentro de /work (montado):
           ls -la /work
           python3 exp_auto.py run

        Notas
        ----
        - O compose usa `network_mode: host` para permitir conectar nas VMs KVM (192.168.122.0/24).
        - O entrypoint faz chown para UID 1000:1000 para evitar problemas de permissão
          quando o host user tem UID 1000 (como no seu caso).
        - Se seu usuário tiver UID/GID diferente de 1000, substitua os valores no entrypoint.sh
          ou me diga os valores para eu gerar outra versão.
