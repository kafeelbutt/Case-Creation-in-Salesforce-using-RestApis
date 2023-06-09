public class CaseWebServiceConsumer {

    // Wrapper class for the Case object
    public class CaseWrapper {
        public String Id;
        public String Subject;
        public String Description;
        public String Status;
    }

    // Response class for returning responses and status codes
    public class ResponseWrapper {
        public String message;
        public Integer statusCode;
        public Boolean success;
    }

    // Method to retrieve a Case by Id
    public static CaseWrapper getCaseById(String baseUrl, String caseId) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(baseUrl + '/services/apexrest/case/' + caseId);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            return (CaseWrapper) JSON.deserialize(response.getBody(), CaseWrapper.class);
        }
        else {
            return null;
        }
    }

    // Method to create a new Case
    public static ResponseWrapper createCase(String baseUrl, CaseWrapper cw) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(baseUrl + '/services/apexrest/case/');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        String requestBody = JSON.serialize(cw);
        request.setBody(requestBody);
        HttpResponse response = http.send(request);
        return (ResponseWrapper) JSON.deserialize(response.getBody(), ResponseWrapper.class);
    }

    // Method to update an existing Case
    public static ResponseWrapper updateCase(String baseUrl, CaseWrapper cw) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(baseUrl + '/services/apexrest/case/');
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json');
        String requestBody = JSON.serialize(cw);
        request.setBody(requestBody);
        HttpResponse response = http.send(request);
        return (ResponseWrapper) JSON.deserialize(response.getBody(), ResponseWrapper.class);
    }

    // Method to delete an existing Case
    public static ResponseWrapper deleteCase(String baseUrl, String caseId) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(baseUrl + '/services/apexrest/case/' + caseId);
        request.setMethod('DELETE');
        HttpResponse response = http.send(request);
        return (ResponseWrapper) JSON.deserialize(response.getBody(), ResponseWrapper.class);
    }
}
