require('dotenv').config();


const express = require('express');
const bodyParser = require('body-parser');
const { MongoClient } = require('mongodb');

const app = express();
const PORT = 3000;

// Middleware
app.use(bodyParser.json());

const MONGO_URL = "mongodb+srv://Bridgeadmin:bGWgFxaRCPwkhRIE@bridgeplate.jb4bkqh.mongodb.net/BridgePlate?retryWrites=true&w=majority"; // replace with your MongoDB connection string
let db;

// Connect to MongoDB once when the server starts
MongoClient.connect(MONGO_URL, { useUnifiedTopology: true }, (err, client) => {
    if (err) {
        console.error('Failed to connect to MongoDB', err);
        process.exit(1);
    }
    console.log('Connected to MongoDB');
    db = client.db('BridgePlate'); // if a specific db name is needed, use db('YOUR_DB_NAME')
});

// Endpoint to trigger notifications (just a stub for now)
app.post('/sendNotificationsToDonees', async (req, res) => {
    try {
        const doneesCollection = db.collection('Donee');
        const donees = await doneesCollection.find({}).toArray();

        // You'd typically fetch the tokens from the donees and send push notifications here

        res.status(200).send('Notifications sent!');
    } catch (err) {
        console.error('Error sending notifications:', err);
        res.status(500).send('Internal Server Error');
    }
});

app.listen(PORT, () => {
    console.log(`Server started on http://localhost:${PORT}`);
});
