function simulateClick(obj) {
  var evt = document.createEvent("MouseEvents");
  evt.initMouseEvent("click", true, true, window,
    0, 0, 0, 0, 0, false, false, false, false, 0, null);

  !obj.dispatchEvent(evt);

}

function fixValue(str) {	
	str = str.replace(/\n/g, " ").replace(/"/g, '""')
	return str;
}

function padLeft(value, padding) {
    var zeroes = "0";

    for (var i = 0; i < padding; i++) { zeroes += "0"; }

    return (zeroes + value).slice(padding * -1);
}

function arrayValues(arr) {
	var vals = [];
	for(k in arr)
		vals.push(arr[k]);
	return vals;
}

//only parses city, state, and zip
//input must be of the format San Diego, CA 92101
function parseCityStateZip(address) {
    // Make sure the address is a string.
    if (typeof address !== "string") throw "Address is not a string.";

    // Trim the address.
    address = address.trim();

    // Make an object to contain the data.
    var returned = {};

    // Find the comma.
    var comma = address.indexOf(',');

    // Pull out the city.
    returned.city = address.slice(0, comma);

    // Get everything after the city.
    var after = address.substring(comma + 2); // The string after the comma, +2 so that we skip the comma and the space.

    // Find the space.
    var space = after.lastIndexOf(' ');

    // Pull out the state.
    returned.state = after.slice(0, space);

    // Pull out the zip code.
    returned.zip = after.substring(space + 1);

    // Return the data.
    return returned;
}