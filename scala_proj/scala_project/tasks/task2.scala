import java.util.concurrent.atomic.AtomicInteger
import scala.concurrent.Future
import scala.concurrent.Await
import scala.concurrent.duration._
import scala.concurrent.ExecutionContext.Implicits.global

class MyThread extends Thread { 
    override def run() { 
        // Displaying the thread that is running  
        println("Thread " + Thread.currentThread().getName() +  " is running.") 
    } 
}  

object task2 {
    def main(args: Array[String]) {
        makeThread(increaseCounter).start
        makeThread(increaseCounter).start
        makeThread(printCounter).start

        makeThread(improvedIncreaseCounter).start
        makeThread(improvedIncreaseCounter).start
        makeThread(printImprovedCounter).start
    }

    def makeThread(f: => Unit): Thread = {
        new Thread {
            override def run() = { f }
        }
    }   

    private var counter: Int = 0
    def increaseCounter() = Unit {
        counter += 1
    }

    def printCounter(): Unit = {
        println(counter)
    }

    val improvedCounter: AtomicInteger = new AtomicInteger
    def improvedIncreaseCounter(): Integer = {
        improvedCounter.incrementAndGet
    }

    def printImprovedCounter(): Unit = {
        println(improvedCounter.get)
    }

    /*  
     *  Deadlocks occur when two threads depend on each other and try to
     *  access variables from each other. It's real life simularity is  
     *  if you're eating with someone and thei have a knife while you have a fork
     *  None of you can't actually finish the meal without the other's cutlary.
     */ 

    object Alice {
        lazy val b = B.getAlice
        val value = 42
    }

    object Bob {
        lazy val getAlice = Alice.value
    }

    object DL {
        def exec = {
            val res = Future.sequence(Seq(
                Future { Alice.b },
                Future { Bob.geAlice }
            ))
            Await.result(res, 3 seconds)
        }
    }
    Dl.exec




    

    
}