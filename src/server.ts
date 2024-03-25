import fastify from "fastify";

const app = fastify();

const { SERVER_PORT = 3002, SERVER_HOST = "0.0.0.0" } = process.env;

app.get("/", () => {
  console.log("called hello");
  return "Hello world !!!";
});

app.listen({ port: +SERVER_PORT, host: SERVER_HOST }).then(() => {
  console.log(`listening on port ${SERVER_PORT}`);
});
