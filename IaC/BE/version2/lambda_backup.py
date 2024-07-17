import boto3
import os
import json
from datetime import datetime

def lambda_handler(event, context):
    ecs_client = boto3.client('ecs')
    
    cluster = os.environ['CLUSTER']
    task_definition = os.environ['TASK_DEFINITION']
    subnet_id = os.environ['SUBNET_ID']
    
    response = ecs_client.run_task(
        cluster=cluster,
        launchType='FARGATE',
        taskDefinition=task_definition,
        networkConfiguration={
            'awsvpcConfiguration': {
                'subnets': [subnet_id],
                'assignPublicIp': 'ENABLED'
            }
        }
    )
    
    # Convert datetime objects to strings
    response_body = json.dumps(response, default=str)
    
    return {
        'statusCode': 200,
        'body': response_body
    }
