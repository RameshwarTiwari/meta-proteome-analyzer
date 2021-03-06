package de.mpa.client.settings;

import java.io.IOException;

import junit.framework.TestCase;

import org.junit.Test;

public class SettingsTest extends TestCase {
	
	
	@Test
	public void testXTandemParameters() throws IOException {
		XTandemParameters parameters = new XTandemParameters();
		assertEquals("\t<note type=\"input\" label=\"protein, cleavage site\">[KR]|{P}</note>\n;" + 
					 "\t<note type=\"input\" label=\"protein, cleavage semi\">no</note>\n;" + 
					 "\t<note type=\"input\" label=\"spectrum, fragment mass type\">monoisotopic</note>\n;" +
					 "\t<note type=\"input\" label=\"spectrum, total peaks\">50</note>\n;" +
					 "\t<note type=\"input\" label=\"spectrum, minimum peaks\">15</note>\n;" + 
					 "\t<note type=\"input\" label=\"spectrum, minimum parent m+h\">500.0</note>\n;" +
					 "\t<note type=\"input\" label=\"spectrum, minimum fragment mz\">150.0</note>\n;" + 
					 "\t<note type=\"input\" label=\"spectrum, threads\">4</note>\n;" + 
					 "\t<note type=\"input\" label=\"spectrum, sequence batch size\">1000</note>\n;" + 
					 "\t<note type=\"input\" label=\"refine\">yes</note>\n;" + 
					 "\t<note type=\"input\" label=\"refine, spectrum synthesis\">yes</note>\n;" + 
					 "\t<note type=\"input\" label=\"refine, maximum valid expectation value\">0.1</note>\n;" + 
					 "\t<note type=\"input\" label=\"refine, point mutations\">no</note>\n;" + 
					 "\t<note type=\"input\" label=\"scoring, minimum ion count\">4</note>\n;" +
                     "\t<note type=\"input\" label=\"scoring, x ions\">no</note>\n;" + 
                     "\t<note type=\"input\" label=\"scoring, y ions\">yes</note>\n;" + 
                     "\t<note type=\"input\" label=\"scoring, z ions\">no</note>\n;" + 
                     "\t<note type=\"input\" label=\"scoring, a ions\">no</note>\n;" + 
                     "\t<note type=\"input\" label=\"scoring, b ions\">yes</note>\n;" + 
                     "\t<note type=\"input\" label=\"scoring, c ions\">no</note>\n;", parameters.toString());
	}
	
	@Test
	public void testOmssaParameters() {
		OmssaParameters parameters = new OmssaParameters();
		assertEquals("-e 0 -tom 0 -tem 0 -zt 3 -ht 6 -nt 4 -hm 2 -hl 30 -he 1000.0", parameters.toString());
	}
	
	@Test
	public void testCruxParameters() {
		CruxParameters parameters = new CruxParameters();
		assertEquals("enzyme=trypsin\n" + 
					 "fragment-mass=mono\n" + 
					 "min-peaks=20\n" + 
					 "use-flanking-peaks=false\n" + 
					 "top-match=5\n" + 
					 "min-length=7\n" + 
					 "max-length=50\n" + 
					 "min-mass=200.0\n" + 
					 "max-mass=7200.0\n", parameters.toString());
	}
	
	@Test
	public void testInspectParameters() {
		InspectParameters parameters = new InspectParameters();
		assertEquals("protease,Trypsin\nmod,+57,C,fix\nmod,+16,M,opt\nMods,1\nUnrestrictive,0\nMultiCharge,1\nInstrument,ESI-ION-TRAP\nTagCount,100\nTagLength,3\n", parameters.toString());
	}

}
