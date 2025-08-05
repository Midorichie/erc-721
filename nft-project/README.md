# Hammed NFT — ERC-721 Style NFT Contract on Stacks Blockchain

This project implements a simplified ERC-721-like NFT smart contract using Clarity for the Stacks blockchain. It enables minting, transferring, and querying ownership of unique digital assets.

---

## 📁 Project Structure

- `contracts/nft.clar` — The main smart contract.
- `Clarinet.toml` — Project configuration for Clarinet.
- `README.md` — Project guide and documentation.
- `tests/` — (You can add TypeScript tests here using Clarinet + Jest setup.)

---

## ⚙️ Features

- Only contract owner can mint NFTs
- Each token ID is unique (non-fungible)
- Token transfer restricted to current owner
- Track total supply and ownership

---

## 🛠 How to Run

1. **Install Clarinet** (if not already installed)  
   ```bash
   curl -sSL https://get.hiro.so/clarinet/install | bash
Initialize project

bash
Copy
Edit
clarinet new nft-project
cd nft-project
Replace default files with:

contracts/nft.clar (from this repo)

Clarinet.toml

README.md

Run Checks

bash
Copy
Edit
clarinet check
Start Console

bash
Copy
Edit
clarinet console
📤 Functions
Function	Description
mint(token-id, recipient)	Mints a unique NFT to the specified recipient. Only the contract deployer can mint.
transfer(token-id, recipient)	Transfers ownership to another address. Only the token owner can transfer.
get-owner(token-id)	Returns the owner of a specific token.
get-total-supply()	Returns total number of minted NFTs.

🔐 Error Codes
u100 — Unauthorized (only contract owner can mint)

u101 — Token already minted

u102 — Unauthorized transfer (not token owner)

u103 — Token does not exist

u104 — Owner not found
