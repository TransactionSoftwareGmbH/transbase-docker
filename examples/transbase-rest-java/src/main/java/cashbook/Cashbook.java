package cashbook;

public class Cashbook{
    public String nr;
    public String date;
    public String amount;
    public String comment;

    public Cashbook(String nr, String amount, String date, String comment){
        this.nr = nr;
        this.amount = amount;
        this.date = date;
        this.comment = comment;
    }
}