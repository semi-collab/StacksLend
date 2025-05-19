# 🟧 StacksLend: Decentralized Credit-Based Lending Protocol

**StacksLend** is a Bitcoin-native microfinance protocol built on [Stacks](https://stacks.co), enabling **collateralized lending with dynamic credit scoring**. It brings traditional credit principles to decentralized finance (DeFi), powered by Clarity smart contracts and secured by Bitcoin finality.

## 🚀 Key Features

* 📈 **On-Chain Credit Scoring**
  Users build or lose reputation based on repayment behavior. Score influences borrowing power.

* 🔒 **Collateral Optimization**
  Collateral requirements drop as user credit improves—starting from 50% down to 25%.

* 📉 **Risk-Based Interest Rates**
  Interest rates decrease as credit score increases (10% → 5%).

* ⚡ **Bitcoin Final Settlement**
  Built on Stacks L1, anchored to Bitcoin for ultimate security.

* 🧾 **Transparent Defaults**
  Loans marked default after due date; collateral is auto-liquidated and credit penalized.

## 🧠 Smart Contract Overview

### ✅ Public Functions

| Function              | Description                                                     |
| --------------------- | --------------------------------------------------------------- |
| `initialize-score`    | Sets up a new user's credit profile with a baseline score.      |
| `request-loan`        | Requests a loan by specifying amount, collateral, and duration. |
| `repay-loan`          | Repays a loan with principal + interest.                        |
| `mark-loan-defaulted` | Admin-only: marks overdue loans as defaulted.                   |

### 🔐 Private Functions

| Function                        | Description                                       |
| ------------------------------- | ------------------------------------------------- |
| `calculate-required-collateral` | Determines required collateral from credit score. |
| `calculate-interest-rate`       | Computes rate based on score (10% to 5%).         |
| `calculate-total-due`           | Total repayment = principal + interest.           |
| `update-credit-score`           | Adjusts score (+2 repay / -10 default).           |
| `update-user-loans`             | Tracks each user’s active loans.                  |

### 👀 Read-Only Functions

| Function                | Description                            |
| ----------------------- | -------------------------------------- |
| `get-user-score`        | Returns a user’s current credit score. |
| `get-loan`              | Fetches loan details by ID.            |
| `get-user-active-loans` | Lists all active loans for a user.     |

## 🏗️ System Architecture

```plaintext
              ┌────────────────────────┐
              │  Frontend (React + SDK)│
              └─────────┬──────────────┘
                        │
                        ▼
          ┌─────────────────────────────┐
          │ Clarity Smart Contract      │
          │    (StacksLend)             │
          ├─────────────────────────────┤
          │ UserScores | Loans | Relations │
          └─────────┬───────────────────┘
                    ▼
      ┌────────────────────────────────────┐
      │   Stacks Blockchain (Bitcoin L2)   │
      └────────────────────────────────────┘
```

## 💻 Getting Started

### Requirements

* [Clarinet](https://docs.stacks.co/docs/clarity/clarinet)
* Node.js v16+
* [Stacks.js](https://github.com/hirosystems/stacks.js)

### Setup

```bash
git clone https://github.com/semi-collab/StacksLend.git
cd StacksLend
npm install
clarinet check
clarinet test
```

## 🔧 Example Usage

### 1. Initialize User

```typescript
await makeContractCall({
  functionName: "initialize-score",
  contractAddress: "...",
  contractName: "stacks-lend",
  senderKey: "...",
});
```

### 2. Request Loan

```clojure
(request-loan u500000000 u750000000 u52560)
;; 500 STX loan, 750 STX collateral, 1 year duration
```

### 3. Repay Loan

```clojure
(repay-loan u1 u550000000)
;; Repay principal + interest for loan ID 1
```

### 4. Handle Defaults (Admin)

```clojure
(mark-loan-defaulted u1)
;; Flag loan as default after due date
```

## 🛡️ Security Model

### ✅ Protections

* **Collateral Locking**: Funds held in contract until repayment or liquidation.
* **Score Gating**: Only users with score ≥ 70 can borrow.
* **Loan Limits**: Max 5 active loans per user; max 1-year duration.
* **Reentrancy Defense**: State updates and checks precede transfers.

### 🔍 Audit Status

* [ ] Audit: Pending
* ✅ Unit Test Coverage: 87%

## 🛣️ Roadmap

| Milestone                        | Status         |
| -------------------------------- | -------------- |
| Core Lending Protocol            | ✅ Done         |
| NFT Credit Badges + UI Dashboard | 🚧 In Progress |
| Oracle Integration               | 🔜             |
| Governance Module                | 🔜             |
| Insurance Pools                  | 🔜             |

## 🤝 Contributing

We welcome contributions! Areas of focus:

* Oracle integration (external credit feeds)
* Zero-knowledge score proofs
* Flash loan prevention
* UI/UX for dashboards

## 📘 License

MIT License
Inspired by traditional credit scoring and DeFi lending (e.g., Aave, Goldfinch).
Built on [Stacks](https://stacks.co) to bring DeFi to Bitcoin.
