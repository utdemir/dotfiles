build:
	darwin-rebuild build --flake '.#mosscap'

switch:
	sudo darwin-rebuild switch --flake '.#mosscap'
