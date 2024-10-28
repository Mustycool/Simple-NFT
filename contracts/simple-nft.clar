
;; title: simple-NFT
;; desc: This is a simple NFT minting smart contract that adheres to the SIP-009 traits

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Constants, Variables and Maps ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-non-fungible-token simple-nft uint)

(define-constant nft-creator tx-sender)

(define-constant simple-nft-price u10000000)

(define-constant collection-limit u100)

(define-constant collection-root-url "ipfs://simple/nft/collection/")

(define-data-var collection-index uint u0)


;;;;;;;;;;;;;;;;;;;;;;;;
;;;; SIP-009 TRAITS ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;

(define-public (get-last-token-id)
    (ok (var-get collection-index))
)

(define-public (get-token-uri (id uint))
    (ok (some (concat
        collection-root-url
        (concat (int-to-ascii id) ".json")
        ))
    )
)

(define-public (get-owner (id uint))
    (ok (nft-get-owner? simple-nft id))
)

(define-public (transfer (id uint) (sender principal) (recipient principal))
    (begin
        (asserts! (is-eq tx-sender sender) (err "u0"))
        (ok (nft-transfer? simple-nft id sender recipient))
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; SIMPLE-NFT CORE ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

(define-public (mint-simple-nft)
    (let
        (
            (current-index (var-get collection-index))
            (next-index (+ current-index u1))
        )
        (asserts! (<= current-index collection-limit) (err u1))
        (unwrap!
            (stx-transfer? simple-nft-price tx-sender (as-contract tx-sender))
            (err u2)
        )
        (unwrap! (nft-mint? simple-nft next-index tx-sender) (err u3))
        (ok (var-set collection-index next-index))
    )
)