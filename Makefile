build:
	darwin-rebuild build --flake '.#mosscap'

switch:
	sudo -E darwin-rebuild switch --flake '.#mosscap'
