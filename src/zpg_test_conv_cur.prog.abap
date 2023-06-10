*&---------------------------------------------------------------------*
*& Report ZPG_TEST_CONV_CUR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPG_TEST_CONV_CUR.
DATA :lw_curr TYPE char10,
      lw_curr1 TYPE char23,
      lw_conv TYPE fins_vhcur12.
lw_curr = '1232'.
lw_conv = lw_curr.
WRITE lw_curr To lw_curr1 CURRENCY 'VND'.
WRITE lw_conv.
