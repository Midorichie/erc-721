(define-constant token-name "Hammed NFT")
(define-constant token-symbol "HAMNFT")

;; Maps
(define-map token-owners
  { token-id: uint }
  { owner: principal }
)

(define-map owner-token-count
  { owner: principal }
  { count: uint }
)

;; Variables
(define-data-var total-supply uint u0)
(define-data-var minter principal tx-sender)

;; MINT
(define-public (mint (token-id uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender (var-get minter)) (err u100))
    (asserts! (is-none (map-get? token-owners { token-id: token-id })) (err u101))
    (map-set token-owners { token-id: token-id } { owner: recipient })
    (var-set total-supply (+ (var-get total-supply) u1))
    (asserts! (is-ok (update-owner-count recipient u1 false)) (err u102))
    (print { event: "mint", token-id: token-id, to: recipient })
    (ok true)
  )
)

;; TRANSFER
(define-public (transfer (token-id uint) (recipient principal))
  (let ((current (map-get? token-owners { token-id: token-id })))
    (match current
      token-data
        (begin
          (asserts! (is-eq tx-sender (get owner token-data)) (err u103))
          (map-set token-owners { token-id: token-id } { owner: recipient })
          (asserts! (is-ok (update-owner-count tx-sender u1 true)) (err u104))
          (asserts! (is-ok (update-owner-count recipient u1 false)) (err u105))
          (print { event: "transfer", token-id: token-id, to: recipient })
          (ok true)
        )
      (err u106)
    )
  )
)

;; BURN
(define-public (burn (token-id uint))
  (let ((owner-data (map-get? token-owners { token-id: token-id })))
    (match owner-data
      token
        (begin
          (asserts! (is-eq tx-sender (get owner token)) (err u107))
          (map-delete token-owners { token-id: token-id })
          (var-set total-supply (- (var-get total-supply) u1))
          (asserts! (is-ok (update-owner-count tx-sender u1 true)) (err u108))
          (print { event: "burn", token-id: token-id })
          (ok true)
        )
      (err u109)
    )
  )
)

;; PRIVATE: update-owner-count
(define-private (update-owner-count (owner principal) (amount uint) (is-subtract? bool))
  (let (
    (current (map-get? owner-token-count { owner: owner }))
    (existing-count (match current count-data (get count count-data) u0))
    (new-count (if is-subtract?
                    (if (>= existing-count amount)
                        (- existing-count amount)
                        u0)
                    (+ existing-count amount)))
  )
    (begin
      (if (is-eq new-count u0)
        (map-delete owner-token-count { owner: owner })
        (map-set owner-token-count { owner: owner } { count: new-count })
      )
      (ok true)
    )
  )
)

;; READ-ONLY: get owner of a token
(define-read-only (get-owner (token-id uint))
  (match (map-get? token-owners { token-id: token-id })
    token-data (ok (get owner token-data))
    (err u200)
  )
)

;; READ-ONLY: get total supply
(define-read-only (get-total-supply)
  (ok (var-get total-supply))
)

;; READ-ONLY: get how many tokens a user owns
(define-read-only (get-token-count (user principal))
  (match (map-get? owner-token-count { owner: user })
    data (ok (get count data))
    (ok u0)
  )
)

;; ADMIN: set new minter
(define-public (set-minter (new-minter principal))
  (begin
    (asserts! (is-eq tx-sender (var-get minter)) (err u110))
    (var-set minter new-minter)
    (ok true)
  )
)
