exports.handler = (event, context, callback) => {

    var responseBody = {
        "environment_1": process.env.environment_1,
        "environment_2": process.env.environment_2,
        "environment_3": process.env.environment_3

    };

    var response = {
        "statusCode": 200,
        "body": JSON.stringify(responseBody),
        "isBase64Encoded": false
    };
    callback(null, response);
};