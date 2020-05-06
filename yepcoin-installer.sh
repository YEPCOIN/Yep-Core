#!/bin/bash

VERSION="1.0.0"
RELEASE="https://github.com/YEPCOIN/YEPCOIN/releases/download/v1.0.0/yep-1.0.0-x86_64-linux-gnu.tar.gz"

clear

echo
echo "██╗   ██╗███████╗██████╗  ██████╗ ██████╗ ██╗███╗   ██╗"
echo "╚██╗ ██╔╝██╔════╝██╔══██╗██╔════╝██╔═══██╗██║████╗  ██║"
echo " ╚████╔╝ █████╗  ██████╔╝██║     ██║   ██║██║██╔██╗ ██║"
echo "  ╚██╔╝  ██╔══╝  ██╔═══╝ ██║     ██║   ██║██║██║╚██╗██║"
echo "   ██║   ███████╗██║     ╚██████╗╚██████╔╝██║██║ ╚████║"
echo "   ╚═╝   ╚══════╝╚═╝      ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝"
echo
echo "Welcome to the YEPCOIN masternode installer"
echo

read -p "Continue? (y/n)? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then

  clear

  echo "Paste the masternode information you got from the YEPCOIN GUI client here.."
  echo
  while read -r config
  do
    if grep -q externalip <<<"$config"; then
      externalip=${config#*=}
    fi

    if grep -q masternodeaddr <<<"$config"; then
      masternodeaddr=${config#*=}
    fi

    if grep -q masternodeprivkey <<<"$config"; then
      masternodeprivkey=${config#*=}
    fi

    if [ -n "$externalip" ] && [ -n "$masternodeaddr" ] && [ -n "$masternodeprivkey" ]; then
      break
    fi
  done

  if [ ! -d $HOME/.yep ]; then
    mkdir -p $HOME/.yep
  fi

  cat > $HOME/.yep/yep.conf << EOF
masternode=1
externalip=$externalip
masternodeaddr=$masternodeaddr
masternodeprivkey=$masternodeprivkey
EOF

  echo
  echo "Downloading client.."
  echo

  curl -L $RELEASE > $HOME/yepcoin-$VERSION.tar.gz
  tar xzf $HOME/yepcoin-$VERSION.tar.gz

  clear

  $HOME/yep-$VERSION/bin/yep-cli stop >> /dev/null 2>&1;
  $HOME/yep-$VERSION/bin/yepd -daemon

  echo
  echo "All done! Wait for the blockchain to sync and start the masternode from your local wallet."
  echo
  echo "You can check the masternodes status by running:"
  echo
  echo "  $HOME/yep-$VERSION/bin/yep-cli mnsync status"
  echo
  echo "  $HOME/yep-$VERSION/bin/yep-cli getmasternodestatus"
  echo
fi
