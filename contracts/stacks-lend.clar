;; StacksLend: Decentralized Credit-Based Lending Protocol
;;
;; A Bitcoin-native microfinance protocol on Stacks that enables 
;; collateralized lending with dynamic interest rates and credit scoring.
;;
;; This contract allows users to:
;; - Build credit scores through consistent loan repayments
;; - Request loans with collateral requirements that decrease as credit improves
;; - Receive better interest rates as their credit score increases
;; - Build financial reputation in a decentralized manner

;; Constants

;; Contract ownership
(define-constant CONTRACT-OWNER tx-sender)

;; Error codes
(define-constant ERR-UNAUTHORIZED (err u1))
(define-constant ERR-INSUFFICIENT-BALANCE (err u2))
(define-constant ERR-INVALID-AMOUNT (err u3))
(define-constant ERR-LOAN-NOT-FOUND (err u4))
(define-constant ERR-LOAN-DEFAULTED (err u5))
(define-constant ERR-INSUFFICIENT-SCORE (err u6))
(define-constant ERR-ACTIVE-LOAN (err u7))
(define-constant ERR-NOT-DUE (err u8))
(define-constant ERR-INVALID-DURATION (err u9))
(define-constant ERR-INVALID-LOAN-ID (err u10))

;; Credit score thresholds
(define-constant MIN-SCORE u50) ;; Minimum possible credit score
(define-constant MAX-SCORE u100) ;; Maximum possible credit score
(define-constant MIN-LOAN-SCORE u70) ;; Minimum score required to request a loan

;; Data Maps

;; Tracks user credit scores and loan history
(define-map UserScores
  { user: principal }
  {
    score: uint,
    total-borrowed: uint,
    total-repaid: uint,
    loans-taken: uint,
    loans-repaid: uint,
    last-update: uint,
  }
)

;; Stores all loan data
(define-map Loans
  { loan-id: uint }
  {
    borrower: principal,
    amount: uint,
    collateral: uint,
    due-height: uint,
    interest-rate: uint,
    is-active: bool,
    is-defaulted: bool,
    repaid-amount: uint,
  }
)

;; Maps users to their active loans
(define-map UserLoans
  { user: principal }
  { active-loans: (list 20 uint) }
)

;; Variables

;; Counter for loan IDs
(define-data-var next-loan-id uint u0)

;; Total STX locked as collateral in the contract
(define-data-var total-stx-locked uint u0)