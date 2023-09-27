const Users = require('../modal/user')
const asyncHandler = require ( "express-async-handler" );
const generateToken = require('../utility/utility');
const jwt = require("jsonwebtoken")

const signUp = asyncHandler(async (req,res) =>{
    const {name, email,password} = req.body;

    const existingUser = await Users.findOne({email})

    if(existingUser ){
        throw new Error ("User Already Exists")
    }

    const user = await Users.create({
        name,email,password 
    })

    if(user)
    {
        res.status(201).json({name : user.name,email : user.email,_id  : user._id , token : generateToken(user._id,user.name)})
    }

    
})


const login = asyncHandler (  async (req, res) => {
    const { email, password } = req.body;
  
    try {
      const user = await Users.findOne({ email });
  
      if (!user) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }
  
      const isMatch = await user.matchPassword(password);
  
      if (!isMatch) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }
  
      // Generate a JWT token
      const token = jwt.sign({ _id: user._id }, process.env.JWT_SECRET, {
        expiresIn: '1h'
      });
  
      res.json({ token });
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Something went wrong' });
    }
  } )
  

module.exports = {signUp , login}