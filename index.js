const csv = require('csvtojson')

// Require algorithm implementation
const sort = require('./algorithms/insertion')

// Path to data file and column to sort on
const CSV_FILE='./datasets/ted_main.csv'
const COLUMN = 'views'

// Create an Array of Objects from the CSV file
// using the column names for the keys and the row values for the values:
//
// [
//   { col1: value1 },
//   { col2: value2 },
//   ...
// ]
let data = []
const start = new Date()

csv()
  .fromFile(CSV_FILE)
  .on('json',(jsonObj) => {
    data.push(jsonObj)
  })
  .on('done',(error) => {
    const duration = new Date() - start
    console.log('Done loading data:', data.length, 'rows', `(${duration}ms)`)
    console.log(`Available Columns: ${Object.keys(data[0])}`)

    // Call the sort algorithm with `data` and the key for the column to sort on
    sort(data, COLUMN)
  })

// Example output
// Done loading data: 2550 rows (500ms)
// Available Columns: comments,description,duration,event,film_date,languages,main_speaker,name,num_speaker,published_date,ratings,related_talks,speaker_occupation,tags,title,url,views
// Done sorting data. Lowest comments: 10, Highest comments: 992
// Took 21976 calls, or 8.618039215686274 calls per row (5ms)
