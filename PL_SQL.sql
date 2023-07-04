
--- set variable declaration and print value
SET SERVEROUTPUT ON
DECLARE
    P_ID  PRODUCTS.PRODUCT_ID%TYPE;
    P_NAME   PRODUCTS.PRODUCT_NAME%TYPE;
    PRICE       PRODUCTS.PRICE%TYPE;
    DESCRIPTION PRODUCTS.DESCRIPTION%TYPE;
BEGIN
    SELECT PRODUCT_ID, PRODUCT_NAME,PRICE,DESCRIPTION into 
    P_ID,P_NAME,PRICE,DESCRIPTION FROM PRODUCTS WHERE PRODUCT_ID=1;

    DBMS_OUTPUT.PUT_LINE('product id: '||P_ID|| 'product name: '||P_NAME||'price: '||PRICE||'description: '||DESCRIPTION);
    end;
    /

---- Inset and set default value
SET SERVEROUTPUT ON
DECLARE
    C_ID CUSTOMERS.CUSTOMER_ID%TYPE := 12;
    C_FNAME CUSTOMERS.FIRST_NAME%TYPE :='jobair al';
    C_LNAME CUSTOMERS.LAST_NAME%TYPE := 'nahian';
    EMAIL CUSTOMERS.EMAIL%TYPE := 'cse@kuet.ac.bd';
    PHONE CUSTOMERS.PHONE_NUMBER%TYPE :='01576183';
    ADDRESS CUSTOMERS.ADDRESS%TYPE :='holodia, borguna';

    BEGIN
    INSERT into CUSTOMERS VALUES (C_ID,C_FNAME,c_LNAME,EMAIL,PHONE,ADDRESS);
    END;
    /

--row type 
set SERVEROUTPUT ON
DECLARE
c_row CATEGORIES%rowtype;
BEGIN
SELECT CATEGORY_ID,CATEGORY_NAME into c_row.CATEGORY_ID,c_row.CATEGORY_NAME from CATEGORIES WHERE CATEGORY_ID=2;
END;
/

--- curson and rowcount
 set SERVEROUTPUT ON
 DECLARE
 cursor category_cursor is SELECT * FROM CATEGORIES;
 c_row CATEGORIES%rowtype;
 BEGIN
 open category_cursor;
 FETCH category_cursor into c_row.CATEGORY_ID,c_row.CATEGORY_NAME;
 WHILE category_cursor%found LOOP
 DBMS_OUTPUT.PUT_LINE(' Category id '|| c_row.CATEGORY_ID||' Category name '|| c_row.CATEGORY_NAME);


 FETCH category_cursor into c_row.CATEGORY_ID,c_row.CATEGORY_NAME;
 END LOOP;
  DBMS_OUTPUT.PUT_LINE(' Row count '|| category_cursor%rowcount);
 close category_cursor;
 end;
 /

---- array with loop

set SERVEROUTPUT on
declare  
    counter NUMBER;
    c_name CUSTOMERS.FIRST_NAME%type;
    type namearray is VARRAY(10) of CUSTOMERS.FIRST_NAME%type;
    a_name namearray :=namearray();
BEGIN
    counter :=1;
    FOR x in 5..10 LOOP
    SELECT FIRST_NAME into c_name FROM CUSTOMERS WHERE CUSTOMER_ID = x;
    a_name.extend();
    a_name(counter) := c_name;
    counter:=counter+1;
    end loop;
    counter:=1;
    WHILE counter<=a_name.count LOOP
    DBMS_OUTPUT.PUT_LINE(a_name(counter));
    counter := counter+1;
    end LOOP;
end;
/

-- if elseif else
set SERVEROUTPUT ON
DECLARE 
   p_name PRODUCTS.PRODUCT_NAME%TYPE;
   
BEGIN
   
   FOR x IN 1..5  
   LOOP
      SELECT Product_name INTO p_name FROM PRODUCTS WHERE PRODUCT_ID=x;
      if p_name='Jeans' 
        then
        dbms_output.put_line(p_name||' is a '||'clothing');
      elsif p_name='Running Shoes'  
        then
        dbms_output.put_line(p_name||' is a '||'footwear');
      else 
        dbms_output.put_line(p_name||' is a '||'other category');
        end if;
   END LOOP;
END;
/

---- procedure

create or REPLACE PROCEDURE proc(var1 in NUMBER,
    var2 out VARCHAR,
    var3 in out NUMBER)
AS
t_show CHAR(30);
BEGIN
t_show := 'From procedure: ';
SELECT CATEGORY_NAME into var2 FROM CATEGORIES WHERE CATEGORY_ID in (
    select CATEGORY_ID from PRODUCTS WHERE PRODUCT_ID = var1
);
var3:=var1+1;
DBMS_OUTPUT.PUT_LINE(t_show|| var2 || ' code is ' || var1 || ' In out parameter: ' || var3);
END;
/

set SERVEROUTPUT on
DECLARE
P_ID PRODUCTS.PRODUCT_ID%type:=3;
C_NAME CATEGORIES.CATEGORY_NAME%type;
extra number:=0;
BEGIN
proc(P_ID,C_NAME,extra);
end;
/


--- function

set SERVEROUTPUT on 
CREATE or REPLACE function fun(var1 in NUMBER) return varchar as
value CUSTOMERS.FIRST_NAME%type;
BEGIN
SELECT FIRST_NAME into value from CUSTOMERS WHERE CUSTOMER_ID=var1;
return value;

end;
/

set SERVEROUTPUT on 
DECLARE
value VARCHAR(20);
BEGIN
VALUE := fun(1);
DBMS_OUTPUT.PUT_LINE('function returned '||VALUE);
end;
/

---- to identify the price range

set SERVEROUTPUT on 
DECLARE
CURSOR proc_cursor is select PRICE from PRODUCTS;
price PRODUCTS.PRICE%type;
BEGIN
OPEN proc_cursor;
FETCH proc_cursor into price ;
WHILE proc_cursor%found LOOP

if price >100
    THEN
    dbms_output.PUT_LINE('greater than 100');
    elsif price>50
    then DBMS_OUTPUT.PUT_LINE('between 100 and 50' );
    ELSE
    DBMS_OUTPUT.PUT_LINE('less than 50' );
end if;
FETCH proc_cursor into price ;

end loop;
close proc_cursor;
end;
/







