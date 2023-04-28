import json
import os
import sys
sys.path.append('/var/task/sa')
from joblib import load
from sklearn.cluster import KMeans

def func(event, request):
    
    request_body = json.loads(event['body'])
    #request_body = [[0.468,0.473,0.449,0.0947,0.0303,0.0,0.826],[0.994,0.262,0.0167,0.143,0.0533,0.908,0.114],[0.15,0.874,0.652,0.106,0.114,6.34E-06,0.503]]
    
    # Load the trained model from a file
    kmeans = load('/var/task/sa/spotify_kmeans_model.joblib')

    res = kmeans.predict(request_body)

    return {
        'statusCode': 200,
        'body': json.dumps({'data': res.tolist()})
    }

