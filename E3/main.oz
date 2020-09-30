functor import Application System define
    
    {Application.exit 0}
end

proc {QuadraticEquation A B C ?RealSol ?X1 ?X2}
   if B*B - 4*A*C > 0 then
      RealSol = true
      X1 = (-B + Math.sqrt(B*B-4*A*C))/2*A
      X2 = (-B - Math.sqrt(B*B-4*A*C))/2*A
      RealSol
      X1
      X2
   else then 
      RealSol = false
      RealSol
end

% 1b) Procedural abstractions are useful because:
%     1:
%     2:
% 1c) The difference between a procedure and a function
%     is that a function returns some value while a 
%     procedure only execute upon commands without returning
%     anything.


fun {Sum List} 
   case List of H | T then
      H + {Sum T}
   else
      0
   end
end

% ==============================
% Map function with a right fold
% lets us do numerous operations 
% on lists
% ==============================
local Map in 
   fun {Map L F} 
      case L 
      of nil then nil
      [] H|T thhen {F H}|{Map T F}
      end
   end
end

local RightFold in
   fun {RightFold List Op U} 
      case L 
      of nil then U
      [] H|T then {Op H {RightFold T Op U}}
      end
   end
end
   
% {System.show {RightFold {Map{[1 2 3 4] fun {$ +} X+X end} fun {$ X Y} 
% X+Y end} 0}

% 3b) is explained in the code
% 3d) Addition holds the law of communication so it doesn't matter which way      we add numbers. For substraction the story is different.
%     5 - 4 is not the same as 4 - 5.
% 3e) A good value for U would be 1 when talking about product, 0 when sum
%

fun {Quadratix A B C} 
   fun {$ X} A*X*X + B*X + C end
end

%{System.show {{Quadratic 3 2 1} 2}} == 17

fun {LazyNumberGenerator StartValue}

   

end

% 5b)
%
%

% 6a) Sum from task 2 is not tail recursive since the last thing it does is to
%     return 0 is the last operation
% 6b) The thing about tail recursion is that it allows the compiler to 
%     perform ptimizations better than  non tail recursive functions

declare
% =======================================
% Returns the sum of elements in the list
% =======================================
fun {Sum List}
   local SumAux in
   % ================
   % Auxiliary function - Works like a while loop 
   % in other languages. Total is the cumulative sum
   % we're interested in
   % ================
      fun {SumAux List Total}
         case List of H | T then
            {SumAux T H+Total}
         else
            Total
         end
      end
      % ============
      % This works like a main function so every time
      % we call this function, total starts at 0
      % ============
      {SumAux List 0}
   end
end
