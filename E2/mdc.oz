fun {Lex Input}
   {String.tokens Input & }
end

fun {Tokenize Lexemes}
    Commands = ["p" "f" "^" "i"]
    Operators = ["+" "-" "*" "/"]
in
    {Map Lexemes
        fun {$ Lexeme}
            if {Member Lexeme Commands} then
                cmd({String.toAtom Lexeme})
            elseif {Member Lexeme Operators} then
	            op({String.toAtom Lexeme})
            else
	        try 
                int({String.toInt Lexeme})
	        catch _ then 
                raise "Non-valid lexeme '"#Lexeme#"'" 
            end
	        end
        end
    end}
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
    [] op(Operator)|Tokens then 
        0
    [] int(Integer)|Tokens then 
        
    end
end

fun {Infix Tokens}
    case Tokens of nil then nil
    
    end
end

