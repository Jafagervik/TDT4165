fun {Lex Input}
   {String.tokens Input & }
end

fun {Tokenize Lexemes}
    case Lexemes of nil then nil
    [] Lexeme|Lexemes then
        Token in
            try
                if Lexeme == "p" orelse Lexeme == "f" orelse Lexeme == "i" orelse Lexeme == "^" then
                    % Command Token
                    Token = cmd({String.toAtom Lexeme})
                elseif Lexeme == "+" orelse Lexeme == "-" orelse Lexeme == "*" orelse Lexeme == "/" then
                    % Operator Token
                    Token = op({String.toAtom Lexeme})
                else 
                    % Integer token
                    Token = int({String.toInt Lexeme})
                end
            catch _ then
                raise tokenizer(lexeme:Lexeme) end
            end
        Token|{Tokenize Lexemes}
    end
end

fun {Interpret Tokens}
    Commands = cmd(p:proc {$ Top|_} {Browse Top} end
        f:proc {$ Stack} {ForAll Stack Browse} end)
    Opertions = op(
        '+':Number.'+' 
        '-':Number.'-' 
        '*':Number.'*' 
        '/':Int.'div') % For å få rett type divisjon
    proc {Iterate Stack Tokens}
        case Tokens of nil then
            skip
        [] int(Integer)|Tokens then
            {Iterate Integer|Stack Tokens}
        [] cmd(Command)|Tokens then
            {Commands.Command Stack}
        
        {Iterate Stack Tokens}
        [] op(Operator)|Tokens then
            Top|TopNeighbor|Rest = Stack in
                {Iterate {Opertions.Operator TopNeighbor Top}|Rest Tokens}
        end
    end
in
    try
       {Iterate nil Tokens}
    catch _ then
       raise "Empty Stack" 
    end
end

fun {InfixInternal Tokens ExpressionStack}
    case Tokens of nil then nil
    [] _|Tokens then
        0
    [] _|Tokens then 
        1
    end
end

fun {Infix Tokens}
    case Tokens of nil then nil
    [] Token|Tokens then
        {InfixInternal Tokens [1 2]}
    end
end

