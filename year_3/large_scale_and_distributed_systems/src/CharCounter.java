public class CharCounter {

    private char c ;
    private String doc ;
    private int len ;

    public CharCounter(char c, String s){
        this.c = c ;
        this.doc = s ;
        this.len = doc.length();
    }

    public int getFrequency(){
        int res = 0 ;
        for(int i = 0 ; i < len; i++){
            if (c == doc.charAt(i)){
                res++;
            }
        }
        return res;
    }
}
