/**
 * @description       : SOQL
 * @last modified on  : 05-07-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class SOQL {
    // Basics
    public List<Account> useSelect(){
        return [ SELECT Id, Name FROM Account WHERE Name LIKE '%United%' ORDER BY CreatedDate LIMIT 10];
    }

    public List<Account> useOffSet(){
        return [ SELECT Id, Name FROM Account ORDER BY CreatedDate LIMIT 100 OFFSET 50];
    }

    public List<Account> useInOrNotIn(){
        return [ SELECT Id, Name, NumberOfEmployees FROM Account WHERE NumberOfEmployees IN (0, 11, 12) AND NumberOfEmployees NOT IN (10, 12, 14)];
    }

    public void useForUpdate(){
        List<Account> acct = [SELECT Id FROM Account WHERE Name LIKE 'Updated%' FOR UPDATE];
    }

    public void useForView(){
        List<Account> acct = [SELECT Id FROM Account WHERE Name LIKE 'Updated%' FOR VIEW];
    }

    public void useForReference(){
        Contact ctt = [SELECT Name, ID FROM Contact  LIMIT 1 FOR REFERENCE];
    }

    public void useFormat(){
        Account acct = [SELECT Id, LastModifiedDate, FORMAT(LastModifiedDate) formattedDate FROM Account LIMIT 1];
    }

    public List<Lead> useToLabel(){
        return [SELECT Company, Status, toLabel(Status) translatedStatus FROM Lead];
    }

    // AggregateResult
    public List<AggregateResult> useGroupBy(){
        return [ SELECT CampaignId, AVG(Amount) FROM Opportunity GROUP BY CampaignId ];
    }

    public List<AggregateResult> useHaving(){
        return [ SELECT LeadSource, COUNT(Name) FROM Lead GROUP BY LeadSource HAVING COUNT(Name) > 100 ];
    }

    public List<AggregateResult> useAggregateResultSum(){
        return [ SELECT SUM(Amount) FROM Opportunity WHERE Amount > 100];
    }

    public List<AggregateResult> useAggregateResultCountDistinct(){
        return [ SELECT COUNT_DISTINCT(Name) FROM Lead WHERE Name LIKE '%A%'];
    }

    public List<AggregateResult> useGrouping(){
        return [SELECT LeadSource, Rating, GROUPING(LeadSource) grpLS, GROUPING(Rating)  grpRating,COUNT(Name) cnt FROM Lead GROUP BY ROLLUP(LeadSource, Rating)];
    }

    // Knowledge__kav
    // public void useUpdateTracking(){
    //     Knowledge__kav kav = [ SELECT Id FROM Knowledge__kav LIMIT 1 UPDATE TRACKING ];
    // }

    // public void useUpdateViewStat(){
    //     Knowledge__kav kav = [ SELECT Id FROM Knowledge__kav LIMIT 1 UPDATE VIEWSTAT ];
    // }
}