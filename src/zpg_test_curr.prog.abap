*&---------------------------------------------------------------------*
*& Report ZPG_TEST_CURR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_test_curr.
DATA(lw_count) = 0.
DATA : lt_acdoca TYPE TABLE OF zst_fir048_acdoca,
       gt_knb1   TYPE TABLE OF zst_fir048_knb1,
       gt_cn     TYPE TABLE OF zev_cn,
       lt_data   TYPE TABLE OF zst_fir045.
DATA :task TYPE string.
DO 3 TIMES.
  lw_count = lw_count + 1.
  task  = |task{ lw_count }|.
*  APPEND LINES OF gt_acdoca FROM  1 TO gw_max_record TO lt_acdoca.

  CALL FUNCTION 'ZFM_FIR048_PARALLEL' STARTING NEW TASK task
    DESTINATION IN GROUP 'RFCGROUP'
    PERFORMING on_end_of_action ON END OF TASK
    EXPORTING
      due_date    = sy-datum
      due_date_n1 = sy-datum
      due_date_n2 = sy-datum
      due_date_n3 = sy-datum
      due_date_n4 = sy-datum
      due_date_n5 = sy-datum
      due_date_n6 = sy-datum
      due_date_n7 = sy-datum
      due_date_n8 = sy-datum
    TABLES
      acdoca_tab  = lt_acdoca
      knb1_tab    = gt_knb1
      cn_tab      = gt_cn
      data_tab    = lt_data.

*  DELETE gt_acdoca FROM 1 TO gw_max_record.
ENDDO.
WAIT UNTIL lw_count >= 3.
*WRITE  'hi'.

FORM on_end_of_action USING task.
  DATA :lt_data TYPE TABLE OF zst_fir045.

  RECEIVE RESULTS FROM FUNCTION 'ZFM_FIR048_PARALLEL'
   TABLES data_tab  = lt_data.

*  LOOP AT lt_data INTO DATA(ls_data).
*  LOOP AT lt_data INTO DATA(ls_data).
*    COLLECT ls_data INTO gt_data1.
*  ENDLOOP.

ENDFORM.
