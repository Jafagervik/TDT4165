/*  1b) Procedural abstractions are useful because:
      1: Easier to test the code if it is segregated
      2: Only needs to be fixed in one place if the code is wrong
      3: Breaking down the code into smaller pieces makes it easier to
         helps it become easier to  make an application
    1c) The difference between a procedure and a function
        is that a function returns some value while a
        procedure only execute upon commands without returning
        anything.
*/



/* 3b) is explained in the code
   3d) Addition holds the law of communication so it doesn't matter which way      we add numbers. For substraction the story is different.
     5 - 4 is not the same as 4 - 5.
   3e) A good value for U would be 1 when talking about product, 0 for sum and count if the list is empty */

/* 5b) LazyNG takes a startvalue and appends this with the same function but with an incremented startvalue, simulating an infinite list.
 *     Head is our start value and the remainder is a function returning a list.
 */

/* 6a) Sum from task 2 is not tail recursive since the last thing it does is to
 *     return 0 is the last operation
 * 6b) The thing about tail recursion is that it allows the compiler to
 *     perform ptimizations better than  non tail recursive functions. It's also more readable!
 * 6c) There is no disadvantage to tail recursion except that you can't check out the backtrace as easy, but most of the tim you don't need to worry about this. So for other than debug purposes then no. */




functor
import
   Application
   System
define
    proc {QuadraticEquation A B C ?RealSol ?X1 ?X2}
        D = B * B - 4.0 * A * C in

        if (D < 0.0) then
            RealSol = false
            X1 = nil
            X2 = nil
        else
            RealSol = true
            X1 = (~B + {Float.sqrt D})/(2.0 * A)
            X2 = (~B - {Float.sqrt D})/(2.0 * A)
        end
    end

    /* Gives real solution and X1 and X2 /
    local RS X1 X2 in
        {QuadraticEquation 2.0 1.0 ~1.0 RS X1 X2}
        {System.show RS}
        {System.show X1}
        {System.show X2}
    end

    /* Gives no real solution */
    local RS2 X12 X22 in
        {QuadraticEquation 2.0 1.0 2.0 RS2 X12 X22}
        {System.show RS2}
        {System.show X12}
        {System.show X22}
    end

    fun {Sum List}
        case List of H|T then
            H + {Sum T}
        else
            0
        end
    end

    {System.show {Sum [1 2 3 4 5]} }

    fun {RightFold List Op U}
        /* If the list is empty then return the U value */
        case List of nil then U
        /* If not then perform an operation on
         * header and the rest of the list
         * U becomes the result in the end */
        [] H|T then {Op H {RightFold T Op U}}
        end
    end

    fun {SumFoldR List}
        {RightFold List fun {$ X Y} X + Y end 0}
    end

    fun {LengthFoldR List}
        {RightFold List fun {$ _ Y} 1 + Y end 0}
    end
    {System.show {SumFoldR [7 2 3 4]}}
    {System.show {LengthFoldR [1 2 3 4]}}


    fun {Quadratic A B C}
        fun {$ X} A*X*X + B*X + C end
    end

    /* Using the result Quadratic gives me and then calling it with the X value of 2 */
    {System.show {{Quadratic 3 2 1} 2}}


    fun {LazyNumberGenerator StartValue}
    	StartValue|fun {%} {LazyNumberGenerator StartValue + 1} end
    end
    {System.show {{LazyNumberGenerator 0}.2}.1}


    fun {TailRecSum List}
        local SumAux in
            /* ================
             * Auxiliary function - Works like a while loop
             * in other languages. Total is the cumulative sum
             * we're interested in
            * ================ */
            fun {SumAux List Total}
                case List of H | T then
                    {SumAux T H+Total}
                else
                    Total
                end
            end
        /* ============
         * This works like a main function so every time
         * we call this function, total starts at 0
         * ============ */
        {SumAux List 0}
        end
    end
    {System.show {TailRecSum [1 2 3 4 5 6]}}

    {Application.exit 0}

end
