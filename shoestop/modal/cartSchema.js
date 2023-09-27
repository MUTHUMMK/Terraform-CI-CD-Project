const mongoose = require('mongoose')
const users = require('./user')


const cartSchema = mongoose.Schema({
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
    quantity :  {
        type : String,
        required : true
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: users,
        required: true
    }
})


const cart = mongoose.model('cartSchema' , cartSchema)

module.exports = cart