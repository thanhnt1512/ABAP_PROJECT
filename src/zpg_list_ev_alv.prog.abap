*&---------------------------------------------------------------------*
*& Report ZPG_LIST_EV_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_list_ev_alv.
DATA t_eve TYPE slis_t_event.
TYPES :BEGIN OF tt_test,
         a TYPE int4,
         b TYPE char1,
       END OF tt_test.
DATA :lt_test TYPE TABLE of tt_test.
APPEND INITIAL LINE TO lt_test ASSIGNING FIELD-SYMBOL(<fs_test>).
<fs_test>-a = 23.
<fs_test>-b = 'X'.
CALL FUNCTION 'ZFMTEST'
  EXPORTING
    test_tab_in       = lt_test
* IMPORTING
*   TEST_TAB          =
          .


CALL FUNCTION 'REUSE_ALV_EVENTS_GET'
  EXPORTING
    i_list_type     = 0
  IMPORTING
    et_events       = t_eve
  EXCEPTIONS
    list_type_wrong = 1
    OTHERS          = 2.

WRITE 'ok'.
