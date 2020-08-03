default: build

build:
	echo "[+] Building"

install:
	echo "[+] Installing"

clean:
	echo "[+] Cleaning Up"
  
	brew cleanup
	rm -f -r /Library/Caches/Homebrew/*
	rm -f -r ~/Library/Caches/Homebrew/*

	yarn cache clean
	npm cache clean --force

	rm -rf ~/Library/Caches/pip
