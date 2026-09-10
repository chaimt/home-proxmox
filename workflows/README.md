Installation:

chown -R 1000:1000 /home/home/hassio/n8n 
# n8n needs a writable dir for Git / file nodes (container runs as 1000:1000)
mkdir -p /home/home/hassio/n8n/.n8n-files
chown -R 1000:1000 /home/home/hassio/n8n/.n8n-files
