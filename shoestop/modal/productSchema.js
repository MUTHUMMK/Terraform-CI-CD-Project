const mongoose = require('mongoose')


const productSchema = mongoose.Schema({
    image : {
        type : String,
        required : true
    },
    company :  {
        type : String,
        required : true
    },
    title :  {
        type : String,
        required : true
    },
    price :  {
        type : String,
        required : true
    },
})


const products = mongoose.model('Products' ,  productSchema)

module.exports = products