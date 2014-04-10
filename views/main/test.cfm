<h1><center>Melissa Data: DQWS V2 REST Web Service (JavaScript)</center></h1>
        <table align="center" cellpadding='0' cellspacing='0' width='800' border='0' style='font-family:arial;font-size:7.8pt'>
                    <thead>
                        <tr align="left"  valign="top">
                            <th><TITLE>Melissa Data: DQWS V2 REST Web Service (JavaScript)</TITLE>

                                <h2>Input:</h2>

                                Customer ID &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp; Company
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="pCustomerID" ROWS=1 VALUE="109751654" SIZE=10>
                                &nbsp;&nbsp;
                                <INPUT TYPE = "Text"COLS=10 NAME="pCompany" ROWS=1 VALUE="" SIZE=30><br>
                                Address1
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="pAddress1" ROWS=1 VALUE="" SIZE=30><br>

                                Address2
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="pAddress2" ROWS=1 VALUE="" SIZE=30><br>

                                Suite
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="pSuite" ROWS=1 VALUE="" SIZE=30><br>

                                City
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="pCity" ROWS=1 VALUE="" SIZE=30><br>

                                Urbanization &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Private Mailbox
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="pUrbanization" ROWS=1 VALUE="" SIZE=13>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <INPUT TYPE = "Text"COLS=10 NAME="pPMB" ROWS=1 VALUE="" SIZE=13><br>

                                State &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                Zip &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                Plus 4
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="pState" ROWS=1 VALUE="" SIZE=2>
                                &nbsp;
                                <INPUT TYPE = "Text"COLS=10 NAME="pZip" ROWS=1 VALUE="" SIZE=5>
                                &nbsp;
                                <INPUT TYPE = "Text"COLS=10 NAME="pPlus4" ROWS=1 VALUE="" SIZE=5><br>

                                Country &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                Last Name
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="pCountry" ROWS=1 VALUE="" SIZE=13> &nbsp;

                                <INPUT TYPE = "Text"COLS=10 NAME="pLastName" ROWS=1 VALUE="" SIZE=13><br>

                                <P><INPUT id=button1 name=button1 type=button value="Verify Address->"></P>

                            </th>
                            <th valign="top"><h2>Output:</h2>
                                Version &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total Records
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="outVersion" ROWS=1 VALUE="" SIZE=10>
                                    &nbsp;&nbsp;
                                    <INPUT TYPE = "Text"COLS=10 NAME="outTotal" ROWS=1 VALUE="" SIZE=5><br>

                                Initialize Results
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="outInitResults" ROWS=1 VALUE="" SIZE=50><br>

                                Address1
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="outAddress1" ROWS=1 VALUE="" SIZE=30><br>

                                Address2
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="outAddress2" ROWS=1 VALUE="" SIZE=30><br>

                                Company &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;City
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="outCompany" ROWS=1 VALUE="" SIZE=20>
                                &nbsp;&nbsp;

                                <INPUT TYPE = "Text"COLS=10 NAME="outCity" ROWS=1 VALUE="" SIZE=25><br>

                                State &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                Zip &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                Plus4 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                Country
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="outState" ROWS=1 VALUE="" SIZE=2>
                                &nbsp;

                                <INPUT TYPE = "Text"COLS=10 NAME="outZip" ROWS=1 VALUE="" SIZE=5>
                                &nbsp;

                                <INPUT TYPE = "Text"COLS=10 NAME="outPlus4" ROWS=1 VALUE="" SIZE=4>
                                &nbsp;

                                <INPUT TYPE = "Text"COLS=10 NAME="outCountry" ROWS=1 VALUE="" SIZE=23><br>

                                Range &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                Street Name
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="outRange" ROWS=1 VALUE="" SIZE=10>
                                &nbsp;
                                <INPUT TYPE = "Text"COLS=10 NAME="outStreetName" ROWS=1 VALUE="" SIZE=30><br>

                                Suffix &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                Pre Direction &nbsp;&nbsp;
                                Post Direction &nbsp;&nbsp;
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="outSuffix" ROWS=1 VALUE="" SIZE=4>
                                &nbsp;&nbsp;&nbsp;

                                <INPUT TYPE = "Text"COLS=10 NAME="outPreDir" ROWS=1 VALUE="" SIZE=2>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                <INPUT TYPE = "Text"COLS=10 NAME="outPostDir" ROWS=1 VALUE="" SIZE=2><br>

                                Suite Name &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                Suite Number&nbsp;&nbsp;&nbsp;
                                PMB Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                PMB Number
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="outSuiteName" ROWS=1 VALUE="" SIZE=8>


                                <INPUT TYPE = "Text"COLS=10 NAME="outSuiteNumber" ROWS=1 VALUE="" SIZE=8>


                                <INPUT TYPE = "Text"COLS=10 NAME="outPMBName" ROWS=1 VALUE="" SIZE=8>


                                <INPUT TYPE = "Text"COLS=10 NAME="outPMBNumber" ROWS=1 VALUE="" SIZE=8><br>

                                Urbanization Name &nbsp;&nbsp;&nbsp;
                                Urbanization Code&nbsp;&nbsp;&nbsp;
                                DPC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                DPC Digit
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="outUrbName" ROWS=1 VALUE="" SIZE=12>
                                &nbsp;
                                <INPUT TYPE = "Text"COLS=10 NAME="outUrbCode" ROWS=1 VALUE="" SIZE=11>
                                &nbsp;

                                <INPUT TYPE = "Text"COLS=10 NAME="outDPC" ROWS=1 VALUE="" SIZE=5>
                                &nbsp;

                                <INPUT TYPE = "Text"COLS=10 NAME="outDPCD" ROWS=1 VALUE="" SIZE=5><br>

                                Carrier Route &nbsp;&nbsp;
                                Address Key
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="outCarrierRoute" ROWS=1 VALUE="" SIZE=6>
                                &nbsp;&nbsp;

                                <INPUT TYPE = "Text"COLS=10 NAME="outAddressKey" ROWS=1 VALUE="" SIZE=15><br>

                                Congressional District
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="outCongessDistrict" ROWS=1 VALUE="" SIZE=15><br>

                                Address Result Codes
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="outAddressErrorCode" ROWS=1 VALUE="" SIZE=15><br>

                                Address Result String
                                <BR><INPUT TYPE = "Text"COLS=10 NAME="outAddressErrorString" ROWS=1 VALUE="" SIZE=50>



                                </th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
        </table>
        <br>
        <br>

        <table border="0" align="center">
            <thead>
                <tr>
                    <th><P>XML Response:<BR><textarea  rows="30" name="responseXML" cols="100"></textarea></th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
