package de.mpa.graphdb.properties;

public enum PathwayProperty implements ElementProperty {
	IDENTIFIER("Identifier"),
	DESCRIPTION("Description"),
	PATHWAYID("pathwayid");
	
	PathwayProperty(final String propertyName){
		this.propertyName = propertyName;
	}
	
	private final String propertyName;
	
	@Override
	public String toString() {
		return propertyName;
	}
}

