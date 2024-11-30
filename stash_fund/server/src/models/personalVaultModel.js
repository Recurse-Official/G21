const mongoose = require('mongoose');

const personalVaultSchema = new mongoose.Schema({
  userId: { type: String, required: true, unique: true },
  amount: { type: Number, required: true, default: 0 },
});

module.exports = mongoose.model('PersonalVault', personalVaultSchema);
