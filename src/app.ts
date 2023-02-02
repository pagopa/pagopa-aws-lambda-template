import { Context, APIGatewayProxyResult, APIGatewayEvent } from "aws-lambda";

export const handler = async (
  _event: APIGatewayEvent,
  _context: Context
): Promise<APIGatewayProxyResult> => ({
  body: JSON.stringify({
    message: "Hello, World!",
  }),
  headers: {
    "Content-Type": "application/json",
  },
  statusCode: 200,
});
