public class GetAverageClosingTime {
	
    @InvocableMethod(label='Closing Time')
    public static List<Date> getAverageClosingTime(List<Account> accs){
        Account acc = accs.get(0);
        Date closingDate;
        Date currentDate = Date.today();
        Integer defaultMounthQuantity = 3;
        
        List<Date> closingDateList = new List<Date>();
        
        List<Opportunity> opps = [select id, name, closedate, CreatedDate, stagename from Opportunity WHERE AccountId =:acc.Id AND StageName = 'Closed Won'];
        Integer quantityOfOpps = opps.size();
        
        if(opps.isEmpty()){
            closingDate = currentDate.addMonths(defaultMounthQuantity);
            closingDateList.add(closingDate);
            return closingDateList;
        } else{
            Integer daysBetweenDates = 0;
            Integer averageClosingDays =0;
            
            for(Opportunity opp : opps){
                Date oppCreatedDate = Date.newinstance(opp.CreatedDate.year(), opp.CreatedDate.month(), opp.CreatedDate.day());
                daysBetweenDates = daysBetweenDates + opp.CloseDate.daysBetween(oppCreatedDate);
            }
            
            averageClosingDays = daysBetweenDates / quantityOfOpps;
            closingDate = currentDate.addDays(averageClosingDays);
            
            if(closingDate.monthsBetween(currentDate) > 3){
                closingDate = currentDate.addMonths(defaultMounthQuantity);
                closingDateList.add(closingDate);
            	return closingDateList;
            } else {
                closingDateList.add(closingDate);
           		return closingDateList;
            }
            
        }
    }
}