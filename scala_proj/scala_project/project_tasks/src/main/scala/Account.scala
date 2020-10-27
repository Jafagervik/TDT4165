import exceptions._
import scala.concurrent._

class Account(val bank: Bank, initialBalance: Double) {

    class Balance(var amount: Double) {}

    val balance = new Balance(initialBalance)

    // TODO
    // for project task 1.2: implement functions
    // for project task 1.3: change return type and update function bodies
    def withdraw(amount: Double): Either[String, RuntimeException] = {
        balance synchronized { 
            if (amount > getBalanceAmount) {
                return Right(new NoSufficientFundsException("No sufficient funds!"))
            } 
            if (amount <= 0) {
                return Right(new IllegalAmountException("Illegal amount!"))
            }
            balance.amount -= amount
            return Left("Success!")
        }
    }

    def deposit (amount: Double): Either[String, RuntimeException] = {
        balance synchronized {
            if (amount <= 0) {
                return Right(new IllegalAmountException("Illegal amount!"))
            }
            balance.amount += amount
            return Left("Successfully added money!")
        }
    }

    def getBalanceAmount: Double = balance.amount

    def transferTo(account: Account, amount: Double) = {
        bank.addTransactionToQueue(this, account, amount)
    }


}
