-include .env
deploy:
	forge script script/DeployMyToken.s.sol --rpc-url $(RPC2)  --etherscan-api-key $(SCAN) --broadcast --verify