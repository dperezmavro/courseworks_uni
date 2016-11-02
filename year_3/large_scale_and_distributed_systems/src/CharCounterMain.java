import java.io.BufferedReader;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class CharCounterMain{
    final static Charset enc = StandardCharsets.US_ASCII ;

    public CharCounterMain(String ch, String filedir){
        if(ch.length() != 1){
            System.out.println("The first argument needs to be a char, found string of length "+ch.length());
            System.exit(1);
        }

        char c = ch.charAt(0);
        if( c != ' ' && c != '.' &&  Character.getNumericValue(c) < 97 && Character.getNumericValue(c) > 122 ){ //compare against the ascii integer values
            System.out.println("Need a character in range a-z (lowercase only) or a whitespace or a dot, found "+c+"!");
            System.exit(1);
        }

        Path p = Paths.get(filedir);
        try {
            BufferedReader bf = Files.newBufferedReader(p,enc);
            String line;
            String line2 = null ;
            while((line = bf.readLine()) != null){
                line2 += line ;
            }
            CharCounter cc = new CharCounter(c,line2);
            int freq = cc.getFrequency();

            System.out.println(String.format("Frequency of character %c was %d", c,freq));

        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println("Finished, exiting...");
    }

    public static void main(String[] args){
        if(args.length != 2){
            System.out.println("Usage : CharCounterMain <char-to-look-for> <text-file-dir>");
        }else{
            new CharCounterMain(args[0],args[1]);
        }
    }


}
