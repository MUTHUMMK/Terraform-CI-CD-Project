const express = require('express')
const app = express()
const cors = require("cors")
const dotenv = require('dotenv')
const connectDB = require('./db/connectDB')
const productRoutes = require('./routes/productRoutes')
const userRoutes = require('./routes/userRoutes')
const path = require('path');

dotenv.config()

const port = process.env.port

app.use(express.json());
app.use(cors())


app.get('/', (req,res)=>{
    res.send('hello world')
})

app.use('/' , userRoutes)
app.use('/api' , productRoutes)
app.use(express.static('public'))
app.get('*', function(req, res) {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
  });

const startServer = async ()=>{
    try{
       
        await connectDB(process.env.mongoURI)
        console.log('connected to db');
        app.listen(port , ()=>{
            console.log(`server started at ${port}`);
        })
    }
    catch(error){
        console.log(error);
    }
}


startServer()