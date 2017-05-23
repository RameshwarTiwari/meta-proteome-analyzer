package de.mpa.client.ui.sharedelements.dialogs;

import java.io.File;

import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

import de.mpa.client.ui.sharedelements.ExtensionFileFilter;

/**
 * File chooser which asks for confirmation when selecting an existing file in
 * the save dialog.
 * 
 * @author A. Behne
 */
@SuppressWarnings("serial")
public class ConfirmFileChooser extends JFileChooser {

	/**
	 * Constructs a <code>ConfirmFileChooser</code> pointing to the user's
	 * default directory.
	 */
	public ConfirmFileChooser() {
    }

	/**
	 * Constructs a <code>ConfirmFileChooser</code> using the given path.
	 * Passing in a null string causes the file chooser to point to the user's
	 * default directory.
	 * @param currentDirectoryPath
	 *            a <code>String</code> giving the path to a file or directory
	 */
	public ConfirmFileChooser(String currentDirectoryPath) {
		super(currentDirectoryPath);
	}

	@Override
	public void approveSelection() {
		if (this.getDialogType() == JFileChooser.SAVE_DIALOG) {
			File selFile = getSelectedFile();
			// check whether an extension is required
			if (getFileFilter() instanceof ExtensionFileFilter) {
				ExtensionFileFilter filter = (ExtensionFileFilter) getFileFilter();
				if (!filter.accept(selFile)) {
					// append extension
					selFile = new File(selFile + filter.getExtension());
                    setSelectedFile(selFile);
				}
			}
			// check whether selected file descriptor points to an existing file
			if (selFile.exists()) {
				// ask for confirmation to overwrite
				int result = JOptionPane.showConfirmDialog(this, "A file with the selected name already exists. Do you want to replace it?", "Confirm overwrite", JOptionPane.YES_NO_CANCEL_OPTION);
				// check whether approve option has been chosen
				switch (result) {
				case 0:
					break;
				case 1:
					return;
				case 2:
					cancelSelection();
					return;
				}
			}
		}
		super.approveSelection();
	}
	
}