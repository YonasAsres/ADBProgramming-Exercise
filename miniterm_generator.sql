-- Create the necessary types
CREATE OR REPLACE TYPE miniterm_type AS OBJECT (
    predicate VARCHAR2(100)
);

CREATE OR REPLACE TYPE miniterm_table AS TABLE OF miniterm_type;

-- Create the stored procedure
CREATE OR REPLACE PROCEDURE generate_horizontal_miniterms(
    predicates IN miniterm_table,
    horizontal_miniterms OUT miniterm_table
)
IS
    miniterm miniterm_type;
BEGIN
    horizontal_miniterms := miniterm_table();
    FOR i IN 1..predicates.COUNT LOOP
        miniterm := miniterm_type(predicates(i).predicate);
        horizontal_miniterms.EXTEND;
        horizontal_miniterms(horizontal_miniterms.LAST) := miniterm;
    END LOOP;
END;
/



-- Test the stored procedure
DECLARE
    employee_predicates miniterm_table := miniterm_table();
    horizontal_miniterms miniterm_table;
BEGIN
    employee_predicates.EXTEND(3);
    employee_predicates(1) := miniterm_type('Employee.name');
    employee_predicates(2) := miniterm_type('Employee.department');
    employee_predicates(3) := miniterm_type('Employee.salary');

    generate_horizontal_miniterms(employee_predicates, horizontal_miniterms);

    FOR i IN 1..horizontal_miniterms.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(horizontal_miniterms(i).predicate);
    END LOOP;
END;
/
