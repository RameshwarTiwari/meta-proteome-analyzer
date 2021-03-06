package de.mpa.fragmentation;

import java.util.Map;

import junit.framework.TestCase;

import org.junit.Before;
import org.junit.Test;

import de.mpa.algorithms.fragmentation.FragmentIon;
import de.mpa.algorithms.fragmentation.Fragmentizer;
import de.mpa.algorithms.fragmentation.Ion.IonType;
import de.mpa.analysis.Masses;

public class FragmentizerTest extends TestCase {

	Fragmentizer fragmentizer;

	@Before
	public void setUp() {
		fragmentizer = new Fragmentizer("LDRLD", Masses.getInstance(), 1);
	}

	/**
	 * Test InsilicoDigester: AIons
	 */
	@Test
	public void testAIons() {
		Map<IonType, FragmentIon[]> fragmentIons = fragmentizer.getFragmentIons();
		FragmentIon[] aIons = fragmentIons.get(IonType.A_ION);
		assertEquals(470.3085, aIons[3].getMZ(), 0.001);
	}

	/**
	 * Test InsilicoDigester: BIons
	 */
	@Test
	public void testBIons() {
		Map<IonType, FragmentIon[]> fragmentIons = fragmentizer.getFragmentIons();
		FragmentIon[] bIons = fragmentIons.get(IonType.B_ION);
		assertEquals(229.1183, bIons[1].getMZ(), 0.001);
	}

	/**
	 * Test InsilicoDigester: BIons -H2O
	 */
	@Test
	public void testbH2O() {
		Map<IonType, FragmentIon[]> fragmentIons = fragmentizer.getFragmentIons();
		FragmentIon[] bH2OIons = fragmentIons.get(IonType.BH2O_ION);
		assertEquals(367.2088, bH2OIons[2].getMZ(), 0.001);
	}

	/**
	 * Test InsilicoDigester: CIons
	 */
	@Test
	public void testCIons() {
		Map<IonType, FragmentIon[]> fragmentIons = fragmentizer.getFragmentIons();
		FragmentIon[] cIons = fragmentIons.get(IonType.C_ION);
		assertEquals(515.3300, cIons[3].getMZ(), 0.001);
	}

	/**
	 * Test InsilicoDigester: XIons
	 */
	@Test
	public void testXIons() {
		Map<IonType, FragmentIon[]> fragmentIons = fragmentizer.getFragmentIons();
		FragmentIon[] xIons = fragmentIons.get(IonType.X_ION);
		assertEquals(160.0240, xIons[0].getMZ(), 0.001);
	}

	/**
	 * Test InsilicoDigester: YIons
	 */
	@Test
	public void testYIons() {
		Map<IonType, FragmentIon[]> fragmentIons = fragmentizer.getFragmentIons();
		FragmentIon[] yIons = fragmentIons.get(IonType.Y_ION);
		assertEquals(247.1288, yIons[1].getMZ(), 0.001);
	}

	/**
	 * Test InsilicoDigester: ZIons
	 */
	@Test
	public void testZIons() {
		Map<IonType, FragmentIon[]> fragmentIons = fragmentizer.getFragmentIons();
		FragmentIon[] zIons = fragmentIons.get(IonType.Z_ION);
		assertEquals(387.2112, zIons[2].getMZ(), 0.001);
	}

}
