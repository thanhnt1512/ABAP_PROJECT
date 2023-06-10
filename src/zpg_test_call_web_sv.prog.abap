*&---------------------------------------------------------------------*
*& Report ZPG_TEST_CALL_WEB_SV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_test_call_web_sv.
*DATA(proxy_test) = NEW ztntco_calculator_soap( ).
*DATA: input  TYPE ZTNTADD_SOAP_IN,
*      output TYPE ZTNTADD_SOAP_OUT.
*input-int_a = 1.
*input-int_b = 1.
*TRY.
*CALL METHOD proxy_test->add
*  EXPORTING
*    input  = input
*  IMPORTING
*    output = output
*    .
**CALL METHOD proxy_test->divide
**  EXPORTING
**    input  = input
**  IMPORTING
**    output = output.
* CATCH cx_ai_system_fault .
*ENDTRY.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
*DATA(proxy_test) = new ZCO_SI_ENCRYPT_IN( ).
*DATA :input TYPE ZMT_ENCRYPT_IN,
*      output TYPE ZMT_ENCRYPT_RES.
*
**TRY.
*input-mt_encrypt_in-aes_key = '540096fba3662e658ed8314693a5e26bVIAESKEYSPACE062338831fa9f2cb'.
*input-mt_encrypt_in-data = '{"passWord":"mGcVhFiM3J4ugMvaDPzRO2RHGPg=","vof2Key":"222222a@","loginName":"tuantm18"}'.
*CALL METHOD proxy_test->si_encrypt_in
*  EXPORTING
*    input  = input
*  IMPORTING
*    output = output
*    .
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
* CATCH cx_ai_system_fault .
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*DATA :input TYPE ZMT_TEST_IN,
*      output TYPE ZMT_TEST_OUT.
*DATA(proxy_test) = new ZCO_SI_TEST_IN( ).
*input-mt_test_in-content_type = 'application/vnd.kafka.json.v2+json'.
*input-mt_test_in-name = 'DEV_ZTMI251_FW09d'.
*input-mt_test_in-format = 'json'.
*input-mt_test_in-auto_offset_reset = 'earliest'.
*CALL METHOD proxy_test->si_test_in
*  EXPORTING
*    input  = input
*  IMPORTING
*    output = output.
*ENDTRY.
""""""""""""""""""""""""""""""""""""""""""""""""""""
DATA(proxy_test) = NEW ZCO_SI_TEST_OUBOUND( ).
DATA :output TYPE ZMT_TEST_IN1,
      input  TYPE ZMT_TEST_TRG_OUT.
output-mt_test_in-content_type = 'application/vnd.kafka.json.v2+json'.
output-mt_test_in-name = 'DEV_ZTMI251_FWD09d'.
output-mt_test_in-format = 'json'.
output-mt_test_in-auto_offset_reset = 'earliest'.
CALL METHOD proxy_test->SI_TEST_OUBOUND
  EXPORTING
    output = output
  IMPORTING
    input  = input.
BREAK-POINT.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*DATA: ls_csks_in TYPE zdt_zfii017_req,
*      mt_csks_in TYPE zmt_zfii017_req,
*      ls_mess    TYPE zmt_zfii017_res.
*DATA: lo_zfii017 TYPE REF TO zco_si_zfii017_out.
*BREAK hungvt.
*IF sy-tcode = 'KS01'.
*  ls_csks_in-flag = 'C'.
*ELSEIF sy-tcode = 'KS02'.
*  ls_csks_in-flag = 'M'.
*ENDIF.
*ls_csks_in-cost_center = 'P00001'.
*ls_csks_in-name = 'Nam'.
*ls_csks_in-level = '1'.
*
*mt_csks_in-mt_zfii017_req = ls_csks_in.
*
*CREATE OBJECT lo_zfii017.
*TRY.
*    CALL METHOD lo_zfii017->si_zfii017_out(
*      EXPORTING
*        output = mt_csks_in
*      IMPORTING
*        input  = ls_mess
*    ).
*
*  CATCH cx_ai_system_fault INTO DATA(lx_error).
*
*ENDTRY.
