functor
import
    Application(exit:Exit)
    System
define
    {System.showInfo 'Hello Compiler!'}

    Y = 300
    Z = 30
    X = Y*Z
    {System.showInfo X}

    A = "This is a string"
    thread {System.showInfo B} end % Threading is alwys useful when waiting for data to arrive 
    B = A % This points B to the same location in memory to B, but waits til A has gotten a value

    fun {Max Number1 Number2}
        if Number1 >= Number2 then Number1 else Number2 end
    end

    proc {PrintGreater Number1 Number2}
        if Number1 > Number2 then {System.showInfo Number1} else {System.showInfo Number2} end
    end
    
    local 
        PI A D C 
        proc {Circle R} 
            PI = 3.1415926
            A = PI * R * R
            D = 2.0 * R 
            C = PI * D  
            
            {System.showInfo "Diameter is " #D}
            {System.showInfo "Cirumference is " #C}
            {System.showInfo "Area is " #A}  
        end
    in
        {Circle 5.0}  
    end

    fun {Factorial N}
        if N == 0 then 1 else N*{Factorial N-1} end
    end

    fun {ListLength L}
        case L of nil then 0
        else 1+{Length L.2}
        end
    end

    {System.showInfo {Max 5 3}}
    {PrintGreater 6 3}
    {System.showInfo {Factorial 5}}
    {System.showInfo {ListLength [1 2 3 6 2 43 6]}}

    {Exit 0}
end