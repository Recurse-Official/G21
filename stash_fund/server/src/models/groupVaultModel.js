const mongoose = require('mongoose');

const groupVaultSchema = new mongoose.Schema({
  groupVaultId: { type: String, required: true, unique: true },
  name: { type: String, required: true },
  purpose: { type: String },
  contributions: { type: Map, of: Number, default: {} },
  totalAmount: { type: Number, required: true, default: 0 },
});

module.exports = mongoose.model('GroupVault', groupVaultSchema);
