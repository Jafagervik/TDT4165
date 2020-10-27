object task1 {
    def main(args: Array[String]) {
      println( "Returned array : " + generateArray() );
      for (elem <- generateArray() ) println(elem) 
      println( "Returned sum : " + sumArray(Array(1,2,3,4,5,6)) );
      println( "Returned sum rec : " + sumArrayRecursion(Array(1,2,3,4,5,6)) );
      println( "Returned fibonacci value : " + fibonacci(10) );
    }

    def generateArray(): Array[Int] = {
        var array: Array[Int] = new Array[Int]
        for (i <- 1 to 50) :+= i
        array
    }

    def sumArray(arr: Array[Int]): Int = {
        var sum: Int = 0
        for (elem <- arr) sum += elem
        sum
    }

    def sumArrayRecursion(arr: Array[Int], elem: Int = 0, sum: Int = 0): Int = {
        /* Sum of array taking advantage of tail recursion
         *
         */
        if (elem < arr.length) {
            sumArrayRecursion(arr, elem+1, sum+arr(elem))
        } else {
            sum
        }
    }

    @tailrec def fibonacci(n: Int, n1: BigInt = 0, n2: BigInt = 1): BigInt = n match {
        /*
         * Tail recursive fibonacci
         * Using pattern matching
        */
        case 0 => n1
        case 1 => n2
        case _ => fibonacci(n-1, n2, n1 + n2)
    }
}