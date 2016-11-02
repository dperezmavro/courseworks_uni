import org.icenigrid.gridsam.client.common.ClientSideJobManager;
import org.icenigrid.gridsam.core.*;
import org.icenigrid.gridsam.core.jsdl.JSDLSupport;
import org.icenigrid.schema.jsdl.y2005.m11.*; 
import org.apache.xmlbeans.XmlException; 
import java.io.*;
import java.util.*  ;

public class GridSAMExample {

	private static String ftpServer = System.getProperty("ftp.server");
	private static String gridsamServer = System.getProperty("gridsam.server");

	public static void main(String[] args) throws JobManagerException, SubmissionException, UnsupportedFeatureException, UnknownJobException, IOException, XmlException, InterruptedException {

		System.out.println("Creating a new client Job Manager...");
		ClientSideJobManager jobManager = new ClientSideJobManager(
			new String[] { "-s", gridsamServer },
			ClientSideJobManager.getStandardOptions());

		System.out.println("Creating JSDL description...");
		String xJSDLString  = createJSDLDescription("/bin/echo", "Hello world!");
		JobDefinitionDocument xJSDLDocument = JobDefinitionDocument.Factory.parse(xJSDLString);

		System.out.println("Submitting job to Job Manager...");
		JobInstance job = jobManager.submitJob(xJSDLDocument);
		String jobID = job.getID();

		// Get and report the status of job until complete
		System.out.println("Job ID: " + jobID);
			
		String state = "";
 		do{
			state  = jobManager.findJobInstance(jobID).getLastKnownStage().getState().toString();
			System.out.println("-->Status of "+jobID+" is "+state);
			Thread.sleep(1000);
		}while(!state.equals("done") && !state.equals("failed"));
	}

	private static String createJSDLDescription(String execName, String args) {
		String ret = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" ;
		ret += "<JobDefinition xmlns=\"http://schemas.ggf.org/jsdl/2005/11/jsdl\">";
			ret += "<JobDescription>";
				ret += "<JobIdentification>";
					ret += "<JobName>Job</JobName>";
					ret += "<Description>Test job</Description>";
					ret += "<JobAnnotation>no annotation</JobAnnotation>";
					ret += "<JobProject>gridsam project</JobProject>";
				ret += "</JobIdentification>";
				ret += "<Application>";
					ret += "<POSIXApplication xmlns=\"http://schemas.ggf.org/jsdl/2005/11/jsdl-posix\">";
						ret += "<Executable>"+execName+"</Executable>";
						ret += "<Argument>"+args+"</Argument>";
						ret += "<Output>stdout.txt</Output>";
						ret += "<Error>stderr.txt</Error>";
					ret += "</POSIXApplication>";
				ret += "</Application>";
				ret += "<DataStaging>";
					ret += "<FileName>stdout.txt</FileName>";
					ret += "<CreationFlag>overwrite</CreationFlag>";
					ret += "<DeleteOnTermination>true</DeleteOnTermination>";
					ret += "<Target>";
						ret += "<URI>ftp://localhost:55521/stdout.txt</URI>";
					ret += "</Target>";
				ret += "</DataStaging>";
				ret += "<DataStaging>";
					ret += "<FileName>stderr.txt</FileName>";
					ret += "<CreationFlag>overwrite</CreationFlag>";
					ret += "<DeleteOnTermination>true</DeleteOnTermination>";
					ret += "<Target>";
						ret += "<URI>ftp://localhost:55521/stderr.txt</URI>";
					ret += "</Target>";
				ret += "</DataStaging>";
			ret +="</JobDescription>";
		ret += "</JobDefinition>";
		
		return ret ; //return xml string
	}
}