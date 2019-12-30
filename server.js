'use strict';
const express = require('express');
// Constants
const PORT = 8080;
const HOST = 'localhost';
// App
const app = express();
const revision = require('child_process')
  .execSync('git rev-parse --short HEAD')
  .toString().trim()
app.get('/', (req, res) => {
res.send('<body style="background-color:black;"><font size="23" font color="white"><center>Last Commit - ' + revision + '</center></font></body>\n');
});
app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
