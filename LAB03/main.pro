implement main
    open core, stdio, file

domains
    category = a; b; c; d; e; f.

class facts - purchaseData
    product : (integer Id, string Name, category Categories, real Cost).
    client : (string Client, string Phone_number, integer Attendity).
    purchase : (string Phone_number, integer Id, integer Quantity, string Data).

class predicates
    length : (A*) -> integer N.
    el_sum : (real* List) -> real Sum.
    laverage : (real* List) -> real Average determ.
    max : (real* List, real Max [out]) nondeterm.
    min : (real* List, real Min [out]) nondeterm.

clauses
    length([]) = 0.
    length([_ | T]) = length(T) + 1.

    el_sum([]) = 0.
    el_sum([H | T]) = el_sum(T) + H.

    laverage(L) = el_sum(L) / length(L) :-
        length(L) > 0.

    max([Max], Max).

    max([H1, H2 | T], Max) :-
        H1 >= H2,
        max([H1 | T], Max).

    max([H1, H2 | T], Max) :-
        H1 <= H2,
        max([H2 | T], Max).

    min([Min], Min).

    min([H1, H2 | T], Min) :-
        H1 <= H2,
        min([H1 | T], Min).

    min([H1, H2 | T], Min) :-
        H1 >= H2,
        min([H2 | T], Min).

class predicates
    print_list : (integer*) nondeterm.
    print_list : (string*) nondeterm.
    print_list : (main::purchaseData*) nondeterm.
    purchase_s : (string NameClient) -> main::purchaseData* PurS nondeterm.
    sum_purch_d : (string Cost) -> main::purchaseData* PurS nondeterm.
    budgetsum : () -> real Sum determ.
    budgetmax : () -> real Max nondeterm.
    budgetmin : () -> real Min nondeterm.

clauses
    purchase_s(NameClient) = PurS :-
        client(NameClient, NumberC, _),
        !,
        PurS = [ purchase(NumberC, Num1, Num2, Date) || purchase(NumberC, Num1, Num2, Date) ].

    sum_purch_d(NameClient) = PurS :-
        client(NameClient, NumberC, _),
        !,
        PurS =
            [ product(Num1, ProductName, Category, Cost * Num2) ||
                product(Num1, ProductName, Category, Cost),
                purchase(NumberC, Num1, Num2, Date)
            ].

    print_list([X | Y]) :-
        write(X),
        nl,
        print_list(Y).

    budgetsum() = Sum :-
        Sum = el_sum([ Budget || product(_, _, _, Budget) ]).

    budgetmax() = Res :-
        max([ Budget || product(_, _, _, Budget) ], Max),
        Res = Max,
        !.
    budgetmin() = Res :-
        min([ Budget || product(_, _, _, Budget) ], Min),
        Res = Min,
        !.

clauses
    run() :-
        file::consult("../ds.txt", purchaseData),
        fail.
    run() :-
        PList = purchase_s("Roman"),
        write(PList),
        nl,
        write("Пишем список..."),
        nl,
        print_list(PList),
        write("Список завершён"),
        nl,
        fail.
    run() :-
        PList = sum_purch_d("Roman"),
        write(PList),
        nl,
        write("Пишем список..."),
        nl,
        print_list(PList),
        write("Список завершён"),
        nl,
        fail.
    run() :-
        write("Сумма всех покупок: ", budgetsum()),
        nl,
        write("Самый дорогой продукт: ", budgetmax()),
        nl,
        write("Самый дешёвый продукт: ", budgetmin()),
        nl,
        fail.
    run() :-
        stdio::write("Тест завершён\n").

end implement main

goal
    console::runUtf8(main::run).
