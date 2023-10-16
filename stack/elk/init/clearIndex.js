const axios = require('axios');
const { CronJob } = require('cron');

async function clearIndex(host, port) {
    try {
        const url = `http://${process.env.HOST || host}:${process.env.PORT || port}/cars-backend/_delete_by_query`
        await axios.post(url, {
            "query": {
              "range": {
                "@timestamp": {
                  "time_zone": "+03:00",   
                  "lte": "now-12h"
                }
              }
            }
          }, 
        {
            auth: {
                username: 'elastic',
                password: 'changeme'
            }
        })
    } catch (err) {
        console.log('Clear index error', err)
    }
}

async function main() {
    const job = new CronJob(
        '0 */6 * * *',
        async function () {
            console.log('Clear index')
            await clearIndex('localhost', 9200)
        },
        null,
        true,
        'Europe/Moscow'
    )
}

main();