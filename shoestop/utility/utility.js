const jwt = require ('jsonwebtoken')

const generateToken = (id , name ) =>{
    return jwt.sign({id , name } , process.env.JWT_SECRET , {
        expiresIn : '1h'
    })
}

module.exports = generateToken