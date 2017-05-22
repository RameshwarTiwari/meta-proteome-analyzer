package de.mpa.client.ui.projectpanel.dialogs;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

import de.mpa.client.ui.sharedelements.icons.IconConstants;
import de.mpa.model.MPAExperiment;

@SuppressWarnings("serial")
public class ModifyExperimentDialog extends GeneralDialog {
	
	/**
	 * Creates a Add-Project dialog using the specified
	 * dialog type and content object.
	 * @param type the type of dialog
	 * @param project the content object
	 */
	public ModifyExperimentDialog(MPAExperiment experiment) {
		super(experiment.getTitle(), IconConstants.VIEW_PAGE_ICON.getImage(), experiment.getTitle(), experiment.getProperties());
		saveBtn.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent evt) {
				// store experiment
				try {
					experiment.update(getContentName(), getProperties(), getOperations());
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				result = RESULT_SAVED;
				dispose();
			}
		});
	}
}
