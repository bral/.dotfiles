if [[ ! -x `which n` ]]; then
  manage install visionmedia/n
fi

if [[ ! -x `which node` ]]; then
  n latest
fi

# Install useful deps

npm install -g serve
npm install -g mocha
npm install -g nr
