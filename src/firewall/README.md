
# Firewall Configuration

## Initial Setup

  cp src-default /etc/iptables/src-default
  aptitude install iptables-persistent


## ipv4 activate for session.

  cat /etc/iptables/src-default | sudo iptables-restore


## ipv4 store current session as default.

  sudo iptables-save | sudo tee /etc/iptables/rules.v4

