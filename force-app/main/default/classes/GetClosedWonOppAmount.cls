public class GetClosedWonOppAmount {
    
    @InvocableMethod(label='Opp Amount')
    public static List<Integer> getClosedWonOppAmount(List<Opportunity> opps){
        List<Integer> amount;
        if(opps == null){
            amount.add(0);
            return amount;
        } else{
            amount.add(opps.size());
            return amount;
        }
    }
}