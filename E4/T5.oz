fun {GenerateStream S}
   Stream  = thread {GenerateOdd 0 1000}
   Product = thread {Product Stream}

   Product
end
