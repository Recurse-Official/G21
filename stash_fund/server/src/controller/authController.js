const User = require("../models/User");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const mongoose = require("mongoose");

// Signup logic
exports.signup = async (req, res) => {
  const { name, email, password } = req.body;

  try {
    // Check if user exists
    const existingUser = await User.findOne({ email });
    if (existingUser) return res.status(400).json({ message: "User already exists" });

    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Create and save new user
    const user = new User({ name, email, password: hashedPassword });
    await user.save();

    res.status(201).json({ message: "User created successfully" });
  } catch (err) {
    res.status(500).json({ error: "Internal server error" });
  }
};

exports.findUser = async (req, res) => {
  const { userId } = req.params;

  try {
    // Convert the string userId to ObjectId
    const userIdObjectId = new mongoose.Types.ObjectId(userId);

    // Find the user in the database
    const user = await User.findOne({ _id: userIdObjectId });

    if (!user) {
      return res.status(404).json({ success: false, message: 'User not found' });
    }

    // Respond with the user's name
    res.status(200).json({ success: true, name: user.name });
  } catch (error) {
    // Handle any errors (e.g., invalid ObjectId format or database issues)
    res.status(500).json({ success: false, error: error.message });
  }
};
// Login logic
exports.login = async (req, res) => {
  const { email, password } = req.body;

  try {
    // Check if user exists
    const user = await User.findOne({ email });
    if (!user) return res.status(404).json({ message: "User not found" });

    // Validate password
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) return res.status(401).json({ message: "Invalid credentials" });

    // Generate a JWT token
    // const token = jwt.sign({ id: user._id }, "your_jwt_secret", { expiresIn: "1h" });

    res.status(200).json({ token:"good token" });
  } catch (err) {
    res.status(500).json({ error: "Internal server error" });
  }
};
