% Copyright

implement main
    open core, stdio, file

domains
    category = a; b; c; d; e; f.

class facts - purchaseData
    product : (integer Id, string Name, category Categories, real Cost).
    client : (string Client, string Phone_number, integer Attendity).
    purchase : (string Phone_number, integer Id, integer Quantity, string Data).

class facts
    sum : (real Sum) single.

clauses
    sum(0).

class predicates
    con_client : (string Name1, integer ID1) nondeterm anyflow.
    shownb : (string Name12, string Phone1) nondeterm anyflow.
    showpur : (string Name23, string Name1, real Cost) nondeterm anyflow.
    cost_summary : () failure anyflow.

clauses
    con_client(Name12, IDconst) :-
        client(Name12, _, IDconst),
        IDconst > 5.

    shownb(Name12, Phone1) :-
        client(Name12, Phone1, _).

    showpur(Name23, Name1, Cost) :-
        client(Name23, Phone_number, _),
        purchase(Phone_number, Id, _, _),
        product(Id, Name1, _, Cost).

    cost_summary() :-
        product(_, _, _, Cost),
        sum(Sum),
        assert(sum(Sum + Cost)),
        fail.

clauses
    run() :-
        file::consult("../ds.txt", purchaseData),
        fail.
    run() :-
        con_client(Name12, ID1),
        stdio::write("Постоянным клиентом из всех посетителей является ", Name12, ". Он(а) посетил ", ID1, "раз(а) этот супермаркет.", "\n"),
        fail.

    run() :-
        shownb(Name12, Phone1),
        stdio::write("Имя: ", Name12, " Его(её) номер ", Phone1, "\n"),
        fail.

    run() :-
        cost_summary().
    run() :-
        sum(Cost),
        stdio::write("Summary of cost is ", Cost, "\n"),
        fail.
    run() :-
        showpur(Name23, Name1, Cost),
        stdio::write(Name23, " купил себе ", Name1, " стоило это ", Cost, "\n"),
        fail.

    run().

end implement main

goal
    console::runUtf8(main::run).
