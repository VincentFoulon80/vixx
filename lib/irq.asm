!ifndef irq_handler {
    !serious "missing platform irq_handler address!"
}

; Initializes IRQ handler and store a backup of Kernal's IRQ handler
; params:
;     16b kernal_irq_addr: address where to store the backup of kernal's irq handler
;     16b custom_irq_addr: address where the irq handler should jump
!macro fn_irq_init .kernal_irq_addr, .custom_irq_addr {
    lda irq_handler         ; \
    sta .kernal_irq_addr    ;  |- store kernal irq
    lda irq_handler+1       ;  |
    sta .kernal_irq_addr+1  ; /

    lda #<.custom_irq_addr  ; \
    sta irq_handler         ;  |- loads our custom irq
    lda #>.custom_irq_addr  ;  |
    sta irq_handler+1       ; /
}

; Restore the Kernal's IRQ handler
; params:
;     16b kernal_irq_addr: address where the backup of kernal's irq handler is stored
!macro fn_irq_restore .kernal_irq_addr {
    lda #<.kernal_irq_addr  ; \
    sta irq_handler         ;  |- restore back the irq
    lda #>.kernal_irq_addr  ;  |
    sta irq_handler+1       ; /
}