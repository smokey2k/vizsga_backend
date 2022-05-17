require('dotenv').config();
const express = require('express');
const mysql = require('mysql');
const cors = require('cors');
const app = new express();

// 8. feladat
app.use(cors())

var pool = mysql.createPool({
    connectionLimit: 10,
    host: process.env.DBHOST,
    user: process.env.DBNAME,
    password: process.env.DBPASS,
    database: process.env.DBNAME
});

// User login checking
app.post('/login', (req, res) => {
    let data = {
        email: req.body.email,
        pass: req.body.passwd,
        table: req.body.table
    }
    pool.query(`SELECT * FROM ${data.table} WHERE email=? AND jelszo=?`, [data.email, data.pass], (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});


// SELECT ALL RECORDS FROM :table
app.get('/:table', (req, res) => {
    let table = req.params.table;
    pool.query(`SELECT * FROM ${table}`, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

// SELECT ONE RECORD FROM :table
app.get('/:table/:field/:id', (req, res) => {
    let table = req.params.table;
    let field = req.params.field;
    let id = req.params.id;
    pool.query(`SELECT * FROM ${table} WHERE ${field}='${id}'`, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});



// INSERT RECORD TO :table
app.post('/:table', (req, res) => {
    let table = req.params.table;
    let data = req.body;

    let fields = 'ID';
    results = Object.keys(data);
    results.forEach(element => {
        fields += ',' + element;
    });

    let str = '';
    results = Object.values(data);
    results.forEach(element => {
        str += ',"' + element + '"';
    });

    pool.query(`INSERT INTO ${table} (${fields}) VALUES(null ${str})`, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

// UPDATE RECORD IN :table
app.patch('/:table/:id', (req, res) => {
    let table = req.params.table;
    let id = req.params.id;
    let data = req.body;

    let str = '';
    fields = Object.keys(data);
    results = Object.values(data);

    for (let i = 0; i < fields.length; i++) {
        str += fields[i] + '="' + results[i] + '",';
    }

    str = str.substring(0, str.length - 1);

    pool.query(`UPDATE ${table} SET ${str} WHERE ID=${id}`, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

// DELETE ONE RECORD FROM :table
app.delete('/:table/:id', (req, res) => {
    let table = req.params.table;
    let id = req.params.id;
    pool.query(`DELETE FROM ${table} WHERE ID=${id}`, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

// DELETE ALL RECORD FROM :table
app.delete('/:table', (req, res) => {
    let table = req.params.table;
    pool.query(`DELETE FROM ${table}`, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});


// 5. feladat
const port = process.env.PORT;
const hostname = '127.0.0.1';
const http = require('http');

const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello!');
  });
  
  server.listen(port, hostname, () => {
    console.log(`Server listening on port ${port}...`);
  });