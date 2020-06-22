
/*------------------------------------------------------------------------
    File        : ttSales.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : lisa
    Created     : Mon Jun 22 13:45:57 CEST 2020
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

DEFINE TEMP-TABLE ttSales
    FIELD Salesrep   AS CHARACTER LABEL "Sales Rep" FORMAT "x(3)"
    FIELD SalesName  AS CHARACTER LABEL "Sales Name" FORMAT "x(15)"
    FIELD Month      AS INTEGER   LABEL "Month" FORMAT "99"
    FIELD TotalSales AS DECIMAL   LABEL "Tot. Sales" FORMAT ">>9,999,999.99"
    INDEX idx1 AS UNIQUE Salesrep Month.

