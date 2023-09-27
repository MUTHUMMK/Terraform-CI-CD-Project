const mongoose = require('mongoose')
const bcrypt = require('bcryptjs')


const userSchema = mongoose.Schema({
    name : {
        type : String,
        required : true
    },
    email : {
        type : String,
        required : true,
        unique : true
    },
    password : {
        type : String,
        required : true
    },

},
{
    timestamps : true
}
)

// saving password in the form of hash password

userSchema.pre('save' , async function (next) {
    if(!this.isModified("password"))
    {
        next()
    }
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password , salt)
})

// compare our hashpassword with given password a function method is created

userSchema.methods.matchPassword = async function ( enteredPassword ) {
    return await bcrypt.compare(enteredPassword,this.password)
}

const Users = mongoose.model('users', userSchema)

module.exports = Users