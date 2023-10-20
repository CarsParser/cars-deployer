const axios = require('axios');

async function createIndex(host, port) {
  const url = `http://${process.env.HOST || host}:${process.env.PORT || port}/cars-backend`

  try {
    await axios.put(url, {
      "mappings": {
        "properties": {
          "log_level": { type: "text" },
          "log_time": { type: "text" },
          "logger_type": { type: "text" },
          "message": { type: "text" },
          "payload": {
            "type": "flattened"
          },
          "service_name": { type: "text" },
          "error_name": { type: "text" },
          "error_message": { type: "text" },
          "error_trace": { type: "text" },
          "err_data": {
            "type": "flattened"
          },
        }
      }
    }, {
      auth: {
        username: 'elastic',
        password: 'changeme'
      }
    })
  } catch (err) {
    console.log('Unable to create index', err)
  }
}

async function main() {
  await createIndex('158.160.127.142', 9200);
}

main()