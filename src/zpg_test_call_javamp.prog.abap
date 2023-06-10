*&---------------------------------------------------------------------*
*& Report ZPG_TEST_CALL_JAVAMP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPG_TEST_CALL_JAVAMP.
*TRY.
DATA(instance) = new ZCO_SI_TEST_JV_IN( ).
DATA :ls_in TYPE ZMT_TEST_JV_IN.
DATA :ls_out TYPE ZMT_TEST_JV_OUT.
ls_in-mt_test_jv_in-data = 4.
CALL METHOD instance->si_test_jv_in
  EXPORTING
    output = ls_in
  IMPORTING
    input  = ls_out
    .
* CATCH cx_ai_system_fault .
*ENDTRY.
