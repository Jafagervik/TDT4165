fun {Product S}
   case Elem|nil of S then
      Elem
   [] Elem1|Elem2|Tail then
      Elem1*Elem2|{Product Tail}
   end
end
