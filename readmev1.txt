//Code pour index.js

var express = require('express');
    var bodyParser = require('body-parser');
    var app = express();

    // bodyParser is a type of middleware
    // It helps convert JSON strings
    // the 'use' method assigns a middleware
    app.use(bodyParser.json({ type: 'application/json' }));

    const hostname = '127.0.0.1';
    const port = 3000;

    // http status codes
    const statusOK = 200;
    const statusNotFound = 404;

    // using an array to simulate a database for demonstration purposes
    var mockDatabase = [
        {
            category: "maths",
            title: 'Mathématiques Fondamentales',
            memberCount: 2,
            day: '15/09',
            likes: 4,
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
            place: "Starbucks Sainte Catherine",
            time : "14:00",
            imagePath: 'assets/design_course/interFace1.png',
        },

        {
            imagePath: 'assets/design_course/interFace2.png',
            title: 'Séries Chronologiques',
            memberCount: 4,
            day: '15/09',
            likes: 5,
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
            place: "Starbucks",
            time : "14:00",
        },]
       

    // Handle GET (all) request
    app.get('/', function(req, res) {
        // error checking
        if (mockDatabase.length < 1) {
            res.statusCode = statusNotFound;
            res.send('Item not found');
            return;
        }
        // send response
        res.statusCode = statusOK;
        res.send(mockDatabase);
    });

    // Handle GET (one) request
    app.get('/:id', function(req, res) {
        // error checking
        var id = req.params.id;
        if (id < 0 || id >= mockDatabase.length) {
            res.statusCode = statusNotFound;
            res.send('Item not found');
            return;
        }
        // send response
        res.statusCode = statusOK;
        res.send(mockDatabase[id]);
    });

    app.listen(port, hostname, function () {
        console.log(`Listening at http://${hostname}:${port}/...`);
    });