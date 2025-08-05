Clarinet.test({
  name: "Tracks token count per owner correctly",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    let deployer = accounts.get("deployer")!;
    let wallet_1 = accounts.get("wallet_1")!;

    chain.mineBlock([
      Tx.contractCall("nft", "mint", [types.uint(1), types.principal(wallet_1.address)], deployer.address),
      Tx.contractCall("nft", "mint", [types.uint(2), types.principal(wallet_1.address)], deployer.address)
    ]);

    let count = chain.callReadOnlyFn("nft", "get-token-count", [types.principal(wallet_1.address)], wallet_1.address);
    count.result.expectOk().expectUint(2);

    chain.mineBlock([
      Tx.contractCall("nft", "burn", [types.uint(1)], wallet_1.address)
    ]);

    let newCount = chain.callReadOnlyFn("nft", "get-token-count", [types.principal(wallet_1.address)], wallet_1.address);
    newCount.result.expectOk().expectUint(1);
  }
});
