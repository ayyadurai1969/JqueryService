<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>JSONP Service Client Page</title>
    <script src="JS/JQuery.js" type="text/javascript"></script>
    <script type="text/javascript">


        var Type;
        var Url;
        var Data;
        var ContentType;
        var DataType;
        var ProcessData;
        var method;
        //Generic function to call WCF  Service
        function CallService() {
            $.ajax({
                type: Type, //GET or POST or PUT or DELETE verb
                url: Url, // Location of the service
                data: Data, //Data sent to server
                contentType: ContentType, // content type sent to server
                dataType: DataType, //Expected data format from server
                processdata: ProcessData, //True or False
                success: function (msg) {//On Successfull service call
                    ServiceSucceeded(msg);
                },
                error: ServiceFailed// When Service call fails
            });
        }

        function ServiceFailed(result) {
            alert('test');
            alert('Service call failed: ' + result.status + '' + result.statusText);
            Type = null;
            Url = null;
            Data = null;
            ContentType = null;
            DataType = null;
            ProcessData = null;
        }


        function GetEmployee() {
            var uesrid = "1";
            Type = "GET";
            Url = "http://localhost:52136/Service1.svc/GetCustomer"; 
            DataType = "jsonp"; ProcessData = false;
            method = "GetCustomer";
            CallService();
        }

        function ServiceSucceeded(result) {
            if (DataType == "jsonp") {
                if (method == "CreateEmployee") {
                    alert(result);
                }
                else {
                    resultObject = result.GetEmployeeResult;
                    var string = result.Name + " \n " + result.Address ;
                    alert(string);
                }
            }
        }

        function ServiceFailed(xhr) {
            alert(xhr.responseText);
            if (xhr.responseText) {
                var err = xhr.responseText;
                if (err)
                    error(err);
                else
                    error({ Message: "Unknown server error." })
            }
            return;
        }

        $(document).ready(
         function () {
             try {
                 makeCall();
                 GetEmployee();
             } catch (exception) { }
         }
);


        function makeCall() {
            var proxy = new JsonpAjaxService.Service1();
                     proxy.set_enableJsonp(true);
                     proxy.GetCustomer(onSuccess, onFail, null);
                 }
                 
                 // This function is called when the result from the service call is received
                 function onSuccess(result) {
                     alert( result.Name + " " +result.Address);
                 }

                 // This function is called if the service call fails
                 function onFail() {
                     alert("Error");
                 }                 
    </script>

</head>
<body>
    <form id="form1" runat="server"> 
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="http://localhost:52136/service1.svc" />
        </Services>
    </asp:ScriptManager>
    <h1>
        JSONP Service Client Page</h1>
    </form>
</body>
</html>
