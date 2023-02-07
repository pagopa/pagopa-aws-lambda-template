import { Context, APIGatewayProxyResult, APIGatewayEvent } from "aws-lambda";

export const handler = async function (_event: APIGatewayEvent, _context: Context): Promise<APIGatewayProxyResult> {
  console.log("I am a Lambda function!")
  return {
    body: JSON.stringify({ message: "Hi there! I am a Lambda function!" }),
    headers: { "Content-Type": "application/json" },
    statusCode: 200,
  }
};
