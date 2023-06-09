@RestResource(urlMapping='/case/*')
global class CaseWebService {

    // Wrapper class for the Case object
    global class CaseWrapper {
        @AuraEnabled public String Id;
        @AuraEnabled public String Subject;
        @AuraEnabled public String Description;
        @AuraEnabled public String Status;
    }

    // Response class for returning responses and status codes
    global class ResponseWrapper {
        @AuraEnabled public String message;
        @AuraEnabled public Integer statusCode;
        @AuraEnabled public Boolean success;
    }

    // Method to retrieve a Case by Id
    @HttpGet
    global static CaseWrapper getCaseById() {
        RestRequest req = RestContext.request;
        String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Case c = [SELECT Id, Subject, Description, Status FROM Case WHERE Id = :caseId];
        CaseWrapper cw = new CaseWrapper();
        cw.Id = c.Id;
        cw.Subject = c.Subject;
        cw.Description = c.Description;
        cw.Status = c.Status;
        return cw;
    }

    // Method to create a new Case
    @HttpPost
    global static ResponseWrapper createCase(CaseWrapper cw) {
        ResponseWrapper response = new ResponseWrapper();
        try {
            Case c = new Case();
            c.Subject = cw.Subject;
            c.Description = cw.Description;
            c.Status = cw.Status;
            insert c;
            response.message = 'Case created successfully.';
            response.statusCode = 200;
            response.success = true;
        }
        catch (Exception ex) {
            response.message = 'Error creating case: ' + ex.getMessage();
            response.statusCode = 500;
            response.success = false;
        }
        return response;
    }

    // Method to update an existing Case
    @HttpPut
    global static ResponseWrapper updateCase(CaseWrapper cw) {
        ResponseWrapper response = new ResponseWrapper();
        try {
            Case c = [SELECT Id, Subject, Description, Status FROM Case WHERE Id = :cw.Id];
            c.Subject = cw.Subject;
            c.Description = cw.Description;
            c.Status = cw.Status;
            update c;
            response.message = 'Case updated successfully.';
            response.statusCode = 200;
            response.success = true;
        }
        catch (Exception ex) {
            response.message = 'Error updating case: ' + ex.getMessage();
            response.statusCode = 500;
            response.success = false;
        }
        return response;
    }

    // Method to delete an existing Case
    @HttpDelete
    global static ResponseWrapper deleteCase() {
        ResponseWrapper response = new ResponseWrapper();
        try {
            RestRequest req = RestContext.request;
            String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
            Case c = [SELECT Id FROM Case WHERE Id = :caseId];
            delete c;
            response.message = 'Case deleted successfully.';
            response.statusCode = 200;
            response.success = true;
        }
        catch (Exception ex) {
            response.message = 'Error deleting case: ' + ex.getMessage();
            response.statusCode = 500;
            response.success = false;
        }
        return response;
    }
}
