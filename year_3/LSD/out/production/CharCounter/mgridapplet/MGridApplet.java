package mgridapplet;

import java.applet.Applet;
import java.awt.FlowLayout;
import java.io.IOException;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextArea;

/**
 * The developer's M-Grid Job Applet class. It provides a simulation of running their Job
 * Applet on the processing nodes.
 * @author Philip Bennett (pb903@ecs.soton.ac.uk)
 */
public abstract class MGridApplet extends Applet {

	public final void init(){
		//get the parameters from the webpage
		String parameterNumberString = getParameter("parameterNum");
		
		//if no parameters exists prompt the user for a parameter
		String parameter = "";
		if(getParameter("parameter")==null||getParameter("parameter").equals("")){
			String result = (String)JOptionPane.showInputDialog(
			                    this,
			                    "Enter a parameter for the job:\n(Or leave empty if no parameter)",
			                    "M-Grid",
			                    JOptionPane.PLAIN_MESSAGE,
			                    null,
			                    null,
			                    "");
			//set the result as the parameter
			parameter = result;
		}
		else{
			parameter=getParameter("parameter");
		}
		
		
		//set parameter number to 1 if none exists
		int parameterNumber = 1;
		if(parameterNumberString!=null)
			parameterNumber=Integer.parseInt(parameterNumberString);
		initApplet(parameterNumber,parameter);
	}

	/**
	 * Initialises the user's job applet passing the parameters from the server.
	 * <p>
	 * The job code must be placed in this method. The user interface initialisation
	 * code may also be place in this method but any intense graphical code should be 
	 * started in the <code>startApplet</code> method. This code should then be 
	 * stopped in the <code>stopApplet</code> method.
	 * @param parameterNum The parameter number (index)
	 * @param parameter The parameter	 
	 * @see     java.applet.Applet#init()
	 * @see     #destroyApplet()
	 * @see		#startApplet()
	 * @see		#stopApplet()
	 */
	public abstract void initApplet(int parameterNum, String parameter);
	
	public final void destroy(){
		try{
			//start the user's destroy code
			destroyApplet();
		}catch (Exception e) {
			submitException(e);
		}
	}
	
	/**
     * Simular to the <code>destroy</code> method in <code>Applet</code>.
     * Called by the browser or applet viewer to inform
     * this applet that it is being reclaimed and that it should destroy
     * any resources that it has allocated. The <code>stop</code> method
     * will always be called before <code>destroy</code>.
     * <p>
     * A subclass of <code>MGridApplet</code> should override this method if
     * it has any operation that it wants to perform before it is
     * destroyed. For example, an applet with threads would use the
     * <code>initApplet</code> method to create the threads and the
     * <code>destroyApplet</code> method to kill them.
     * <p>
     * The implementation of this method provided by the
     * <code>MGridApplet</code> class does nothing except handling any runtime exceptions.
     * @see     #initApplet(int, String)
     * @see     java.applet.Applet#destroy()
     */
	public void destroyApplet(){}
	
	public final void start(){
		try{
			//start the user's start code
			startApplet();
		}catch (Exception e) {
			submitException(e);
		}
	}
	
	/**
	 * Simular to the <code>start</code> method in <code>Applet</code>.
	 * It is called after the <code>init</code> method and each time the applet 
	 * is revisited in a Web page.
     * <p>
     * A subclass of <code>MGridApplet</code> should only override this method if
     * it has code which is required to be executed everytime the webpage is opened.
     * <p>
     * An example of this is would be a job which has a complex user interface 
     * with animations, etc. Any intense graphical code should be started in this
     * method. This code should then be stopped in the <code>stopApplet</code>
     * method.
     * <p>
     * Job execution code should NOT be put here but in the <code>init</code> method
     * instead!  
     * <p>
     * Note: some methods, such as <code>getLocationOnScreen</code>, can only
     * provide meaningful results if the applet is showing.  Because
     * <code>isShowing</code> returns <code>false</code> when the applet's
     * <code>start</code> is first called, methods requiring
     * <code>isShowing</code> to return <code>true</code> should be called from
     * a <code>ComponentListener</code>.
     * <p>
     * The implementation of this method provided by the
     * <code>MGridApplet</code> class does nothing except handling any runtime exceptions.
     * @see     java.applet.Applet#start()
     * @see 	#stopApplet()
     */
	public void startApplet(){}
	
	public final void stop(){
		try{
			//start the user's stop code
			stopApplet();
		}catch (Exception e) {
			submitException(e);
		}
	}
	
	/**
	 * Simular to the <code>stop</code> method in <code>Applet</code>.
     * It is called when the Web page that contains this applet has been 
     * replaced by another page, and also just before the applet is to be
     * destroyed.
     * <p>
     * A subclass of <code>MGridApplet</code> should only override this method if
     * it has code which is required to be executed everytime the webpage is no
     * longer visible.
     * <p>
     * An example of this is would be a job which has a complex user interface 
     * with animations, etc. Any intense graphical code should be started in the
     * <code>startApplet</code> method. This code should then be stopped in this
     * method.
     * <p>
     * Job execution code should NOT be put here but in the <code>init</code> method
     * instead!  
     * <p>
     * The implementation of this method provided by the <code>MGridApplet</code> class 
     * does nothing except handling any runtime exceptions.
     * @see     java.applet.Applet#stop()
     * @see 	#startApplet()
     */
	public void stopApplet(){}

	/**
	 * Submits the exception to the server to indicate that an exception has occured.
	 * Note: Only fatal exceptions should be sent back to the server because the applet 
	 * is restarted after receiving the exception message.
	 * @param e The exception to send to the server
	 */
	public void submitException(Exception e){
		//an exception has occured in the user's code (causing the applet to stop)
		StackTraceElement[] stacktraceArray = e.getStackTrace();
		String stacktrace= "";
		for(int i=0;i<stacktraceArray.length;i++)
			stacktrace+="\t"+stacktraceArray[i].toString()+"\n";
		submitResults(e.getClass().getCanonicalName()+": "+e.getLocalizedMessage()+"\n"+stacktrace);
	
	}
	
	/**
	 * Submits the results back to the developer as a popup window
	 * @param output The results as a <code>String</code>
	 */
	public final void submitResults(String output){
		JFrame resultsFrame = new JFrame("Job Results");
		resultsFrame.setSize(300,500);
		resultsFrame.setLayout(new FlowLayout());
		JLabel resultsLabel = new JLabel("Incoming Results:");
		resultsFrame.add(resultsLabel);
		JTextArea results = new JTextArea();
		results.setEditable(false);
		resultsFrame.add(results);

		results.append(output);
		resultsFrame.repaint();
		resultsFrame.setVisible(true);
	}
}
