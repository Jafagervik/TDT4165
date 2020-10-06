fun {GenerateOdd S E}
   if S =< E then
      if {Int.isOdd S} then
         S|{GenerateOdd S+1 E}
      else
         {GenerateOdd S+1 E}
      end
   else nil 
   end
end
