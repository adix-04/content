# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

cat > /etc/profile.d/tmout.sh <<'EOF'
# Terminate idle interactive shells after 15 minutes
TMOUT=900
readonly TMOUT
export TMOUT
EOF
chmod 0644 /etc/profile.d/tmout.sh