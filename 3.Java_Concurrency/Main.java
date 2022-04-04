import Implementation.ImplementRunnable;
import Implementation.ImplementThread;

public class Main {
    public static void main(String[] args) {
        ImplementThread threadFromThreadOne = new ImplementThread();
        ImplementThread threadFromThreadTwo = new ImplementThread();
        ImplementThread threadFromThreadThree = new ImplementThread();

        // Calling run would just invoke the method run without creating a new thread.
        threadFromThreadOne.start();
        threadFromThreadTwo.start();
        threadFromThreadThree.start();

        ImplementRunnable threadFromRunnable = new ImplementRunnable();
        threadFromRunnable.run();
        threadFromRunnable.run();


    }
}

// How many ways are to create Threads in Java?
// 2. Interface or Class.