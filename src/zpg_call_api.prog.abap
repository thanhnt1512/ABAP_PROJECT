*&---------------------------------------------------------------------*
*& Report ZPG_CALL_API
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_call_api.

DATA: lv_url      TYPE string VALUE 'http://10.60.108.86:8591/ServiceMobile_V02/resources/Authenticate/getRsaKeyPublic',
      lv_client   TYPE REF TO if_http_client,
      lv_request  TYPE REF TO if_http_request,
      lv_response TYPE REF TO if_http_response,
      lv_status   TYPE i,
      lv_reason   TYPE string.

* Create an HTTP client object
TRY.
    cl_http_client=>create_by_url(
      EXPORTING
        url  = lv_url
      IMPORTING
        client = lv_client
    ).
    lv_client->request->set_header_field( name = '~request_method' value = 'POST' ).

* Send the request
    CALL METHOD lv_client->send
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        OTHERS                     = 4.



    CALL METHOD lv_client->receive
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        OTHERS                     = 4.
    IF sy-subrc NE 0.
      DATA subrc TYPE sysubrc.
      DATA errortext TYPE string.
      CALL METHOD lv_client->get_last_error
        IMPORTING
          code    = subrc
          message = errortext.

      WRITE: / 'communication_error( receive )',
             / 'code: ', subrc, 'message: ', errortext.

    ENDIF.
*   DATA(lv_string2) = lv_client->response->get_cdata( ).
*
*  write lv_string2.
* Read the response

ENDTRY.
