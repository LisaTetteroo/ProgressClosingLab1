
 /*------------------------------------------------------------------------
    File        : ttItem
    Purpose		:
    Syntax      : 
    Description :
    Author(s)   : lisa_
    Created     : Mon Jun 22 16:24:27 CEST 2020
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
	
DEFINE TEMP-TABLE ttItem
FIELD Itemnum AS INTEGER INITIAL "0" LABEL "Item Num"
FIELD ItemName AS CHARACTER LABEL "Item Name"
FIELD Price AS DECIMAL INITIAL "0" LABEL "Price"
FIELD CatDescription AS CHARACTER LABEL "Cat-Description"
FIELD origPrice LIKE price
INDEX CatDescription  CatDescription  ASCENDING 
INDEX Category2ItemName  Category2  ASCENDING  ItemName  ASCENDING 
INDEX CategoryItemName  Category1  ASCENDING  ItemName  ASCENDING 
INDEX ItemName  ItemName  ASCENDING 
INDEX ItemNum IS  PRIMARY  UNIQUE  Itemnum  ASCENDING . 