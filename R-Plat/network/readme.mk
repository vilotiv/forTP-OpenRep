for TP Rplat


nmcli c m p3p1 ethernet.mtu 9000;nmcli c m p3p2 ethernet.mtu 9000;nmcli c m id bnd1 ethernet.mtu 9000;nmcli c m id bnd1 bond.options xmit_hash_policy=layer3+4;systemctl restart NetworkManager
