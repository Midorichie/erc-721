# Hammed NFT — ERC-721 NFT Smart Contract on Stacks

A non-fungible token (NFT) contract built with Clarity for the Stacks blockchain. This implements minting, transferring, burning, and querying unique tokens.

---

## 🚀 Phase 2 Updates

- 🔧 Added burn functionality
- 🧮 Track token count per owner using a new map
- 🧪 Add test for token count after minting and burning
- 🛡 Introduced `minter` role for mint authorization
- 🧩 Added event logs for mint/transfer/burn
- 🧠 Added `nft-utils` contract for ownership checks
- ✅ Added Clarinet-based test suite

---

## 📁 Project Structure

- `contracts/nft.clar` — Main contract
- `contracts/nft-utils.clar` — Helper utilities
- `tests/nft_test.ts` — Clarinet test suite
- `Clarinet.toml` — Clarinet config

---

## 🧪 Run Tests

```bash
clarinet test
🧠 Contract Functions
Function	Type	Description
mint	Public	Mint NFT to recipient (minter only)
| `get-token-count(user)` | Read-only | Returns the number of tokens owned by a principal |
transfer	Public	Send token to another address
burn	Public	Destroy an NFT (only by token owner)
get-owner	Read-only	Check the owner of a specific token
get-total-supply	Read-only	Get total number of minted NFTs
set-minter	Public	Assign a new authorized minter

🔐 Error Codes
u100 — Unauthorized minter

u101 — Token already exists

u102 — Unauthorized transfer

u103 — Token doesn't exist

u104 — Owner not found

u105 — Only owner can burn

u106 — Token not found

u110 — Only current minter can assign a new minter

📄 License
MIT

yaml
Copy
Edit

---

## ✅ Next Steps (Optional Enhancements)

- Add on-chain metadata (name, description, image URL)
- Approval mechanisms (for marketplaces)
- Batch minting
- Frontend integration with Stacks.js
