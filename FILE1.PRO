product(1, 'Sandwich', 'A', 200).
product(2,'Car', 'B', 350000).
product(3, 'box', 'C', 30).
product(4, 'phone', 'D', 35000).

name_of_client('Valera', '88005553535', 5).
name_of_client('Danil', '88005553532', 10).
name_of_client('Kir', '88005553531', 1).


sells( '88005553532', 3, 3, 2023).
sells( '88005553531', 2, 1, 2019).
sells( '88005553535', 1, 2, 2016).

con_client(Name1, ID1) :- name_of_client(Name1, Phone1, ID1), ID1 > 5.

finalsumm(Product1, Product2, Product3) :- product(ID, Product1, Category, Price1), product(ID, Product2, Category, Price2), product(ID, Product3, Category, Price3), write(Price1+Price2+Price3).

shownb(Name1, Phone1) :- name_of_client(Name1, Phone1, ID).