<cfmodule template="/customtags/htmlfoot.cfm">
        <script type="text/javascript">
            $(document).ready(function($) {
                // URL for REST http request
                var urlRest = "?action=main.testAjax"


                $("input[name=pCustomerID]").val("109751654");
                $("input[name=pCompany]").val("Melissa Data");
                $("input[name=pAddress1]").val("22382 Avenida Empresa");
                $("input[name=pAddress2]").val("Rancho Santa Margarita");
                $("input[name=pCity]").val("");
                $("input[name=pState]").val("CA");
                $("input[name=pZip]").val("92688");

                $("#button1").click(function(){
                    var REQUEST = "";
                    var result;

                    // Create address to check for the REST Request
                    REQUEST += "?t=" + "Testing: DQWS REST Sample Code implementation using multiple record inputs.";
                    REQUEST += "&id=" + $("input[name=pCustomerID]").val();
                    REQUEST += "&opt=" + "true"  //Parsing set to true, default is false
                    REQUEST += "&comp=" + $("input[name=pCompany]").val();
                    //REQUEST += "&u=" + pUrbanization.value;
                    REQUEST += "&a1=" + $("input[name=pAddress1]").val();
                    REQUEST += "&a2=" + $("input[name=pAddress2]").val();
                    //REQUEST += "&ste=" + pSuite.value;
                    //REQUEST += "&pmb=" + pPMB.value;
                    REQUEST += "&city=" + $("input[name=pCity]").val();
                    REQUEST += "&state=" + $("input[name=pState]").val();
                    REQUEST += "&zip=" + $("input[name=pZip]").val();
                    //REQUEST += "&p4=" + pPlus4.value;
                    //REQUEST += "&ctry=" + pCountry.value;
                    //REQUEST += "&last=" + pLastName.value;

                    $.ajax(
                    {
                        type: "POST",
                        url: urlRest,
                        data: REQUEST,
                        dataType: "xml",
                        crossDomain: true,
                        async: false,
                        success: function(xml){
                            var data = $('doctor',xml).text();
                            alert(data);
                        }
                    });
                });
            });

            //Global Variables
            var REQUEST = ""
            var result

            // load XML document
            var xmlDoc=new ActiveXObject("Microsoft.XMLDOM")
            xmlDoc.async="false"

            // Function for doing address verification
            function clickFunction()
            {
                clearOutFields()

                // Create address to check for the REST Request
                REQUEST += "?t=" + "Testing: DQWS REST Sample Code implementation using multiple record inputs."
                REQUEST += "&id=" + pCustomerID.value
                REQUEST += "&opt=" + "true"  //Parsing set to true, default is false
                REQUEST += "&comp=" + pCompany.value
                REQUEST += "&u=" + pUrbanization.value
                REQUEST += "&a1=" + pAddress1.value
                REQUEST += "&a2=" + pAddress2.value
                REQUEST += "&ste=" + pSuite.value
                REQUEST += "&pmb=" + pPMB.value
                REQUEST += "&city=" + pCity.value
                REQUEST += "&state=" + pState.value
                REQUEST += "&zip=" + pZip.value
                REQUEST += "&p4=" + pPlus4.value
                REQUEST += "&ctry=" + pCountry.value
                REQUEST += "&last=" + pLastName.value



                // Send in address and receive results as XML document
                var xmlHttp=new ActiveXObject("Microsoft.XMLHTTP")

                // HTTP Request
                xmlHttp.open("GET", urlRest + REQUEST, false)

                xmlHttp.send(null)

                // Store Response
                responseXML.value = xmlHttp.responseXML.xml

                // Load XML Document for parsing
                xmlDoc.loadXML(xmlHttp.responseText)

                result = xmlDoc.getElementsByTagName("Results")

                currentRecord = 1

                // Populate top fields
                outputTopFields(result)

                // Populate Record Fields
                outputCurrentRecord(currentRecord)

                // Empty Request after verification
                REQUEST = ""
            }


            function outputTopFields(resultList)
            {
                var Version = xmlDoc.getElementsByTagName("Version")
                var Total = xmlDoc.getElementsByTagName("TotalRecords")

                outVersion.value = Version(0).firstChild.nodeValue
                outTotal.value = Total(0).firstChild.nodeValue

                for (var i = 0; i < resultList.length; i++)
                {
                    if (resultList(i).parentNode.nodeName == "ResponseArray")
                    {
                        if (resultList(i).hasChildNodes)
                        {
                            //Handle Initialize result codes
                            var errorCode = resultList(i).firstChild.nodeValue
                            if (errorCode == "SE01")
                                outInitResults.value += errorCode + ": Web Service Internal Error;  "
                            else if (errorCode  == "GE01")
                                outInitResults.value += errorCode + ": Empty XML Request Structure;  "
                            else if (errorCode  == "GE02")
                                outInitResults.value += errorCode + ": Empty XML Request Record Structure;  "
                            else if (errorCode  == "GE03")
                                outInitResults.value += errorCode + ": Counted records send more than number of records allowed per request;  "
                            else if (errorCode  == "GE04")
                            {
                                outInitResults.value += errorCode + ": CustomerID empty;  "
                                alert("Please enter your Customer ID")
                            }
                            else if (errorCode == "GE05")
                            {
                                outInitResults.value += errorCode + ": CustomerID not valid;  "
                                alert("The Customer ID your entered is invalid. To retrieve a valid " +
                                    "Customer ID, please contact a Melissa Data Sales Representative " +
                                    "at 800-MELISSA ext. 3 (800-800-6245 ext. 3).")
                            }

                            else if (errorCode  == "GE06")
                            {
                                outInitResults.value += errorCode + ": CustomerID disabled;  "
                                alert("The Customer ID your entered has been disabled. " +
                                    "Please contact a Melissa Data Sales Representative " +
                                    "at 800-MELISSA ext. 3 (800-800-6245 ext. 3). ")
                            }
                            else if (errorCode  == "GE07")
                            {
                                outInitResults.value += errorCode + ": XML Request invalid;  "
                            }

                        }
                        else
                        {
                            outInitResults.value += "No Error"
                        }
                    }
                }
            }

            function outputCurrentRecord(currentRecord)
            {
                var record = xmlDoc.getElementsByTagName("Record")

                // Search through the records list, and find the match to currentRecord
                for (var i = 0; i < record.length; i++)
                {
                    if (record(i).firstChild.firstChild.nodeValue == currentRecord)
                    {
                        recurseSubTree(record(i).childNodes)
                    }
                }
            }

            // Recursive call to travers subtree of the desired record
            function recurseSubTree(nodeList)
            {
                for (var i = 0; i <  nodeList.length; i++)
                {
                    if (nodeList(i).hasChildNodes)
                    {
                        recurseSubTree(nodeList(i).childNodes)

                    }
                    else
                    {
                        // This is where we output everything under a record subtree
                        if(nodeList(i).nodeValue != null)
                        {
                            //alert (nodeList(i).parentNode.nodeName)

                            if(nodeList(i).parentNode.nodeName == "Address1")
                            {
                                outAddress1.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "Address2")
                            {
                                outAddress2.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "Company")
                            {
                                outCompany.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "Zip")
                            {
                                outZip.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "Plus4")
                            {
                                outPlus4.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "CarrierRoute")
                            {
                                outCarrierRoute.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "DeliveryPointCode")
                            {
                                outDPC.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "DeliveryPointCheckDigit")
                            {
                                outDPCD.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "AddressKey")
                            {
                                outAddressKey.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "StreetName")
                            {
                                outStreetName.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "AddressRange")
                            {
                                outRange.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "Suffix")
                            {
                                outSuffix.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "Post")
                            {
                                outPostDir.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "Pre")
                            {
                                outPreDir.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "CongressionalDistrict")
                            {
                                outCongessDistrict.value = nodeList(i).nodeValue
                            }


                            //Handle Repeated Values: Name, Results, Code, Range, Abbreviation

                            else if (nodeList(i).parentNode.nodeName == "Name")
                            {
                                if (nodeList(i).parentNode.parentNode.nodeName == "Urbanization")
                                    outUrbName.value = nodeList(i).nodeValue
                                else if (nodeList(i).parentNode.parentNode.nodeName == "City")
                                    outCity.value = nodeList(i).nodeValue
                                else if (nodeList(i).parentNode.parentNode.nodeName == "Country")
                                    outCountry.value = nodeList(i).nodeValue
                                else if (nodeList(i).parentNode.parentNode.nodeName == "Suite")
                                    outSuiteName.value = nodeList(i).nodeValue
                                else if (nodeList(i).parentNode.parentNode.nodeName == "PrivateMailbox")
                                    outPMBName.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "Results")
                            {
                                if (nodeList(i).parentNode.parentNode.nodeName == "Record")
                                {
                                    outAddressErrorCode.value = nodeList(i).nodeValue

                                    // Each Error Code has a corresponding meaning, print them out.
                                    printErrorCodes(nodeList(i).nodeValue)
                                }
                            }
                            else if (nodeList(i).parentNode.nodeName == "Code")
                            {
                                if (nodeList(i).parentNode.parentNode.nodeName == "Urbanization")
                                    outUrbCode.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "Range")
                            {
                                if (nodeList(i).parentNode.parentNode.nodeName == "Suite")
                                    outSuiteNumber.value = nodeList(i).nodeValue
                                else if (nodeList(i).parentNode.parentNode.nodeName == "PrivateMailbox")
                                    outPMBNumber.value = nodeList(i).nodeValue
                            }
                            else if (nodeList(i).parentNode.nodeName == "Abbreviation")
                            {
                                if (nodeList(i).parentNode.parentNode.nodeName == "State")
                                    outState.value = nodeList(i).nodeValue
                            }
                        }
                    }
                }
            }


            function printErrorCodes(errorCodeList)
            {
                var errorArray = errorCodeList.split(',');

                for (var i = 0; i <  errorArray.length; i++)
                {
                    // Handle Records Result Codes
                    if (errorArray[i] == "AE01")
                        outAddressErrorString.value += errorArray[i] + ": Zip Code Error;  "
                    else if (errorArray[i] == "AE02")
                        outAddressErrorString.value += errorArray[i] + ": Unknown Street;  "
                    else if (errorArray[i] == "AE03")
                        outAddressErrorString.value += errorArray[i] + ": Component Error;  "
                    else if (errorArray[i] == "AE04")
                        outAddressErrorString.value += errorArray[i] + ": Non-Deliverable Address;  "
                    else if (errorArray[i] == "AE05")
                        outAddressErrorString.value += errorArray[i] + ": Address Matched to Multiple Records;  "
                    else if (errorArray[i] == "AE06")
                        outAddressErrorString.value += errorArray[i] + ": Address Matched to Early Warning System;  "
                    else if (errorArray[i] == "AE07")
                        outAddressErrorString.value += errorArray[i] + ": Empty Address Input;  "
                    else if (errorArray[i] == "AE08")
                        outAddressErrorString.value += errorArray[i] + ": Suite Range Error;  "
                    else if (errorArray[i] == "AE09")
                        outAddressErrorString.value += errorArray[i] + ": Suite Range Missing;  "
                    else if (errorArray[i] == "AE10")
                        outAddressErrorString.value += errorArray[i] + ": Primary Range Error;  "
                    else if (errorArray[i] == "AE11")
                        outAddressErrorString.value += errorArray[i] + ": Primary Range Missing;  "
                    else if (errorArray[i] == "AE12")
                        outAddressErrorString.value += errorArray[i] + ": Box Number Error from PO Box or RR;  "
                    else if (errorArray[i] == "AE13")
                        outAddressErrorString.value += errorArray[i] + ": PO Box Number Missing from PO Box or RR;  "
                    else if (errorArray[i] == "AE14")
                        outAddressErrorString.value += errorArray[i] + ": Input Address Matched to CMRA but secondary number not present;  "
            else if (errorArray[i] == "AE17")
                        outAddressErrorString.value += errorArray[i] + ": A suite number was entered but no suite information found for primary address; "


                    else if (errorArray[i] == "AS01")
                        outAddressErrorString.value += errorArray[i] + ": Address matched to postal database;  "
                    else if (errorArray[i] == "AS02")
                        outAddressErrorString.value += errorArray[i] + ": Address matched to non-postal database;  "
                    else if (errorArray[i] == "AS09")
                        outAddressErrorString.value += errorArray[i] + ": Foreign Postal Code Detected;  "
                    else if (errorArray[i] == "AS10")
                        outAddressErrorString.value += errorArray[i] + ": Address matched to CMRA;  "
                    else if (errorArray[i] == "AS11")
                        outAddressErrorString.value += errorArray[i] + ": Address Vacant;  "
                    else if (errorArray[i] == "AS12")
                        outAddressErrorString.value += errorArray[i] + ": Address deliverable by non-USPS;  "
                    else if (errorArray[i] == "AS13")
                        outAddressErrorString.value += errorArray[i] + ": Address Updated By LACS;  "
                    else if (errorArray[i] == "AS14")
                        outAddressErrorString.value += errorArray[i] + ": Address Updated By Suite Link;  "
                    else if (errorArray[i] == "AS15")
                        outAddressErrorString.value += errorArray[i] + ": Address Updated By AddressPlus;  "
            else if (errorArray[i] == "AS16")
                        outAddressErrorString.value += errorArray[i] + ": Address is vacant;  "
            else if (errorArray[i] == "AS17")
                        outAddressErrorString.value += errorArray[i] + ": Alternate delivery;  "
            else if (errorArray[i] == "AS18")
                        outAddressErrorString.value += errorArray[i] + ": Artificially created adresses detected,DPV processing terminated at this point;  "
            else if (errorArray[i] == "AS20")
                        outAddressErrorString.value += errorArray[i] + ": Address Deliverable by USPS only;  "
            else if (errorArray[i] == "AS23")
                        outAddressErrorString.value += errorArray[i] + ": Extraneous information found;  "

            else if (errorArray[i] == "AC01")
                        outAddressErrorString.value += errorArray[i] + ": ZIP Code Change;  "
            else if (errorArray[i] == "AC02")
                        outAddressErrorString.value += errorArray[i] + ": State Change;  "
            else if (errorArray[i] == "AC03")
                        outAddressErrorString.value += errorArray[i] + ": City Change;  "
            else if (errorArray[i] == "AC04")
                        outAddressErrorString.value += errorArray[i] + ": Base/Alternate Change;  "
            else if (errorArray[i] == "AC05")
                        outAddressErrorString.value += errorArray[i] + ": Alias Name Change  "
                else if (errorArray[i] == "AC06")
                        outAddressErrorString.value += errorArray[i] + ": Address1/Address2 Swap;  "
                else if (errorArray[i] == "AC07")
                        outAddressErrorString.value += errorArray[i] + ": Address1/Company Swap;  "
                else if (errorArray[i] == "AC08")
                        outAddressErrorString.value += errorArray[i] + ": Plus4 Change;  "
            else if (errorArray[i] == "AC09")
                        outAddressErrorString.value += errorArray[i] + ": Urbanization Change;  "
                else if (errorArray[i] == "AC10")
                        outAddressErrorString.value += errorArray[i] + ": Street Name Change;  "
            else if (errorArray[i] == "AC11")
                        outAddressErrorString.value += errorArray[i] + ": Street Suffix Change;  "
            else if (errorArray[i] == "AC12")
                        outAddressErrorString.value += errorArray[i] + ": Street Directional Change;  "
            else if (errorArray[i] == "AC13")
                        outAddressErrorString.value += errorArray[i] + ": Suite Name Change;  "

                }
                // DPV Match
                if (errorCodeList == "AS01,AS12")
                {
                    outAddressErrorString.value = ""
                    outAddressErrorString.value += "AS01,AS12: Input Address Matched to DPV;  "
                }
            }


            function clearOutFields()
            {
                // clear results fields
                outVersion.value = ""
                outInitResults.value = ""
                outTotal.value = ""
                outAddress1.value = ""
                outAddress2.value = ""
                outCompany.value = ""
                outCity.value = ""
                outState.value = ""
                outZip.value = ""
                outPlus4.value = ""
                outCountry.value = ""
                outRange.value = ""
                outStreetName.value = ""
                outSuffix.value = ""
                outPreDir.value = ""
                outPostDir.value = ""
                outSuiteName.value = ""
                outSuiteNumber.value = ""
                outPMBName.value = ""
                outPMBNumber.value = ""
                outUrbName.value = ""
                outUrbCode.value = ""
                outDPC.value = ""
                outDPCD.value = ""
                outCarrierRoute.value = ""
                outAddressKey.value = ""
                outCongessDistrict.value = ""
                outAddressErrorCode.value = ""
                outAddressErrorString.value = ""
            }

        </script>
</cfmodule>