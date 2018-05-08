int Flujo() {
    int NP1 = 0;
    int NP2 = 0;
    switch(preanalisis) {
        case IF:
            NP1 = If();
            NP2 = Else();
            return (NP1 + NP2);
            /*  &&() { adfglkñs}*/
        case WHILE:
            return (While()); //tambien soy un comentario
        case DO:
            parea(DO);
            parea('{');
            NP1 = A();
            parea('}');
            parea(WHILE);
            parea('(');
            NP2 = C();
            parea(')');
            return (NP1 + NP2 + 1);
        case FOR:
            return (For());
        case SWITCH:
            return(Switch());
        default :
            return "Holamundo }}";
    }
}
