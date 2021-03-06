import exceptions._
import scala.collection.mutable.{Queue}
import scala.concurrent._

object TransactionStatus extends Enumeration {
  val SUCCESS, PENDING, FAILED = Value
}

class TransactionQueue {

    // TODO
    // project task 1.1
    // Add datastructure to contain the transactions
    private val _collection = Queue[Transaction]()

    // Remove and return the first element from the queue
    def pop: Transaction = {
        _collection synchronized {
            _collection dequeue
        }
    }

    // Return whether the queue is empty
    def isEmpty: Boolean = {
        _collection synchronized {
            _collection isEmpty
        }
    } 

    // Add new element to the back of the queue
    def push(t: Transaction): Unit = {
        _collection synchronized {
            _collection enqueue t
        }
    }

    // Return the first element from the queue without removing it
    def peek: Transaction = {
        _collection synchronized {
            _collection head
        } 
    }

    // Return an iterator to allow you to iterate over the queue
    def iterator: Iterator[Transaction] = {
        _collection synchronized {
            _collection iterator
        }
    }
}

class Transaction(val transactionsQueue: TransactionQueue,
                  val processedTransactions: TransactionQueue,
                  val from: Account,
                  val to: Account,
                  val amount: Double,
                  val allowedAttemps: Int) extends Runnable {

  var status: TransactionStatus.Value = TransactionStatus.PENDING
  var attempt = 0

  override def run: Unit = {

      def doTransaction() = {
          // TODO - project task 3
          // Extend this method to satisfy requirements.
          if (from withdraw amount isLeft) {
              if (to deposit amount isLeft) {
                  status = TransactionStatus.SUCCESS
              } else {
                  from deposit amount
                  attempt += 1
                  if (attempt == allowedAttemps) {
                      status = TransactionStatus.FAILED
                  }
              }
          } else {
            attempt += 1
            if (attempt == allowedAttemps) {
                status = TransactionStatus.FAILED
            }
          }
      }

      // TODO - project task 3
      // make the code below thread safe
      if (status == TransactionStatus.PENDING) {
          doTransaction
          Thread.sleep(50) // you might want this to make more room for
                           // new transactions to be added to the queue
      }
    }
}
