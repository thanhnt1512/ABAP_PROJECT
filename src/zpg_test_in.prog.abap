*&---------------------------------------------------------------------*
*& Report ZPG_TEST_IN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPG_TEST_IN.
data :lw_pc_sq  TYPE numc3,
      lw_pc         TYPE prctr,
      lw_pc_new         TYPE prctr.
lw_pc = 'P1140H05'.
lw_pc_sq = lw_pc+5(3).
*lw_pc_sq  = lw_pc_sq  + 1.
WRITE lw_pc_sq.
