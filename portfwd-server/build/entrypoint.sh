#!/bin/bash

set -e

# We read this environment variable, even if it's for sshset, because we
# need it later in this script
readonly sshset_data_dir=${SSHSET_DATA_DIR:-/opt/sshset/data}

################################################################################

if [ "$EUID" = 0 ]; then
    users=$(find "$sshset_data_dir" -mindepth 2 -maxdepth 2 \
        -type d -path "$sshset_data_dir/users/*" -printf '%f\n')
    while IFS= read -r user || [ -n "$user" ]; do
        if ! id "$user" >/dev/null 2>&1; then # If the user doesn't exist
            user_cfg=$sshset_data_dir/users/$user/user.cfg

            user_uid=''; user_gid=''
            if [ -e "$user_cfg" ]; then
                user_uid=$(sed -En 's/^uid=(.+)$/\1/p' "$user_cfg")
                user_gid=$(sed -En 's/^gid=(.+)$/\1/p' "$user_cfg")
            fi
            : "${user_uid:=auto}" "${user_gid:=$user_uid}"

            ####################################################################

            args_pre_user=()

            if [ "$user_gid" != auto ] && [ "$user_gid" != "$user_uid" ]; then
                echo "portfwd-server: creating group $user (ID $user_gid)"
                addgroup -g"$user_gid" "$user"

                args_pre_user+=(-G"$user")
            fi

            [ "$user_uid" = auto ] || args_pre_user+=(-u"$user_uid")

            echo "portfwd-server: creating user $user (ID $user_uid)"
            adduser "${args_pre_user[@]}" -D "$user"

            ####################################################################

            # Needed because the OpenSSH Server does not use PAM by default on
            # Alpine Linux, so users with the password field set
            # to "!" in /etc/shadow are considered disabled
            echo "$user:*" | chpasswd -e
        fi
    done < <(printf '%s' "$users")
fi

################################################################################

bash /opt/sshset/main.sh

################################################################################

if [ "$EUID" = 0 ]
    then readonly sshd_config_d=/etc/ssh/sshd_config.d
    else readonly sshd_config_d=~/.ssh/sshd_config.d
fi

install -DTvm644 /dev/stdin "$sshd_config_d/90-portfwd-server.conf" << 'EOF'
LogLevel VERBOSE

PermitRootLogin no

PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
PasswordAuthentication no

# Disable almost every service globally
AllowAgentForwarding no
AllowStreamLocalForwarding no
AllowTcpForwarding no
GatewayPorts no
X11Forwarding no
PermitTunnel no
PermitListen none
PermitOpen none
PermitTTY no
ForceCommand echo "This SSH server can only be used for port forwarding"

ClientAliveInterval 30

# Don't look up the remote host name. This usually results in
# faster connection times
UseDNS no
EOF

################################################################################

if [ "$EUID" = 0 ]
    then exec /usr/sbin/sshd -De "$@"
    else exec /usr/sbin/sshd -Def ~/.ssh/sshd_config "$@"
fi
