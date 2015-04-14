package de.mpa.job;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Properties;

import javax.swing.JOptionPane;

import org.jdesktop.swingx.JXErrorPane;
import org.jdesktop.swingx.error.ErrorInfo;
import org.jdesktop.swingx.error.ErrorLevel;

import de.mpa.client.Constants;
import de.mpa.client.ui.ClientFrame;
import de.mpa.main.Starter;

public class ResourceProperties {
	
	/**
	 * Properties instance.
	 */
	private Properties prop;
	
	/**
	 * JobProperties instance.
	 */
	private static ResourceProperties instance;
    
	/**
	 * Constructor for the database manager.
	 * @throws IOException 
	 */
    private ResourceProperties() throws IOException  {
    	loadResourcesSettings();
	}
    
    /**
     * Returns an instance of the JobProperties.
     * @return JobProperties instance.
     * @throws IOException 
     */
    public static ResourceProperties getInstance() {
    	if (instance == null) {
    		try {
				instance = new ResourceProperties();
			} catch (IOException e) {
				e.printStackTrace();
				JXErrorPane.showDialog(ClientFrame.getInstance(), new ErrorInfo("Severe Error", e.getMessage(), null, null, e, ErrorLevel.SEVERE, null));
			}
    	}
		return instance;
    } 
    
    /**
     * Loads the resources settings from an external text file.
     * @throws IOException
     */
	private void loadResourcesSettings() throws IOException {
		prop = new Properties();
		// Load the resources settings via input stream.
		InputStream inputStream = null;
		String path = "";
		if (Starter.isJarExport()) {
			path = getJarFilePath(this.getClass().getResource("ResourceProperties.class").getPath(), "mpa-portable");
			inputStream = new FileInputStream(Constants.CONFIGURATION_PATH_JAR + File.separator + "algorithm-properties.txt");
		} else {
			path = getBasePath(this.getClass().getResource("ResourceProperties.class").getPath(), "/bin/de/mpa");
			inputStream = this.getClass().getResourceAsStream(Constants.CONFIGURATION_PATH + "algorithm-properties.txt");
		}
		
		if (path.indexOf(" ") != -1) {
			throw new IOException("The file path contains at least one white space. Please rename your folders to avoid any white spaces...");
		}
		prop.load(inputStream);
		
		prop.setProperty("path.fasta", path + "/built/fasta");
		prop.setProperty("path.taxonomy", path + "/built/taxonomy/");
		prop.setProperty("path.base", path);
		
		if (Starter.isWindows()) {
			prop.setProperty("path.xtandem", formatPath(path + "/built/X!Tandem/windows/windows_64bit"));
			prop.setProperty("path.xtandem.output", formatPath(path + "/built/output/X!Tandem/"));			
			prop.setProperty("path.omssa", formatPath(path + "/built/OMSSA/windows"));
			prop.setProperty("path.omssa.output", formatPath(path + "/built/output/OMSSA/"));
			prop.setProperty("app.omssa", "omssacl.exe");
			prop.setProperty("path.makeblastdb", formatPath(path + "/built/makeblastdb/windows/"));
			prop.setProperty("app.makeblastdb", "makeblastdb.exe");
			prop.setProperty("path.qvality", formatPath(path + "/built/QVality/windows/"));
			prop.setProperty("app.qvality", "qvality.exe");
		}
		inputStream.close();
	}
	
	/**
	 * Returns the job property for a given parameter.
	 * @param key
	 * @return
	 */
	public String getProperty(String key) {
		return prop.getProperty(key);
	}
	
	public static String formatPath(String unformatted) {
        if (System.getProperty("os.name").lastIndexOf("Windows") != -1) {
        	unformatted = unformatted.replace("/", "\\");
        }
        return unformatted;
	}
	
    public static String getBasePath(String classPath, String toolName) {
        String path = classPath;
        if (path.lastIndexOf(toolName) != -1) {
            path = path.substring(1, path.lastIndexOf(toolName));
            path = path.replace("%20", " ");
            path = path.replace("%5b", "[");
            path = path.replace("%5d", "]");

            path = formatPath(path);
        } else {
            path = ".";
        }
        
        return path;
    }
    
    public static String getJarFilePath(String classPath, String toolName) {

        String path = classPath;
        toolName = toolName + "-";

        if (path.lastIndexOf("/" + toolName) != -1) {
            // remove starting 'file:' tag if there
            if (path.startsWith("file:")) {
                path = path.substring("file:".length() + 1, path.lastIndexOf("/" + toolName));
            } else {
                path = path.substring(0, path.lastIndexOf("/" + toolName));
            }
            path = path.replace("%20", " ");
            path = path.replace("%5b", "[");
            path = path.replace("%5d", "]");
            
            path = formatPath(path);
        } else {
            path = ".";
        }

        try {
            if (!new File(path).exists()) {
                path = URLDecoder.decode(path, "UTF-8");
            }
            if (!new File(path).exists()) {
                JOptionPane.showMessageDialog(null, path + " not found!", "File Error", JOptionPane.ERROR_MESSAGE);
            }
        } catch (UnsupportedEncodingException ex) {
            JOptionPane.showMessageDialog(null, "Error reading file " + path + ".", "File Error", JOptionPane.ERROR_MESSAGE);
            ex.printStackTrace();
        }

        return path;
    }

	

}