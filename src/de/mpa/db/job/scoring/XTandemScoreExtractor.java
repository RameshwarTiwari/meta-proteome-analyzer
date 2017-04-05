package de.mpa.db.job.scoring;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import de.proteinms.xtandemparser.xtandem.Domain;
import de.proteinms.xtandemparser.xtandem.Peptide;
import de.proteinms.xtandemparser.xtandem.PeptideMap;
import de.proteinms.xtandemparser.xtandem.Spectrum;
import de.proteinms.xtandemparser.xtandem.XTandemFile;

public class XTandemScoreExtractor extends ScoreExtractor {

	protected XTandemFile xTandemFileTarget;
	protected XTandemFile xTandemFileDecoy;

	/**
	 * Accessing the super constructor.
	 * 
	 * @param targetFile
	 * @param decoyFile
	 */
	public XTandemScoreExtractor(File targetFile) {
		super(targetFile, null);
	}

	/**
	 * Accessing the super constructor.
	 * 
	 * @param targetFile
	 * @param decoyFile
	 */
	public XTandemScoreExtractor(File targetFile, File decoyFile) {
		super(targetFile, decoyFile);
	}

	/**
	 * Loads the X!Tandem output XML files, both target and decoy.
	 */
	protected void load() {
		try {
			this.xTandemFileTarget = new XTandemFile(this.targetFile.getAbsolutePath());
			if (this.decoyFile != null)
				this.xTandemFileDecoy = new XTandemFile(this.decoyFile.getAbsolutePath());
		} catch (SAXException saxException) {
			saxException.getMessage();
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException illAerr) {
			// this error occurs if the targetfile doesn't exist
			// the reason for this is unclear, but most likely no hits where
			// found
			illAerr.printStackTrace();
		}
	}

	/**
	 * This methods extracts the scores from the target and decoy hits.
	 */
	protected void extract() {
		// Initialize the score lists
		this.targetScores = new ArrayList<Double>();
		this.decoyScores = new ArrayList<Double>();

		// Prepare everything for the peptides.
		PeptideMap targetPepMap = this.xTandemFileTarget.getPeptideMap();
		PeptideMap decoyPepMap = this.xTandemFileDecoy.getPeptideMap();

		// Get the peptide hits for the spectra
		String spectrumTitle = "";
		for (Spectrum targetSpectrum : this.xTandemFileTarget.getSpectraList()) {
			int targetSpectrumNumber = targetSpectrum.getSpectrumNumber();
			ArrayList<Peptide> allPeptides = targetPepMap.getAllPeptides(targetSpectrumNumber);
			double bestScore = 0.0;
			// String peptideSequence = "";

			for (Peptide peptide : allPeptides) {
				List<Domain> domains = peptide.getDomains();
				for (Domain psm : domains) {

					if (psm.getDomainHyperScore() > bestScore) {
						bestScore = psm.getDomainHyperScore();
						spectrumTitle = this.xTandemFileTarget.getSupportData(targetSpectrumNumber)
								.getFragIonSpectrumDescription();
						spectrumTitle = this.formatSpectrumTitle(spectrumTitle);
						// peptideSequence = psm.getDomainSequence();
					}
				}
			}
			if (bestScore > 0.0) {
				this.targetScores.add(bestScore);
				// searchHits.add(new CustomSearchHit(bestScore,
				// peptideSequence, spectrumTitle));
			}
		}

		for (Spectrum decoySpectrum : this.xTandemFileDecoy.getSpectraList()) {
			int decoySpectrumNumber = decoySpectrum.getSpectrumNumber();
			ArrayList<Peptide> allPeptides = decoyPepMap.getAllPeptides(decoySpectrumNumber);
			double bestScore = 0.0;
			for (Peptide peptide : allPeptides) {
				List<Domain> domains = peptide.getDomains();
				for (Domain psm : domains) {
					if (psm.getDomainHyperScore() > bestScore) {
						bestScore = psm.getDomainHyperScore();
					}
				}
			}
			if (bestScore > 0.0)
				this.decoyScores.add(bestScore);
		}

		// Sort the targets descending.
		Collections.sort(this.targetScores, Collections.reverseOrder());
		// Sort the decoys descending.
		Collections.sort(this.decoyScores, Collections.reverseOrder());
	}

	@Override
	protected void extractTargetOnly() {
		// Initialize the score lists
		this.targetScores = new ArrayList<Double>();

		// Prepare everything for the peptides.
		PeptideMap targetPepMap = this.xTandemFileTarget.getPeptideMap();

		// Get the peptide hits for the spectra
		for (Spectrum targetSpectrum : this.xTandemFileTarget.getSpectraList()) {
			int targetSpectrumNumber = targetSpectrum.getSpectrumNumber();
			ArrayList<Peptide> allPeptides = targetPepMap.getAllPeptides(targetSpectrumNumber);
			double bestScore = 0.0;
			for (Peptide peptide : allPeptides) {
				List<Domain> domains = peptide.getDomains();
				for (Domain psm : domains) {

					if (psm.getDomainHyperScore() > bestScore) {
						bestScore = psm.getDomainHyperScore();
					}
				}
			}
			this.targetScores.add(bestScore);
		}
		// Sort the targets descending.
		Collections.sort(this.targetScores, Collections.reverseOrder());
	}

	/**
	 * Formatting X!Tandem spectrum titles (latest X!Tandem version).
	 * 
	 * @param spectrumTitle
	 *            Unformatted spectrum title
	 * @return Formatted spectrumTitle
	 */
	private String formatSpectrumTitle(String spectrumTitle) {
		if (spectrumTitle.contains("RTINSECONDS")) {
			spectrumTitle = spectrumTitle.substring(0, spectrumTitle.indexOf("RTINSECONDS") - 1);
		}
		return spectrumTitle;
	}
}
