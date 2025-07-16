CLASS zyb_cl_vir_ele_contact_m DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zyb_cl_vir_ele_contact_m IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA:lt_contact TYPE STANDARD TABLE OF zyb_c_contact_m.
    "Get Data into Local Internaltable
    lt_contact = CORRESPONDING #( it_original_data ) .

    "Canculate Virtual element Values
    LOOP AT lt_contact ASSIGNING FIELD-SYMBOL(<ls_contact>).
      <ls_contact>-CanVote = COND #( WHEN <ls_contact>-Age GT 18 THEN abap_true ELSE abap_false  ).
    ENDLOOP.

    "Pass calculated data to front end
    ct_calculated_data = CORRESPONDING #( lt_contact ).

  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.
ENDCLASS.
