
/*------------------------------------------------------------------------
   File        : ttSales.i
   Purpose     :

   Syntax      :

   Description :

   Author(s)   :
   Created     : Fri Mar 10 13:44:35 UTC 2017
   Notes       :
 ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */


/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
define temp-table ttSales
    field Salesrep   as character label "Sales Rep" format "x(3)"
    field SalesName  as character label "Sales Name" format "x(15)"
    field Month      as integer   label "Month" format "99"
    field TotalSales as decimal   label "Tot. Sales" format ">>9,999,999.99"
    index idx1       as unique    Salesrep Month.
