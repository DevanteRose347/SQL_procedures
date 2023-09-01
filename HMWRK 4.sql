--2. Add a new column in the customer table for Platinum Member. This can be a boolean.
--Platinum Members are any customers who have spent over $200. 
--Create a procedure that updates the Platinum Member column to True for any customer who has spent over $200 and False for any customer who has spent less than $200.
--Use the payment and customer table.


--ALTER TABLE <name of table>
--ADD <column name> <TYPE>
ALTER TABLE customer
ADD COLUMN Platinum_Member Boolean;


CREATE OR REPLACE PROCEDURE update_platinum_member()
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE customer
	SET platinum_member = true 
	WHERE customer_id IN (
    	SELECT customer_id
		FROM payment
		GROUP BY customer_ID
		HAVING SUM(amount) > 200
		ORDER BY SUM(amount) DESC
);
COMMIT;
END;
$$
CALL update_platinum_member();
SELECT *
FROM customer
where platinum_member = true
