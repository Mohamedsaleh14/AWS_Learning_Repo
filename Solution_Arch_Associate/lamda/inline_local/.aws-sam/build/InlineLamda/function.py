import json

def handler(event, context):
    message = 'Hello {}{}!'.format(event['first_name'], event['last_name'])
    x = {
        "Type" : "Zip Inline",
        "age" : 1
    }
    #convert into json
    y = json.dumps(x)
    print(y)
    return {
        'message': message
    }