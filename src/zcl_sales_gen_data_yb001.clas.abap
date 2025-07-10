CLASS zcl_sales_gen_data_yb001 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sales_gen_data_yb001 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lt_zybpo_header TYPE STANDARD TABLE OF zybpo_header,
          lt_zybpo_item   TYPE STANDARD TABLE OF zybpo_item.

    lt_zybpo_header = VALUE #( ( pono = '1' pocompany = 'ABC' podate = sy-datum podesc = 'Purchase of School Study' postatus = 'A' ) ).
    lt_zybpo_item = VALUE #( ( pono = '1' poitem = '11' quantity = '10' unit = 'EA'  )
                             ( pono = '1' poitem = '12' quantity = '10' unit = 'EA'  )
                             ( pono = '1' poitem = '13' quantity = '10' unit = 'EA'  ) ).
    DELETE FROM zybpo_header.
    DELETE FROM zybpo_item.

    INSERT zybpo_header FROM TABLE @lt_zybpo_header.
    INSERT zybpo_item FROM TABLE @lt_zybpo_item.

    COMMIT WORK.


  ENDMETHOD.
ENDCLASS.
