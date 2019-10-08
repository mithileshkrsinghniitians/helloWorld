@isTest
private class ThinkingInApex_DanTest
{
 static testMethod void ocrsTest()
  {
  Account acc = new Account(Name='Testing');
   insert acc;
   
   Contact con = new Contact(LastName='Test', AccountId=acc.Id);
   insert con;
   
   Opportunity opp = new Opportunity(Name='optest', StageName='Prospecting', CloseDate=Date.today(), Date_Test__c=Date.today());
   
   ThinkingInApex_Dan.associateContacts = new List<Contact>{con};
   insert opp; 
  }
   
   static testMethod void ocrsTest1()
    {
     try
      {
       Opportunity opp1 = new Opportunity(Name='optest1', StageName='Prospecting', CloseDate=Date.today());
       ThinkingInApex_Dan.associateContacts = null;
       insert opp1;
      }
      catch(Exception e){}
    }
   
}
