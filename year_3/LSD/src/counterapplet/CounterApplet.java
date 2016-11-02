package counterapplet;

import mgridapplet.MGridApplet;
import java.awt.*;
import java.io.*;
import java.util.*;
import javax.swing.*;

public class CounterApplet extends MGridApplet{

    private Map<Character,Integer> allowed= new HashMap<Character,Integer>();
    private JTextArea txtarea = new JTextArea(20,30);
    private InputStream in ;
    private InputStreamReader isr ;
    private BufferedReader br ;

    @Override
    public void initApplet(int parameterNum, String parameter) {
        /*display stuff*/
        setLayout(new FlowLayout());
        txtarea.setEditable(false);
        add(txtarea);
        this.setVisible(true);
        /*end display stuff*/
        initAllowed();

        String[] args = parameter.split(":");
        if(args.length != 2){
            txtarea.append("Parameter must have format\n<char>:<String> and both need to be non-empty...\n");
            submitResults("Parameter must have format\n" +
                    "<char>:<String> and both need to be non-empty...\n");
        }else if(args[0].length() != 1 || args[1].length() < 1){
            txtarea.append("<char>:<String> both need to be non-empty...");
            submitResults("<char>:<String> both need to be non-empty...");
        }else{
            try{
                in = getClass().getResourceAsStream(args[1]);
                isr = new InputStreamReader(in);
                br = new BufferedReader(isr);

                String line, str = null, ch = args[0];
                char c = ch.charAt(0);

                while((line = br.readLine()) != null){
                    str += line ;
                }
                c = (c=='$') ? ' ' : c; //using plain ' ' in text file gives errors, So I will use $ to denote whitespace

                if(allowed.containsKey(c)){
                    txtarea.append("Starting frequency counter, looking for character : "+c+" (ASCII "+((int) c)+")\n");

                    int fr = getFrequency(c,str); //get the frequency

                    txtarea.append(String.format("Frequency of %c is %d\n",c,fr));
                    txtarea.append("Finished, exiting...\n");
                    submitResults(String.format("Frequency of %c is %d\n",c,fr));
                }else{
                    txtarea.append("Need a character in range: \n>a-z (lowercase only) \n>or a whitespace \n>or a dot \n>but found "+c+" !");
                    submitResults(String.format("Need a char in range a-z,space or, dot , but found %c\n",c));
                }
            } catch (IOException e) {
                txtarea.append("Exception :\n"+e.getMessage()+"\n");
                submitResults("Exception :\n \t"+e.getMessage()+"\n");
            }
        }
    }

    public int getFrequency(char c , String doc){
        for(int i = 0 ; i < doc.length(); i++){
            if (c == doc.charAt(i)){
                allowed.put(c,allowed.get(c)+1);
            }
        }
        return allowed.get(c);
    }

    private void initAllowed(){
        //add all ascii characters
        for (int i = 97 ; i < 123 ; i++){
            char c = (char) i;
            allowed.put(c,0);
        }

        allowed.put(' ',0);
        allowed.put('.',0);
    }
}
