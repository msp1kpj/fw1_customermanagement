component output="false" displayname="Format Utility" {
	// ------------------------ CONSTRUCTOR ------------------------ //

	public model.Utility.FormatUtility function init() {
		return this;
	}


/**
	 * Allows you to specify the mask you want added to your phone number.
	 * v2 - code optimized by Ray Camden
	 * v3.01
	 * v3.02 added code for single digit phone numbers from John Whish
	 * v4 make a default format - by James Moberg
	 *
	 * @param varInput      Phone number to be formatted. (Required)
	 * @param varMask      Mask to use for formatting. x represents a digit. Defaults to (xxx) xxx-xxxx (Optional)
	 * @return Returns a string.
	 * @author Derrick Rapley (adrapley@rapleyzone.com)
	 * @version 4, February 11, 2011
	 */
	public string function phoneFormat(varInput) {
		var curPosition = "";
		var i = "";
		var varMask = "(xxx) xxx-xxxx";
		var newFormat = "";
		var startpattern = "";
		if (arrayLen(arguments) gte 2){ varMask = arguments[2]; }
		newFormat = trim(ReReplace(varInput, "[^[:digit:]]", "", "all"));
		startpattern = ReReplace(ListFirst(varMask, "- "), "[^x]", "", "all");
		if (Len(newFormat) gte Len(startpattern)) {
			varInput = trim(varInput);
			newFormat = " " & reReplace(varInput,"[^[:digit:]]","","all");
			newFormat = reverse(newFormat);
			varmask = reverse(varmask);
			for (i=1; i lte len(trim(varmask)); i=i+1) {
				curPosition = mid(varMask,i,1);
				if(curPosition neq "x") newFormat = insert(curPosition,newFormat, i-1) & " ";
			}
			newFormat = reverse(newFormat);
			varmask = reverse(varmask);
		}
		return trim(newFormat);
	}
}