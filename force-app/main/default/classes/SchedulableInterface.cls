/**
 * @description       : This class implements the Schedulable interface, allowing it to be scheduled for execution in Salesforce.
 * @last modified on  : 06-24-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class SchedulableInterface implements Schedulable{
    public void execute(SchedulableContext sc){
        List<Opportunity> opportunitiesToUpdate = [
            SELECT AccountId, Id, StageName, OwnerId FROM Opportunity
            WHERE StageName = 'Closed' AND AccountId != NULL
        ];

        List<Task> tasksToInsert = new List<Task>();
        
        for(Opportunity opp : opportunitiesToUpdate) {
            Task newTask = new Task(
                Subject = 'Follow up on Closed Opportunity',
                WhatId = opp.Id,
                OwnerId = opp.OwnerId,
                Status = 'Not Started',
                Priority = 'Normal'
            );
            tasksToInsert.add(newTask);
        }
    }
}