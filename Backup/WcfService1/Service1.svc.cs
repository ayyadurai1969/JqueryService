using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;

namespace WcfService1
{
    
    [DataContract]
    public class Customer
    {
        [DataMember]
        public string Name;

        [DataMember]
        public string Address;
    }


    [ServiceContract(Namespace = "JsonpAjaxService")]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class Service1
    {
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        public Customer GetCustomer()
        {
            return new Customer() { Name = "Pranay", Address = "1 Ahmedabad" };
        }
    }

}
