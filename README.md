# Final Test — Time-Locked Personal Vault

## Ringkasan Project Brief

Kalian akan membangun sebuah smart contract Solidity bernama **Personal Vault** — sebuah vault yang bisa mengunci (lock) ETH untuk periode waktu tertentu. Selama periode lock tersebut berlangsung, dana yang tersimpan di vault **tidak bisa ditarik oleh siapa pun**, termasuk owner-nya sendiri, sampai `unlockTime` terlewati.

Project ini menguji pemahaman kalian tentang:
- Access control (`onlyOwner`)
- Time-based logic (`block.timestamp`)
- Handling ETH secara aman (`call{value: amount}("")`)
- Event emission untuk transparansi on-chain

---

## Yang Harus Kalian Bangun

Kontrak `PersonalVault.sol` harus memiliki 3 fungsi inti berikut:

### 1. `deposit()`
- Harus `payable`, menerima ETH yang dikirim ke kontrak.
- Emit event `Deposit` setelah dana berhasil diterima.

### 2. `withdraw()`
- Hanya boleh dipanggil oleh owner (`onlyOwner`).
- Harus mengecek bahwa `unlockTime` sudah terlewati sebelum mengizinkan penarikan.
- Mentransfer **seluruh saldo** kontrak ke owner.
- Emit event `Withdrawal` setelah penarikan berhasil.

### 3. `extendLock(uint256 newTime)`
- Hanya boleh dipanggil oleh owner (`onlyOwner`).
- `newTime` harus lebih besar dari `unlockTime` yang sedang berlaku saat ini (lock hanya boleh diperpanjang, tidak boleh dipersingkat).
- Emit event `LockExtended` setelah waktu lock berhasil diperbarui.

---

## Alur Kerja

1. Develop & test dulu di [Remix](https://remix.ethereum.org) sampai semua skenario di **Testing Checklist** di bawah lolos.
2. Baru copy kode yang sudah lolos test ke file `contracts/PersonalVault.sol` di repo ini.
3. Deploy ke **Sepolia testnet** lewat Remix (Injected Provider - MetaMask).
4. Verify kontrak di **Sepolia Etherscan**.
5. Jalankan testing sekali lagi di Sepolia, catat hash transaksi untuk:
   - Deposit
   - Failed withdrawal (kepagian / sebelum unlock)
   - Successful withdrawal (setelah unlock)
6. Isi bagian **Deployment Info** di README ini dengan data kontrak kalian.
7. Commit & push, lalu submit link repo ke form pengumpulan tugas.

---

## Testing Checklist

- [ ] Deploy dengan `unlockTime` = 5 menit dari sekarang
- [ ] Deposit 1 ETH → sukses, emit `Deposit` event
- [ ] Coba withdraw sebelum waktunya → revert `FundsLocked()`
- [ ] `extendLock` ke waktu lebih lama → sukses
- [ ] Coba `extendLock` ke waktu lebih pendek → gagal
- [ ] Majukan waktu, withdraw sebagai owner → sukses, terima semua ETH
- [ ] Coba withdraw lagi → gagal (saldo kosong)

---

## Common Pitfalls

- Jangan izinkan unlock time di masa lalu saat deploy.
- Jangan izinkan non-owner melakukan withdraw.
- Jangan izinkan lock time dipersingkat lewat `extendLock`.
- Jangan pakai `transfer()` atau `send()` — pakai `call{value: amount}("")`.
- Jangan lupa emit event di setiap perubahan state.

---

## Deployment Info

> Isi bagian ini setelah kontrak kalian ter-deploy dan ter-verify di Sepolia.

- **Nama & NIM:** Julian Hernan 241011402669
- **Contract Address (Sepolia):** 0x070D82508aC07b569f61E55610E9d69777AAAcc6
- **Etherscan Verified Link:** https://sepolia.etherscan.io/address/0x070D82508aC07b569f61E55610E9d69777AAAcc6
- **Unlock Time (deploy awal):** 1783788600
- **Tx Hash — Deposit:** 0x5553e51777f005e12460691b6c952c0318efbe63caf6c8e466a56e45052b9246
- **Tx Hash — Failed Withdrawal (sebelum unlock):** 0x564bcd256fda6304fa2870e9151ef9f56fc5d9ff4f5625cf214ceb99c06dda4a
- **Tx Hash — Successful Withdrawal (setelah unlock):** 0x23422ddbafc00ce815185e07f97fa2cf0a87f4c11a2151ad580de55bb0a392bb
