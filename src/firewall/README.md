
# Firewall Configuration

## ipv4 activate for session.
cat /etc/iptables/src-yourFile | sudo iptables-restore

## ipv4 store current session as default.
sudo iptables-save | sudo tee /etc/iptables/rules.v4

