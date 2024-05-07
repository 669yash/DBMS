//consider the relational schema student(rno:integer, sname:string, branch:string, cgpa:real) create a trigger which doesn't allow dml operation student table for computer branch

CREATE TABLE student3 (
    rno INTEGER PRIMARY KEY,
    sname VARCHAR(255),
    branch VARCHAR(255),
    cgpa REAL
);

INSERT INTO student VALUES (1, 'John Doe', 'Computer', 7.5);
INSERT INTO student VALUES (2, 'Jane Smith', 'Electronics', 8.2);
INSERT INTO student VALUES (3, 'Alice Johnson', 'Mechanical', 6.9);
INSERT INTO student VALUES (4, 'Bob Williams', 'Computer', 7.1);
INSERT INTO student VALUES (5, 'Eva Brown', 'Civil', 6.5);



CREATE OR REPLACE TRIGGER Prevent_Computer_Branch_DML
BEFORE INSERT OR UPDATE OR DELETE ON student
FOR EACH ROW
DECLARE 
    v_branch student.branch%TYPE;
BEGIN
    IF INSERTING THEN 
        v_branch := :NEW.branch;
    ELSIF UPDATING THEN
        v_branch := :NEW.branch;
    ELSIF DELETING THEN
        v_branch := :OLD.branch;
    END IF;

    IF v_branch = 'Computer' THEN
        RAISE_APPLICATION_ERROR(-20001, 'DML operations are restricted for Computer branch');
    END IF;
END;
