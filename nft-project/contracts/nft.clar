(define-constant contract-owner tx-sender)

(define-constant token-name "Hammed NFT")
(define-constant token-symbol "HAMNFT")

(define-map token-owners
  { token-id: uint }
  { owner: principal }
)

(define-data-var total-supply uint u0)

(define-public (mint (token-id uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err u100)) ;; Only contract owner can mint
    (asserts! (is-none (map-get? token-owners { token-id: token-id })) (err u101)) ;; Token ID must be unique
    (map-set token-owners { token-id: token-id } { owner: recipient })
    (var-set total-supply (+ (var-get total-supply) u1))
    (ok true)
  )
)

(define-public (transfer (token-id uint) (recipient principal))
  (let ((current (map-get? token-owners { token-id: token-id })))
    (match current
      token-data
        (begin
          (asserts! (is-eq tx-sender (get owner token-data)) (err u102)) ;; Only current owner can transfer
          (map-set token-owners { token-id: token-id } { owner: recipient })
          (ok true)
        )
      (err u103)
    )
  )
)

(define-read-only (get-owner (token-id uint))
  (match (map-get? token-owners { token-id: token-id })
    token-data (ok (get owner token-data))
    (err u104)
  )
)

(define-read-only (get-total-supply)
  (ok (var-get total-supply))
)
