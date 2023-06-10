FUNCTION ZFM_FIR048_PARALLEL_COP.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(DUE_DATE) TYPE  SY-DATUM
*"     VALUE(DUE_DATE_N1) TYPE  SY-DATUM
*"     VALUE(DUE_DATE_N2) TYPE  SY-DATUM
*"     VALUE(DUE_DATE_N3) TYPE  SY-DATUM
*"     VALUE(DUE_DATE_N4) TYPE  SY-DATUM
*"     VALUE(DUE_DATE_N5) TYPE  SY-DATUM
*"     VALUE(DUE_DATE_N6) TYPE  SY-DATUM
*"     VALUE(DUE_DATE_N7) TYPE  SY-DATUM
*"  TABLES
*"      ACDOCA_TAB STRUCTURE  ZST_FIR048_ACDOCA
*"      KNB1_TAB STRUCTURE  ZST_FIR048_KNB1
*"      CN_TAB STRUCTURE  ZEV_CN
*"      DATA_TAB STRUCTURE  ZST_FIR045
*"----------------------------------------------------------------------

  DATA :ls_data TYPE zst_fir045.
  DEFINE set_amount.
    IF &1 > &2 AND &1 <= &3.
      &4 = &5.
    ENDIF.
  END-OF-DEFINITION.
  SORT knb1_tab BY kunnr.
  SORT cn_tab BY prctr.
  LOOP AT acdoca_tab INTO DATA(ls_acdoca).
    ls_data-prctr = ls_acdoca-prctr.
    ls_data-segment = ls_acdoca-segment.
    READ TABLE cn_tab INTO DATA(ls_cn) WITH KEY prctr = ls_acdoca-segment BINARY SEARCH.
    IF sy-subrc IS INITIAL.
      ls_data-pstcode = ls_cn-pstcode.
      ls_data-ten_cn = ls_cn-ten_cn.
    ENDIF.
    ls_data-waers = 'VND'.
    ls_data-kunnr = ls_acdoca-kunnr.
    READ TABLE knb1_tab INTO DATA(ls_knb1) WITH KEY kunnr = ls_acdoca-kunnr BINARY SEARCH.
    IF sy-subrc = 0.
      CASE ls_acdoca-racct.
        WHEN '1311103000'.
          CASE ls_knb1-zterm.
            WHEN '0001' OR '0002' OR 'D001' OR 'D002'.
              set_amount ls_acdoca-zfbdt due_date_n1 due_date ls_data-cpn_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n2 due_date_n1 ls_data-cpn_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n5 due_date_n2 ls_data-cpn_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n5 ls_data-cpn_n6 ls_acdoca-hsl.
            WHEN 'D003' OR 'D004'.
              set_amount ls_acdoca-zfbdt due_date_n2 due_date_n1 ls_data-cpn_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n3 due_date_n2 ls_data-cpn_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n6 due_date_n3 ls_data-cpn_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n6 ls_data-cpn_n6 ls_acdoca-hsl.
            WHEN 'D005'.
              set_amount ls_acdoca-zfbdt due_date_n3 due_date_n2 ls_data-cpn_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n4 due_date_n3 ls_data-cpn_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n7 due_date_n4 ls_data-cpn_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n7 ls_data-cpn_n6 ls_acdoca-hsl.
            WHEN ''.
              set_amount ls_acdoca-zfbdt due_date_n1 due_date ls_data-cpn_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n2 due_date_n1 ls_data-cpn_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n5 due_date_n2 ls_data-cpn_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n5 ls_data-cpn_n6 ls_acdoca-hsl.
          ENDCASE.
        WHEN '1311101000'.
          CASE ls_knb1-zterm.
            WHEN '0001' OR '0002' OR 'D001' OR 'D002'.
              set_amount ls_acdoca-zfbdt due_date_n1 due_date ls_data-vpp_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n2 due_date_n1 ls_data-vpp_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n5 due_date_n2 ls_data-vpp_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n5 ls_data-vpp_n6 ls_acdoca-hsl.
            WHEN 'D003' OR 'D004'.
              set_amount ls_acdoca-zfbdt due_date_n2 due_date_n1 ls_data-vpp_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n3 due_date_n2 ls_data-vpp_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n6 due_date_n3 ls_data-vpp_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n6 ls_data-vpp_n6 ls_acdoca-hsl.
            WHEN 'D005'.
              set_amount ls_acdoca-zfbdt due_date_n3 due_date_n2 ls_data-vpp_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n4 due_date_n3 ls_data-vpp_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n7 due_date_n4 ls_data-vpp_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n7 ls_data-vpp_n6 ls_acdoca-hsl.
            WHEN ''.
              set_amount ls_acdoca-zfbdt due_date_n1 due_date ls_data-vpp_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n2 due_date_n1 ls_data-vpp_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n5 due_date_n2 ls_data-vpp_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n5 ls_data-vpp_n6 ls_acdoca-hsl.
          ENDCASE.
        WHEN '1311106000'.
          CASE ls_knb1-zterm.
            WHEN '0001' OR '0002' OR 'D001' OR 'D002'.
              set_amount ls_acdoca-zfbdt due_date_n1 due_date ls_data-voso_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n2 due_date_n1 ls_data-voso_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n5 due_date_n2 ls_data-voso_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n5 ls_data-voso_n6 ls_acdoca-hsl.
            WHEN 'D003' OR 'D004'.
              set_amount ls_acdoca-zfbdt due_date_n2 due_date_n1 ls_data-voso_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n3 due_date_n2 ls_data-voso_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n6 due_date_n3 ls_data-voso_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n6 ls_data-voso_n6 ls_acdoca-hsl.
            WHEN 'D005'.
              set_amount ls_acdoca-zfbdt due_date_n3 due_date_n2 ls_data-voso_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n4 due_date_n3 ls_data-voso_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n7 due_date_n4 ls_data-voso_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000'due_date_n7 ls_data-voso_n6 ls_acdoca-hsl.
            WHEN ''.
              set_amount ls_acdoca-zfbdt due_date_n1 due_date ls_data-voso_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n2 due_date_n1 ls_data-voso_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n5 due_date_n2 ls_data-voso_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n5 ls_data-voso_n6 ls_acdoca-hsl.
          ENDCASE.
        WHEN '1311105000'.
          CASE ls_knb1-zterm.
            WHEN '0001' OR '0002' OR 'D001' OR 'D002'.
              set_amount ls_acdoca-zfbdt due_date_n1 due_date ls_data-vtsale_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n2 due_date_n1 ls_data-vtsale_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n5 due_date_n2 ls_data-vtsale_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n5 ls_data-vtsale_n6 ls_acdoca-hsl.
            WHEN 'D003' OR 'D004'.
              set_amount ls_acdoca-zfbdt due_date_n2 due_date_n1 ls_data-vtsale_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n3 due_date_n2 ls_data-vtsale_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n6 due_date_n3 ls_data-vtsale_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n6 ls_data-vtsale_n6 ls_acdoca-hsl.
            WHEN 'D005'.
              set_amount ls_acdoca-zfbdt due_date_n3 due_date_n2 ls_data-vtsale_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n4 due_date_n3 ls_data-vtsale_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n7 due_date_n4 ls_data-vtsale_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n7 ls_data-vtsale_n6 ls_acdoca-hsl.
            WHEN ''.
              set_amount ls_acdoca-zfbdt due_date_n1 due_date ls_data-vtsale_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n2 due_date_n1 ls_data-vtsale_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n5 due_date_n2 ls_data-vtsale_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n5 ls_data-vtsale_n6 ls_acdoca-hsl.
          ENDCASE.
        WHEN '1311109000'.
          CASE ls_knb1-zterm.
            WHEN '0001' OR '0002' OR 'D001' OR 'D002'.
              set_amount ls_acdoca-zfbdt due_date_n1 due_date ls_data-log_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n2 due_date_n1 ls_data-log_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n5 due_date_n2 ls_data-log_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n5 ls_data-log_n6 ls_acdoca-hsl.
            WHEN 'D003' OR 'D004'.
              set_amount ls_acdoca-zfbdt due_date_n2 due_date_n1 ls_data-log_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n3 due_date_n2 ls_data-log_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n6 due_date_n3 ls_data-log_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n6 ls_data-log_n6 ls_acdoca-hsl.
            WHEN 'D005'.
              set_amount ls_acdoca-zfbdt due_date_n3 due_date_n2 ls_data-log_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n4 due_date_n3 ls_data-log_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n7 due_date_n4 ls_data-log_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n7 ls_data-log_n6 ls_acdoca-hsl.
            WHEN ''.
              set_amount ls_acdoca-zfbdt due_date_n1 due_date ls_data-log_n1 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n2 due_date_n1 ls_data-log_n2 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt due_date_n5 due_date_n2 ls_data-log_n3 ls_acdoca-hsl.
              set_amount ls_acdoca-zfbdt '00000000' due_date_n5 ls_data-log_n6 ls_acdoca-hsl.
          ENDCASE.
      ENDCASE.
    ENDIF.
    COLLECT ls_data INTO data_tab.
    CLEAR: ls_data. ", gs_data_amount.
  ENDLOOP.

ENDFUNCTION.
