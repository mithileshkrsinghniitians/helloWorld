public class ThinkingInApex_Dan
{
 public static List<Contact> associateContacts = null;
 public static void afterInsertOpportunity(List<Opportunity> newList, Map<ID, Opportunity> newMap)
  {
   
      if(associateContacts != null)
      {
        System.debug('associateContacts :' + associateContacts); 
        List<OpportunityContactRole> newOcr = new List<OpportunityContactRole>();
        newOcr.add(new OpportunityContactRole(ContactId = associateContacts[0].Id, OpportunityID = newList[0].ID));
        insert newOcr;
       } 
  
    List<OpportunityContactRole> ocrs = [Select Id, ContactId, IsPrimary, OpportunityID from OpportunityContactRole where OpportunityID in : newMap.keyset()];
    System.debug('OpportunityContactRole Values :' + ocrs);
    System.debug('NewMap Keyset Values :' + newMap.keyset());
    
    Set<ID> ocrOpportunities = new Set<ID>();
    for(OpportunityContactRole ocr : ocrs)
     {
      ocrOpportunities.add(ocr.OpportunityID);
      System.debug('OpportunityID :' + ocrOpportunities);
     }
     
     for(Opportunity op : newList)
      {
       if(! ocrOpportunities.contains(op.Id))
       op.addError('Opportunity Contact Role is required to create an Opportunity');
      }
  }
}
