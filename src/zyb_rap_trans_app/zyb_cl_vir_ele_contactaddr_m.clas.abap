CLASS zyb_cl_vir_ele_contactaddr_m DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zyb_cl_vir_ele_contactaddr_m IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA:lt_contaddr TYPE STANDARD TABLE OF zyb_c_contaddr_m,
         lv_city     TYPE zyb_contaddr_m-city.
    "Get Data into Local Internaltable
    lt_contaddr = CORRESPONDING #( it_original_data ) .

    "Canculate Virtual element Values
    LOOP AT lt_contaddr ASSIGNING FIELD-SYMBOL(<ls_contaddr>).
      lv_city = |{ <ls_contaddr>-City CASE  = UPPER }|.
      <ls_contaddr>-IsLocal = COND #( WHEN lv_city EQ 'MUMBAI' THEN abap_true ELSE abap_false  ).
      CLEAR:lv_city.
    ENDLOOP.

    "Pass calculated data to front end
    ct_calculated_data = CORRESPONDING #( lt_contaddr ).

  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.
ENDCLASS.
