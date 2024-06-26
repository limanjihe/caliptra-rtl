// Generated by PeakRDL-regblock - A free and open-source SystemVerilog generator
//  https://github.com/SystemRDL/PeakRDL-regblock

package dv_reg_pkg;
    typedef struct packed{
        logic swwel;
    } dv_reg__StickyDataVaultCtrl__lock_entry__in_t;

    typedef struct packed{
        dv_reg__StickyDataVaultCtrl__lock_entry__in_t lock_entry;
    } dv_reg__StickyDataVaultCtrl__in_t;

    typedef struct packed{
        logic swwel;
    } dv_reg__StickyDataVaultEntry_w32__in_t;

    typedef struct packed{
        dv_reg__StickyDataVaultEntry_w32__in_t data;
    } dv_reg__StickyDataVaultReg__in_t;

    typedef struct packed{
        logic swwel;
    } dv_reg__NonStickyDataVaultCtrl__lock_entry__in_t;

    typedef struct packed{
        dv_reg__NonStickyDataVaultCtrl__lock_entry__in_t lock_entry;
    } dv_reg__NonStickyDataVaultCtrl__in_t;

    typedef struct packed{
        logic swwel;
    } dv_reg__NonStickyDataVaultEntry_w32__in_t;

    typedef struct packed{
        dv_reg__NonStickyDataVaultEntry_w32__in_t data;
    } dv_reg__NonStickyDataVaultReg__in_t;

    typedef struct packed{
        logic swwel;
    } dv_reg__NonStickyLockableScratchRegCtrl__lock_entry__in_t;

    typedef struct packed{
        dv_reg__NonStickyLockableScratchRegCtrl__lock_entry__in_t lock_entry;
    } dv_reg__NonStickyLockableScratchRegCtrl__in_t;

    typedef struct packed{
        logic swwel;
    } dv_reg__NonStickyLockableScratchReg__data__in_t;

    typedef struct packed{
        dv_reg__NonStickyLockableScratchReg__data__in_t data;
    } dv_reg__NonStickyLockableScratchReg__in_t;

    typedef struct packed{
        logic swwel;
    } dv_reg__StickyLockableScratchRegCtrl__lock_entry__in_t;

    typedef struct packed{
        dv_reg__StickyLockableScratchRegCtrl__lock_entry__in_t lock_entry;
    } dv_reg__StickyLockableScratchRegCtrl__in_t;

    typedef struct packed{
        logic swwel;
    } dv_reg__StickyLockableScratchReg__data__in_t;

    typedef struct packed{
        dv_reg__StickyLockableScratchReg__data__in_t data;
    } dv_reg__StickyLockableScratchReg__in_t;

    typedef struct packed{
        logic reset_b;
        logic core_only_rst_b;
        logic hard_reset_b;
        dv_reg__StickyDataVaultCtrl__in_t [10-1:0]StickyDataVaultCtrl;
        dv_reg__StickyDataVaultReg__in_t [10-1:0][12-1:0]STICKY_DATA_VAULT_ENTRY;
        dv_reg__NonStickyDataVaultCtrl__in_t [10-1:0]NonStickyDataVaultCtrl;
        dv_reg__NonStickyDataVaultReg__in_t [10-1:0][12-1:0]NONSTICKY_DATA_VAULT_ENTRY;
        dv_reg__NonStickyLockableScratchRegCtrl__in_t [10-1:0]NonStickyLockableScratchRegCtrl;
        dv_reg__NonStickyLockableScratchReg__in_t [10-1:0]NonStickyLockableScratchReg;
        dv_reg__StickyLockableScratchRegCtrl__in_t [8-1:0]StickyLockableScratchRegCtrl;
        dv_reg__StickyLockableScratchReg__in_t [8-1:0]StickyLockableScratchReg;
    } dv_reg__in_t;

    typedef struct packed{
        logic value;
    } dv_reg__StickyDataVaultCtrl__lock_entry__out_t;

    typedef struct packed{
        dv_reg__StickyDataVaultCtrl__lock_entry__out_t lock_entry;
    } dv_reg__StickyDataVaultCtrl__out_t;

    typedef struct packed{
        logic value;
    } dv_reg__NonStickyDataVaultCtrl__lock_entry__out_t;

    typedef struct packed{
        dv_reg__NonStickyDataVaultCtrl__lock_entry__out_t lock_entry;
    } dv_reg__NonStickyDataVaultCtrl__out_t;

    typedef struct packed{
        logic value;
    } dv_reg__NonStickyLockableScratchRegCtrl__lock_entry__out_t;

    typedef struct packed{
        dv_reg__NonStickyLockableScratchRegCtrl__lock_entry__out_t lock_entry;
    } dv_reg__NonStickyLockableScratchRegCtrl__out_t;

    typedef struct packed{
        logic value;
    } dv_reg__StickyLockableScratchRegCtrl__lock_entry__out_t;

    typedef struct packed{
        dv_reg__StickyLockableScratchRegCtrl__lock_entry__out_t lock_entry;
    } dv_reg__StickyLockableScratchRegCtrl__out_t;

    typedef struct packed{
        dv_reg__StickyDataVaultCtrl__out_t [10-1:0]StickyDataVaultCtrl;
        dv_reg__NonStickyDataVaultCtrl__out_t [10-1:0]NonStickyDataVaultCtrl;
        dv_reg__NonStickyLockableScratchRegCtrl__out_t [10-1:0]NonStickyLockableScratchRegCtrl;
        dv_reg__StickyLockableScratchRegCtrl__out_t [8-1:0]StickyLockableScratchRegCtrl;
    } dv_reg__out_t;

    localparam DV_REG_ADDR_WIDTH = 32'd11;

endpackage